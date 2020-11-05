//
//  HYICarousel.m
//  HUYUAnchor
//
//  Created by xiaowu on 2020/4/10.
//  Copyright © 2020 Huangzhenxiang. All rights reserved.
//

#import "MMSwiper.h"
@interface MMSwiper()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong,readwrite) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIImageView *placeHolderImageView;
@end

@implementation MMSwiper

-(instancetype)init{
    if(self = [super init]){
        [self setup];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setup];
    }
    return self;
}

-(void)setup{
    
    MMSwiperCollectionViewFlowLayout *layou = [[MMSwiperCollectionViewFlowLayout alloc]init];
    layou.minimumLineSpacing = 0.01f;
    layou.minimumInteritemSpacing = 0.01f;
    layou.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layou.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layou];
    collectionView.pagingEnabled = YES;
    collectionView.alwaysBounceHorizontal = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = self.backgroundColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[MMSwiperCell class] forCellWithReuseIdentifier:@"setupCateCollectionView"];
    [self addSubview:collectionView];
    _collectionView = collectionView;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[collectionView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(collectionView,self)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[collectionView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(collectionView,self)]];
    
    self.mm_contentMode = UIViewContentModeScaleAspectFill;
    
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.hidesForSinglePage = YES;
    [self addSubview:_pageControl];
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_pageControl(==20)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageControl,self)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_pageControl]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageControl,self)]];
    
    self.placeHolderImageView = [[UIImageView alloc]init];
    self.placeHolderImageView.clipsToBounds = YES;
    self.placeHolderImageView.hidden = YES;
    [self addSubview:self.placeHolderImageView];
    self.placeHolderImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_placeHolderImageView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_placeHolderImageView,self)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_placeHolderImageView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_placeHolderImageView,self)]];
    
    
    [self layoutIfNeeded];

    
}

-(void)setModels:(NSArray *)models{
    _models = models;
    if(models.count > 0){
        self.pageControl.numberOfPages = models.count;
        [self.dataSource removeAllObjects];
        
        if(self.isInfinite)
            [self.dataSource addObjectsFromArray:models];
        
        [self.dataSource addObjectsFromArray:models];
    }
    self.placeHolderImageView.hidden = models.count > 0;
    [self.collectionView reloadData];
}


