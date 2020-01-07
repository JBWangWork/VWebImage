//
//  VViewModel.m
//  VWebImage
//
//  Created by wang on 2020/1/2.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import "VViewModel.h"
#import "VModel.h"

@implementation VViewModel
- (instancetype)initWithBlock:(SuccessBlock __nullable)successBlock fail:(FailBlock __nullable)failBlock{
    if (self = [super init]) {
        _successBlock = successBlock;
        _failBlock    = failBlock;
        [self loadData];
    }
    return self;
}

- (void)loadData{
    NSArray *temArray = @[
    @{@"imageUrl":@"http://c.hiphotos.baidu.com/image/h%3D300/sign=f60add2afc1f3a2945c8d3cea924bce3/fd039245d688d43ffdcaed06711ed21b0ff43be6.jpg",@"title":@"典雅的教堂",@"money":@"¥10000"},    @{@"imageUrl":@"http://e.hiphotos.baidu.com/image/h%3D300/sign=0708e32319ce36d3bd0485300af23a24/fcfaaf51f3deb48fd0e9be27fc1f3a292cf57842.jpg",@"title":@"西湖美女",@"money":@"¥6666"},
        @{@"imageUrl":@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=240111376,3607275229&fm=27&gp=0.jpg",@"title":@"优美海景",@"money":@"¥1"},
        @{@"imageUrl":@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=240111376,3607275229&fm=27&gp=0.jpg",@"title":@"优美海景",@"money":@"¥6"},
        @{@"imageUrl":@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1706218755,2318976317&fm=27&gp=0.jpg",@"title":@"高清无码美女",@"money":@"¥sixsixsixsix"},
        @{@"imageUrl":@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2444259859,2134277926&fm=27&gp=0.jpg",@"title":@"深沉匹若曹",@"money":@"¥8888"},
        @{@"imageUrl":@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4238908152,1331251418&fm=27&gp=0.jpg",@"title":@"毛笔执念",@"money":@"¥168"},
        @{@"imageUrl":@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3883091698,1281039100&fm=27&gp=0.jpg",@"title":@"简约蒲苇",@"money":@"¥1314"},
        @{@"imageUrl":@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3883091698,1281039100&fm=27&gp=0.jpg",@"title":@"简约蒲苇",@"money":@"15亿贝利"},
        @{@"imageUrl":@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4268933294,4214121798&fm=27&gp=0.jpg",@"title":@"高清玉米棒子",@"money":@"¥0.5"},
        @{@"imageUrl":@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=494981087,201331892&fm=27&gp=0.jpg",@"title":@"五彩星星",@"money":@"¥267"},
        @{@"imageUrl":@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2255216145,2300317876&fm=27&gp=0.jpg",@"title":@"欧豪篮球",@"money":@"¥免费"},
        @{@"imageUrl":@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3023900356,2704941131&fm=27&gp=0.jpg",@"title":@"渣男",@"money":@"¥-600"},
        @{@"imageUrl":@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3292047668,2543434291&fm=27&gp=0.jpg",@"title":@"姑娘走了",@"money":@"¥3678"},
        @{@"imageUrl":@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=138591535,3556328424&fm=27&gp=0.jpg",@"title":@"简约dog",@"money":@"¥4589"},
        @{@"imageUrl":@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=138591535,3556328424&fm=27&gp=0.jpg",@"title":@"简约dog",@"money":@"¥4589"},
        @{@"imageUrl":@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=138591535,3556328424&fm=27&gp=0.jpg",@"title":@"简约dog",@"money":@"¥4589"},
        @{@"imageUrl":@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=138591535,3556328424&fm=27&gp=0.jpg",@"title":@"简约dog",@"money":@"¥4589"},
        @{@"imageUrl":@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=632034377,1155764629&fm=27&gp=0.jpg",@"title":@"可爱超人",@"money":@"¥32898"},
        @{@"imageUrl":@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=632034377,1155764629&fm=27&gp=0.jpg",@"title":@"可爱超人",@"money":@"¥32898"},
        
  ];
    
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i<temArray.count; i++) {
        NSDictionary *dict = temArray[i];
        VModel *model     = [[VModel alloc] init];
        model.imageUrl     = dict[@"imageUrl"];
        model.title        = dict[@"title"];
        model.money        = dict[@"money"];
        [mArray addObject:model];
    }
    
    if (self.successBlock) {
        self.successBlock(mArray);
    }
}
@end
