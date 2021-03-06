//
//  GLSlider.h
//  GLSlider
//
//  Created by 雷国林 on 2018/9/10.
//  Copyright © 2018年 雷国林. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GLSliderPanType) {
    GLSliderPanTypeSetValue,
    GLSliderPanTypeBegin,
    GLSliderPanTypeChange,
    GLSliderPanTypeEnd
};

@class GLSlider;
@protocol GLSliderDelegate <NSObject>

- (void)glSlider:(GLSlider *)slider panType:(GLSliderPanType)panType;

@end

IB_DESIGNABLE
@interface GLSlider : UIView

@property (nonatomic, weak) id<GLSliderDelegate> delegate;

@property (nonatomic, strong) IBInspectable UIColor *minimumTrackTintColor;
@property (nonatomic, strong) IBInspectable UIColor *maximumTrackTintColor;
@property (nonatomic, strong) IBInspectable UIColor *thumbTintColor;//滑块颜色，有滑块图片时，滑块颜色失效
@property (nonatomic, strong) UIImage *currentThumbImage;//滑块图片

@property (nonatomic, assign) IBInspectable BOOL isTruckCornerRidus;//滑动轨道是否有圆角,默认YES
@property (nonatomic, assign) IBInspectable BOOL isThumbCornerRidus;//滑块是否有圆角,默认YES

@property (nonatomic, assign) IBInspectable CGFloat trackHeight;//轨道高度
@property (nonatomic, assign) IBInspectable CGSize thumbTintSize;//滑块尺寸，默认self的高


/**
 重要提示：minimumValue <= limitMinimumValue <= value <= limitMaximumValue <= maximumValue
 */
@property (nonatomic, assign) IBInspectable float value;//当前值
@property (nonatomic, assign) IBInspectable float minimumValue;//最小值，默认0.0
@property (nonatomic, assign) IBInspectable float maximumValue;//最大值，默认1.0
@property (nonatomic, assign) IBInspectable float limitMinimumValue;//限制最小值
@property (nonatomic, assign) IBInspectable float limitMaximumValue;//限制最大致


@end