- (void)setMm_contentMode:(UIViewContentMode)mm_contentMode{
    _mm_contentMode = mm_contentMode;
    self.placeHolderImageView.contentMode = mm_contentMode;
}
- (void)setPlaceHolderImage:(UIImage *)placeHolderImage{
    _placeHolderImage = placeHolderImage;
    self.placeHolderImageView.image = placeHolderImage;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MMSwiperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"setupCateCollectionView" forIndexPath:indexPath];
    if(!cell){
        cell = [[MMSwiperCell alloc]init];

    }
    cell.imageView.contentMode = self.mm_contentMode;
    id model = self.dataSource[indexPath.item];
    if([self.delegate respondsToSelector:@selector(swiper:forItemAtIndex:toModel:toCell:)]){
        [self.delegate swiper:self forItemAtIndex:[self infiniteRow:indexPath.item] toModel:model toCell:cell];
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetx = scrollView.contentOffset.x;
    NSInteger page = offsetx/scrollView.frame.size.width;
    if(floorf(page) == self.models.count){
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetx = scrollView.contentOffset.x;
    CGFloat page = offsetx/scrollView.frame.size.width;
    self.pageControl.currentPage = [self infiniteRow:floorf(page)];
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    if(self.didSelectItemAtIndexBlock){
        self.didSelectItemAtIndexBlock(self.dataSource[indexPath.item], indexPath.item);
    }
    
    if([self.delegate respondsToSelector:@selector(swiper:didSelectItemAtIndex:toModel:)]){
        [self.delegate swiper:self didSelectItemAtIndex:[self infiniteRow:indexPath.item] toModel:self.dataSource[indexPath.item]];
    }
}

-(NSInteger)infiniteRow:(NSInteger )item{
    
    NSInteger row = self.models.count;
    if(self.isInfinite){
        if(item >= row){
            row = item - row;
        }else{
            row = item;
        }
    }else{
        row = item;
    }
    
    return row;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(NSMutableArray *)dataSource{
    if(!_dataSource){
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize pointSize = [self.pageControl sizeForNumberOfPages:self.models.count];
    switch (self.pageMode) {
        case MMSwiperPageModeBottomLeft:
        {
            self.pageControl.frame = CGRectMake(self.pageBottomSpacing,self.frame.size.height-self.pageControl.frame.size.height-self.pageBottomSpacing, pointSize.width, pointSize.height);

        }
            break;
        case MMSwiperPageModeBottomRight:
        {
            self.pageControl.frame = CGRectMake(self.frame.size.width-pointSize.width-self.pageBottomSpacing,self.frame.size.height-self.pageControl.frame.size.height-self.pageBottomSpacing, pointSize.width, pointSize.height);
        }
            break;

        default:
            break;
    }

}
-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
-(void)setPageBottomSpacing:(CGFloat)pageBottomSpacing{
    _pageBottomSpacing = pageBottomSpacing;
    
    [self.constraints enumerateObjectsUsingBlock:^( NSLayoutConstraint *  obj, NSUInteger idx, BOOL *  stop) {
        
        if([obj.secondItem isKindOfClass:[self.pageControl class]]&&(obj.secondAttribute ==NSLayoutAttributeBottom)){
            obj.constant = pageBottomSpacing;
        }
        
    }];
    [self layoutIfNeeded];

}
-(void)setPageMode:(MMSwiperPageMode)pageMode{
    _pageMode = pageMode;

    [self layoutIfNeeded];
}
//无限循环
-(void)setIsInfinite:(BOOL)isInfinite{
    _isInfinite = isInfinite;
    
}

//自播放
-(void)setIsAuto:(BOOL)isAuto{
    _isAuto = isAuto;
    if(isAuto){
        
        if(self.timeInterval == 0)
            self.timeInterval = 3;

        typeof(self) __weak weakSelf = self;
        if(self.timer){
            [self.timer invalidate];
            self.timer = nil;
        }
        if (@available(iOS 10.0, *)) {
            self.timer = [NSTimer timerWithTimeInterval:self.timeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
                
                NSIndexPath *indexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
                NSInteger item = indexPath.item+1;
                if(indexPath.item >= weakSelf.dataSource.count){
                    item = 0;
                }
                [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:indexPath.section] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            }];
        }
        [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}

-(void)setTimeInterval:(NSTimeInterval)timeInterval{
    _timeInterval = timeInterval;
    self.isAuto = YES;
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
}

-(void)dealloc{
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end



@interface MMSwiperCell()
@end


@implementation MMSwiperCell
-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]init];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_imageView];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
        
    }
    return _imageView;
}
@end




@interface MMSwiperCollectionViewFlowLayout()
@end
@implementation MMSwiperCollectionViewFlowLayout



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
/* 下次新增
 ///  返回collectionView上面当前显示的所有元素（比如cell）的布局属性:这个方法决定了cell怎么排布
 ///  每个cell都有自己对应的布局属性：UICollectionViewLayoutAttributes
 ///  要求返回的数组中装着UICollectionViewLayoutAttributes对象
 - (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
 NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
 CGRect visitRect = {self.collectionView.contentOffset,self.collectionView.bounds.size};
 // 需要copy原来的attributes 否则会有警告：This is likely occurring because the flow layout subclass xxxx is modifying attributes returned by UICollectionViewFlowLayout without copying them
 NSMutableArray *attributesCopy = [NSMutableArray array];
 for (UICollectionViewLayoutAttributes *attribute in attributes) {
 UICollectionViewLayoutAttributes *attributeCopy = [attribute copy];
 [attributesCopy addObject:attributeCopy];
 }
 //    for (UICollectionViewLayoutAttributes *attribute in attributesCopy) {
 //        CGFloat distance = CGRectGetMidX(visitRect) - attribute.center.x;
 //        CGFloat coefficient = distance / (self.itemSize.width * 6); // 根据每个cell的距离设置旋转系数
 //        attribute.transform3D = CATransform3DMakeRotation(coefficient , 1, 0, 0); // 旋转
 //    }
 return attributesCopy;

 }
 */

@end
