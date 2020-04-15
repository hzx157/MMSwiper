## MMSwiper
[![Pod Version](http://img.shields.io/cocoapods/v/MMSwiper.svg?style=flat)](http://cocoadocs.org/docsets/MMSwiper/)
[![Pod Platform](http://img.shields.io/cocoapods/p/MMSwiper.svg?style=flat)](http://cocoadocs.org/docsets/MMSwiper/)
[![Pod License](http://img.shields.io/cocoapods/l/SDWebImage.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)

##
* 基于UICollectionView的无限轮播图
* 利用UICollectionView的原理减少性能消耗
* 代码统计14kb，超小以及超轻级量
* 调用简洁

## 基本属性

```
@property (nonatomic, assign) UIViewContentMode mm_contentMode; //设置图片的模式

@property (nonatomic, strong) NSMutableArray <MMSwiperModel*> *models; //数组源

@property (nonatomic, strong) UIColor *pageIndicatorTintColor;  //page正常颜色

@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor; //page滑动颜色

@property (nonatomic, assign) CGFloat pageBottomSpacing; // page距离底部的距离 默认10

@property (nonatomic, assign) BOOL isInfinite; // 是否启动无限循环  默认NO

@property (nonatomic, assign) BOOL isAuto; // 是否启动自动翻动  默认NO

@property (nonatomic, assign) NSTimeInterval timeInterval; //默认是3.0f

@property (nonatomic, assign) MMSwiperPageMode pageMode; //默认是MMSwiperPageModeBottomCenter

```

## 如何使用
```
  MMSwiper* swiper= [[MMSwiper alloc]init];
  swiper.delegate = self;
  [self.view addSubview: swiper];
  swiper.models = ...//创建MMSwiperModel的数组;

```


## Installation with CocoaPods

`pod "MMSwiper"
`



## screenshots
![](image/C428F762-5C65-4100-936A-5783B75217EF.png)
