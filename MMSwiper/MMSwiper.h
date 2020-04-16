//
//  HYICarousel.h
//  HUYUAnchor
//
//  Created by xiaowu on 2020/4/10.
//  Copyright © 2020 Huangzhenxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MMSwiperPageMode) {
    MMSwiperPageModeBottomCenter, //默认下方居中
    MMSwiperPageModeBottomLeft,  //居下左
    MMSwiperPageModeBottomRight,  //居下右
};


@class MMSwiper,MMSwiperCell;
@protocol MMSwiperDelegate <NSObject>

-(void)swiper:(MMSwiper *)swiper didSelectItemAtIndex:(NSInteger)index toModel:(id)model;

@required
-(void)swiper:(MMSwiper *)swiper forItemAtIndex:(NSInteger)index toModel:(id)model toCell:(MMSwiperCell *)cell;
@end

@interface MMSwiper : UIView
@property (nonatomic,strong,readonly) UICollectionView *collectionView;
@property (nonatomic, weak) id<MMSwiperDelegate> delegate;
@property (nonatomic, assign) UIViewContentMode mm_contentMode; //设置图片的模式
@property (nonatomic, strong) NSMutableArray *models; //数组源
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;  //page正常颜色
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor; //page滑动颜色
@property (nonatomic, assign) CGFloat pageBottomSpacing; // page距离底部的距离 默认10
@property (nonatomic, assign) BOOL isInfinite; // 是否启动无限循环  默认NO
@property (nonatomic, assign) BOOL isAuto; // 是否启动自动翻动  默认NO
@property (nonatomic, assign) NSTimeInterval timeInterval; //默认是3.0f
@property (nonatomic, assign) MMSwiperPageMode pageMode; //默认是MMSwiperPageModeBottomCenter
@property (nonatomic, strong) UIPageControl *pageControl; //自行设置
@property (nonatomic,copy) void (^didSelectItemAtIndexBlock)(id model,NSInteger index); //回调
@end


@interface MMSwiperCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@end

@interface MMSwiperCollectionViewFlowLayout:UICollectionViewFlowLayout
@end
