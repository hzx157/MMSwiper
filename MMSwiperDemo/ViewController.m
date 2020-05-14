//
//  ViewController.m
//  MMSwiperDemo
//
//  Created by xiaowu on 2020/4/15.
//  Copyright © 2020 Huangzhenxiang. All rights reserved.
//

#import "ViewController.h"
#import "MMSwiper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()<MMSwiperDelegate>
@property (nonatomic,strong) MMSwiper *carouselView;
@end

@implementation ViewController

- (void)viewDidLoad {
       [super viewDidLoad];
    
       _carouselView = [[MMSwiper alloc]initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 200)];
        _carouselView.delegate = self;
        [self.view addSubview:_carouselView];
       _carouselView.models = [self setupDataModels];
    
    
        MMSwiper*m1View = [[MMSwiper alloc]initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 200)];
        m1View.delegate = self;
        m1View.isAuto = YES; //设置自动播放
        m1View.isInfinite = YES;  //设置是否无限循环
        m1View.pageMode = MMSwiperPageModeBottomRight; //设置page的位置
        m1View.pageBottomSpacing = 20.0f; //设置到底部的距离
        m1View.timeInterval = 4.0f; //设置播放时间
        m1View.currentPageIndicatorTintColor = [UIColor blueColor];
        m1View.pageIndicatorTintColor = [UIColor lightTextColor];
        [self.view addSubview:m1View];
        m1View.models = [self setupDataModels]; //自己可以设定，传什么数组都可以
       
       MMSwiper*m2View = [[MMSwiper alloc]initWithFrame:CGRectMake(0, 520, self.view.bounds.size.width, 200)];
       m2View.delegate = self;
       m2View.isInfinite = YES;  //设置是否无限循环
       m2View.pageMode = MMSwiperPageModeBottomLeft; //设置page的位置
       m2View.pageBottomSpacing = 30.0f; //设置到底部的距离
       m2View.placeHolderImage = [UIImage imageNamed:@"组54"];
       [self.view addSubview:m2View];
       m2View.models = [self setupDataModels];
    
    
}



#pragma mark-------MMSwiper delegate
- (void)swiper:(MMSwiper *)swiper didSelectItemAtIndex:(NSInteger)index toModel:(MMSwiperModel *)model {
    NSLog(@"点击了-%ld",index);
}

- (void)swiper:(MMSwiper *)swiper forItemAtIndex:(NSInteger)index toModel:(MMSwiperModel *)model toCell:(MMSwiperCell *)cell {
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:nil];
}

-(NSMutableArray *)setupDataModels{
        
    NSMutableArray * dataSource = [NSMutableArray arrayWithCapacity:4];
    [dataSource addObject:[[MMSwiperModel alloc]initWithUrl:@"https://t1.hxzdhn.com/uploads/tu/202003/9999/50ff460659.jpg"]];
    [dataSource addObject:[[MMSwiperModel alloc]initWithUrl:@"https://t1.hxzdhn.com/uploads/tu/202003/9999/f876ab9777.jpg"]];
    [dataSource addObject:[[MMSwiperModel alloc]initWithUrl:@"https://t1.hxzdhn.com/uploads/tu/202003/9999/d056be13c8.jpg"]];
    [dataSource addObject:[[MMSwiperModel alloc]initWithUrl:@"https://t1.hxzdhn.com/uploads/tu/202003/9999/43862647ba.jpg"]];
        
    return dataSource;
        
}


@end



@interface MMSwiperModel()

@end

@implementation MMSwiperModel
-(NSString *)placeholderImage{
    if(!_placeholderImage){
        _placeholderImage = @"";
    }
    return _placeholderImage;
}
-(instancetype)initWithUrl:(NSString *)url{
    return  [self initWithUrl:url title:@""];
}
-(instancetype)initWithUrl:(NSString *)url title:(NSString *)title{
    if(self = [super init]){
        self.url = url;
        self.title = title;
       }
       return self;
}

@end
