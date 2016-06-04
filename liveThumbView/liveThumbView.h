//
//  liveThumbView.h
//  liveThumbView
//
//  Created by zhn on 16/6/4.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface liveThumbView : UIView

/**
 *  初始化方法
 *
 *  @param imageArray 需要显示的图片数组
 *  @param frame      frame
 *  @param needTimer 是否需要timer 周期添加 
 *
 *  @return 实例
 */
- (instancetype)initWithShowImageArray:(NSArray *)imageArray frame:(CGRect)frame needTimer:(BOOL)needTimer;
+ (instancetype)liveThumbViewWithImageArray:(NSArray *)imageArray frame:(CGRect)frame needTimer:(BOOL)needTimer;

/**
 *  添加一个动画
 */
- (void)addAnimatedThumbSubLayers;
@end
