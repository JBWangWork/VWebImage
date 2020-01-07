//
//  VWebImageManager.m
//  VWebImage
//
//  Created by wang on 2020/1/3.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import "VWebImageManager.h"
#import "VWebImageDownloadOperation.h"
#import "NSString+VAdd.h"

@interface VWebImageManager()
//下载队列
@property (nonatomic, strong) NSOperationQueue *queue;
//缓存图片字典----可用数据库替换
@property (nonatomic, strong) NSMutableDictionary *imageCacheDict;
//缓存操作字典
@property (nonatomic, strong) NSMutableDictionary *operationDict;
//记录之前没有进去的操作 回调
@property (nonatomic, strong) NSMutableDictionary *handleDict;
@property (nonatomic, copy) VCompleteHandle completeHandle;
@end

@implementation VWebImageManager
+ (instancetype)sharedManager {
    static VWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VWebImageManager alloc] init];
    });
    return manager;
}

// 只要调用单利,就会来到这里 可以在这里做一系列的初始化
- (instancetype)init {
    if (self=[super init]) {
        
        self.queue.maxConcurrentOperationCount = 2;
        // 注册内存警告通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

/**
 图片下载方法
 */
- (void)downloadImageWithUrlString:(NSString *)urlString completeHandle:(VCompleteHandle)completeHandle title:(NSString *)title {
    //内存获取图片
    UIImage *cacheImage = self.imageCacheDict[urlString];
    if (cacheImage) {
        VLog(@"从内存缓存获取数据 %@",title);
        completeHandle(cacheImage,urlString);
        return;
    }
    //沙盒获取图片
    NSString *cachePath = [urlString getDowloadImagePath];
    cacheImage = [UIImage imageWithContentsOfFile:cachePath];
    if (cacheImage) {
        VLog(@"从沙盒缓存获取数据 %@",title);
        //沙盒图片 存入缓存
        [self.imageCacheDict setObject:cacheImage forKey:urlString];
        completeHandle(cacheImage,urlString);
        return ;
    }
    //对当前下载图片判断,是否需要创建操作
    if (self.operationDict[urlString]) {
        VLog(@"正在下载的回调Block %@的%@",title,completeHandle);
        NSMutableArray *mArray = self.handleDict[urlString];
        if (mArray == nil) {
            mArray = [NSMutableArray arrayWithCapacity:1];
        }
        [mArray addObject:completeHandle];
        [self.handleDict setObject:mArray forKey:urlString];
        return;
    }
    // 创建操作 下载 --- 自定义
    VWebImageDownloadOperation *downOp = [[VWebImageDownloadOperation alloc] initWithDownloadImageUrl:urlString completeHandle:^(NSData * _Nonnull imageData, NSString * _Nonnull v_urlString) {
        UIImage *downloadImage = [UIImage imageWithData:imageData];
        if (downloadImage) {
            [self.imageCacheDict setObject:downloadImage forKey:urlString];
            [self.operationDict removeObjectForKey:urlString];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completeHandle(downloadImage, v_urlString);
                // 去取回调
                if (self.handleDict[v_urlString]) {
                    NSMutableArray *mArray = self.handleDict[v_urlString];
                    for (VCompleteHandle completeHandle in mArray) {
                        completeHandle(downloadImage, v_urlString);
                    }
                    [self.handleDict removeObjectForKey:urlString];
                }
            }];
        }
    } title:title];
    // 操作加入队列
    [self.queue addOperation:downOp];
    // 操作缓存
    [self.operationDict setObject:downOp forKey:urlString];
}

// 下载操作取消
- (void)cancelDownloadImageWithUrlString:(NSString *)urlString{
    [self.operationDict removeObjectForKey:urlString];
    [self.handleDict removeObjectForKey:urlString];
    VWebImageDownloadOperation *op = self.operationDict[urlString];
    [op cancel];
}

#pragma mark - lazy

- (NSMutableDictionary *)imageCacheDict{
    if (!_imageCacheDict) {
        _imageCacheDict = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _imageCacheDict;
}

- (NSMutableDictionary *)operationDict{
    if (!_operationDict) {
        _operationDict = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _operationDict;
}

- (NSMutableDictionary *)handleDict{
    if (!_handleDict) {
        _handleDict = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _handleDict;
}

- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

#pragma mark - memoryWarning
- (void)memoryWarning {
    VLog(@"收到内存警告,你要清理内存了!!!");
    // 内存
    [self.imageCacheDict removeAllObjects];
    //已经有内存警告就不能在执行操作
    [self.queue cancelAllOperations];
    //清空操作
    [self.operationDict removeAllObjects];
    //操作缓存也清除
    [self.handleDict removeAllObjects];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}
@end
