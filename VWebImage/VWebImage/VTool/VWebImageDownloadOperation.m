//
//  VWebImageDownloadOperation.m
//  VWebImage
//
//  Created by wang on 2020/1/3.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import "VWebImageDownloadOperation.h"
#import "NSString+VAdd.h"
#import <UIKit/UIKit.h>

@interface VWebImageDownloadOperation ()
@property (nonatomic, readwrite, getter=isExecuting) BOOL executing;
@property (nonatomic, readwrite, getter=isFinished) BOOL finished;
@property (nonatomic, readwrite, getter=isCancelled) BOOL cancelled;
@property (nonatomic, readwrite, getter=isStarted) BOOL started;
@property (nonatomic, strong) NSRecursiveLock *lock;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) VDownCompleteHandle completeHandle;
@property (nonatomic, copy) NSString *title;

@end

@implementation VWebImageDownloadOperation
// 因为父类的属性是Readonly的，重载时如果需要setter的话则需要手动合成。
@synthesize executing = _executing;
@synthesize finished = _finished;
@synthesize cancelled = _cancelled;

- (instancetype)initWithDownloadImageUrl:(NSString *)urlString completeHandle:(VDownCompleteHandle)completeHandle title:(NSString *)title{
    if (self = [super init]) {
        _urlString = urlString;
        _executing = NO;
        _finished  = NO;
        _cancelled = NO;
        _lock      = [NSRecursiveLock new];
        _completeHandle = completeHandle;
        _title = title;
    }
    return self;
}

- (void)start{
    @autoreleasepool{
        [_lock lock];
        self.started = YES;
        [NSThread sleepForTimeInterval:1.5];
        VLog(@"下载 %@",self.title);
        if (self.cancelled) {
            VLog(@"取消下载 %@",self.title);
            return;
        }
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data) {
            VLog(@"下载完成: %@",self.title);
            [data writeToFile:[self.urlString getDowloadImagePath] atomically:YES];
            [self done];
            self.completeHandle(data,self.urlString);
        }else{
            VLog(@"下载图片失败");
        }
        [_lock unlock];
    }
}

- (void)done{
    self.finished = YES;
    self.executing = NO;
}


/**
 取消操作的方法 --- 需要进行判断
 */
- (void)cancel{
    
    [_lock lock];
    if (![self isCancelled]) {
        [super cancel];
        self.cancelled = YES;
        if ([self isExecuting]) {
            self.executing = NO;
        }
        if (self.started) {
            self.finished = YES;
        }
    }
    [_lock unlock];
}

#pragma mark - setter -- getter

- (BOOL)isExecuting {
    [_lock lock];
    BOOL executing = _executing;
    [_lock unlock];
    return executing;
}

- (void)setFinished:(BOOL)finished {
    [_lock lock];
    if (_finished != finished) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = finished;
        [self didChangeValueForKey:@"isFinished"];
    }
    [_lock unlock];
}

- (BOOL)isFinished {
    [_lock lock];
    BOOL finished = _finished;
    [_lock unlock];
    return finished;
}

- (void)setCancelled:(BOOL)cancelled {
    [_lock lock];
    if (_cancelled != cancelled) {
        [self willChangeValueForKey:@"isCancelled"];
        _cancelled = cancelled;
        [self didChangeValueForKey:@"isCancelled"];
    }
    [_lock unlock];
}

- (BOOL)isCancelled {
    [_lock lock];
    BOOL cancelled = _cancelled;
    [_lock unlock];
    return cancelled;
}
- (BOOL)isConcurrent {
    return YES;
}
- (BOOL)isAsynchronous {
    return YES;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"isExecuting"] ||
        [key isEqualToString:@"isFinished"] ||
        [key isEqualToString:@"isCancelled"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

@end
