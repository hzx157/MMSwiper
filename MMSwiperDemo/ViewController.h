//
//  ViewController.h
//  MMSwiperDemo
//
//  Created by xiaowu on 2020/4/15.
//  Copyright © 2020 Huangzhenxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end


//自己自主创建的model
@interface MMSwiperModel : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placeholderImage;

-(instancetype)initWithUrl:(NSString *)url;
-(instancetype)initWithUrl:(NSString *)url title:(NSString *)title;
@end
