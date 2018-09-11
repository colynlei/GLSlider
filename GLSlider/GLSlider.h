//
//  GLSlider.h
//  GLSlider
//
//  Created by 雷国林 on 2018/9/10.
//  Copyright © 2018年 雷国林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLSlider;
@protocol GLSliderDelegate <NSObject>

- (void)glSlider:(GLSlider *)slider currentValue:(float)currentValue;

@end

@interface GLSlider : UIView


@property (nonatomic, weak) id<GLSliderDelegate> delegate;

@property (nonatomic, strong) UIColor *minimumTrackTintColor;
@property (nonatomic, strong) UIColor *maximumTrackTintColor;
@property (nonatomic, strong) UIColor *thumbTintColor;//滑块颜色，有滑块图片时，滑块颜色失效
@property (nonatomic, strong) UIImage *currentThumbImage;//滑块图片

@property (nonatomic, assign) BOOL isTruckCornerRidus;//滑动轨道是否有圆角,默认YES
@property (nonatomic, assign) BOOL isThumbCornerRidus;//滑块是否有圆角,默认YES

@property (nonatomic, assign) CGFloat trackHeight;//轨道高度
@property (nonatomic, assign) CGSize thumbTintSize;//滑块尺寸，默认self的高

@property (nonatomic, assign) float value;//当前值
@property (nonatomic, assign) float minimumValue;//最小值，默认0.0
@property (nonatomic, assign) float maximumValue;//最大值，默认1.0

@property (nonatomic, assign) float limitMinimumValue;//限制最小值
@property (nonatomic, assign) float limitMaximumValue;//限制最大致


@end
