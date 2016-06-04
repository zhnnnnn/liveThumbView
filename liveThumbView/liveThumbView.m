//
//  liveThumbView.m
//  liveThumbView
//
//  Created by zhn on 16/6/4.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "liveThumbView.h"

@interface liveThumbView()
@property (nonatomic,strong) NSArray<UIImage *> * showImageArray;
@end

// 动画的执行时间
static const CGFloat KanimationDuration = 4;
// x轴 keyframe动画的关键帧数
static const NSInteger KxsideMaxValuesCount = 4;
// y轴 keyframe动画的关键帧
static const NSInteger KysideMaxValuesCount = 5;
// 左右摆动的幅度
static const NSInteger shakeRange = 4;
// timer 随机每秒添加最多的count
static const NSInteger cycleRandomCount = 4;
// timer 的时间
static const NSInteger timerTimeInterval = 1;
// 显示图片layer的宽
static const CGFloat KthumbViewWidth = 40;


@implementation liveThumbView

- (instancetype)initWithShowImageArray:(NSArray *)imageArray frame:(CGRect)frame needTimer:(BOOL)needTimer{
    
    if (self = [super initWithFrame:frame]) {
        self.showImageArray = imageArray;
        if (needTimer) {
             [self addAnimateTimer];
        }
    }
    return self;
}

+ (instancetype)liveThumbViewWithImageArray:(NSArray *)imageArray frame:(CGRect)frame needTimer:(BOOL)needTimer{
    
    return [[self alloc]initWithShowImageArray:imageArray frame:frame needTimer:needTimer];
}

- (void)addAnimateTimer{
    NSTimer * animatedTimer = [NSTimer timerWithTimeInterval:timerTimeInterval target:self selector:@selector(timerCycleAddAnimateLayer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:animatedTimer forMode:NSDefaultRunLoopMode];
}

- (void)timerCycleAddAnimateLayer{
   int randomCount = arc4random()%cycleRandomCount;
    for (int index = 0; index < randomCount; index++) {
        [self addAnimatedThumbSubLayers];
    }
}

// 加一个动画
- (void)addAnimatedThumbSubLayers{
    
    CALayer * thumbLayer = [[CALayer alloc]init];
    int  imageIndex = arc4random()%self.showImageArray.count;
    thumbLayer.contents = (__bridge id _Nullable)(self.showImageArray[imageIndex].CGImage);
    [self.layer addSublayer:thumbLayer];
    thumbLayer.frame = CGRectMake((self.frame.size.width - KthumbViewWidth)/2, self.frame.size.height-KthumbViewWidth, KthumbViewWidth, KthumbViewWidth);
    
    // y轴上面的动画
    CAKeyframeAnimation * ySideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    ySideAnimation.values = [self getYsideKeyArray];
    
    // x轴上面的动画
    CAKeyframeAnimation * xSideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    xSideAnimation.values = [self getXsideKeyArray];

    // 透明度的动画
    CABasicAnimation * fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.duration = KanimationDuration;
    fadeAnimation.fromValue = @(1);
    fadeAnimation.toValue = @(0);
    
    // 最开始缩放的动画
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(0);
    scaleAnimation.toValue = @(1);
    scaleAnimation.duration = 0.25;
    
    // 添加一个动画array
    CAAnimationGroup * thumbAnimationGroup = [[CAAnimationGroup alloc]init];
    thumbAnimationGroup.animations = @[xSideAnimation,ySideAnimation,fadeAnimation,scaleAnimation];
    thumbAnimationGroup.duration = KanimationDuration;
    [thumbLayer addAnimation:thumbAnimationGroup forKey:@"thumbAnimationGroup"];
    
    // 动画执行完之前把这个layer remove掉
    [thumbLayer performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:KanimationDuration - 0.1];
}

// 获取一个随机的数组 x轴
- (NSArray *)getXsideKeyArray{
   
    NSMutableArray * xSideValuesArray = [NSMutableArray array];
    int delta = self.frame.size.width / shakeRange;
    for (int index = 0; index < KxsideMaxValuesCount; index++) {
    
            int randomObject = arc4random()%(2*delta) - delta;
            [xSideValuesArray addObject:@(randomObject)];
        
    }
    return xSideValuesArray;
}

// 获取-个随机数组 y轴
- (NSArray *)getYsideKeyArray{
    
    NSMutableArray * ysideArray = [NSMutableArray array];
    int delta = self.frame.size.height / KysideMaxValuesCount;
    
    for (int index = 0; index < KysideMaxValuesCount; index++) {
        int randomObject = arc4random()%(delta) + (index * delta);
        [ysideArray addObject:@(- randomObject)];
    }
    return ysideArray;
}





@end
