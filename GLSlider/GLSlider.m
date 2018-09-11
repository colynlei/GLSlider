//
//  GLSlider.m
//  GLSlider
//
//  Created by 雷国林 on 2018/9/10.
//  Copyright © 2018年 雷国林. All rights reserved.
//

#import "GLSlider.h"

@interface GLSlider (){
    BOOL _isPan;
}

@property (nonatomic, strong) UIView *minTrackView;
@property (nonatomic, strong) UIView *maxTrackView;;
@property (nonatomic, strong) UIImageView *currentThumbView;

@end

@implementation GLSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initDetault];
        [self addSubview:self.maxTrackView];
        [self addSubview:self.minTrackView];
        [self addSubview:self.currentThumbView];
    }
    return self;
}

- (void)initDetault {
    self.clipsToBounds = YES;
    _value = 0.5;
    _minimumValue = 0.0;
    _maximumValue = 1.0;
    _limitMaximumValue = 0.0;
    _limitMaximumValue = 0.0;
    _minimumTrackTintColor = [UIColor colorWithRed:47/255.0 green:122/255.0 blue:246/255.0 alpha:1];
    _maximumTrackTintColor = [UIColor colorWithRed:182/255.0 green:182/255.0 blue:182/255.0 alpha:1];
    _thumbTintColor = [UIColor redColor];
    _isTruckCornerRidus = YES;
    _isThumbCornerRidus = YES;
    _trackHeight = 3;
    _thumbTintSize = CGSizeMake(self.frame.size.height, self.frame.size.height);
}

- (void)setValue:(float)value {
    _value = value;
    [self setNeedsLayout];
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    _minimumTrackTintColor = minimumTrackTintColor;
    self.minTrackView.backgroundColor = minimumTrackTintColor;
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    _maximumTrackTintColor = maximumTrackTintColor;
    self.maxTrackView.backgroundColor = maximumTrackTintColor;
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    _thumbTintColor = thumbTintColor;
    self.currentThumbView.backgroundColor = thumbTintColor;
}

- (void)setThumbTintSize:(CGSize)thumbTintSize {
    _thumbTintSize = thumbTintSize;
    [self setNeedsLayout];
}

- (UIView *)maxTrackView {
    if (!_maxTrackView) {
        _maxTrackView = [[UIView alloc] initWithFrame:CGRectZero];
        _maxTrackView.backgroundColor = self.maximumTrackTintColor;
        _maxTrackView.userInteractionEnabled = NO;
    }
    return _maxTrackView;
}

- (UIView *)minTrackView {
    if (!_minTrackView) {
        _minTrackView = [[UIView alloc] initWithFrame:CGRectZero];
        _minTrackView.backgroundColor = self.minimumTrackTintColor;
        _minTrackView.userInteractionEnabled = NO;
    }
    return _minTrackView;
}

- (UIImageView *)currentThumbView {
    if (!_currentThumbView) {
        _currentThumbView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _currentThumbView.backgroundColor = self.thumbTintColor;
        _currentThumbView.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(currentThumbViewPanAction:)];
        [_currentThumbView addGestureRecognizer:pan];
    }
    return _currentThumbView;
}

- (void)currentThumbViewPanAction:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(glSlider:currentValue:panType:)]) {
                [self.delegate glSlider:self currentValue:(pan.view.center.x-pan.view.frame.size.width/2)/(self.frame.size.width-pan.view.frame.size.width)*self.maximumValue panType:GLSliderPanTypeBegin];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            _isPan = YES;
            
            CGPoint a = [pan translationInView:self];
            pan.view.center = CGPointMake(pan.view.center.x+a.x, pan.view.center.y);
            [pan setTranslation:CGPointZero inView:self];
            
            _value = pan.view.center.x/self.frame.size.width;
            CGRect rect = self.minTrackView.frame;
            rect.origin.x = 0;
            rect.size.width = pan.view.center.x;
            self.minTrackView.frame = rect;
            
            if (self.limitMaximumValue == 0.0) {
                if (pan.view.center.x<=self.currentThumbView.frame.size.width/2) {
                    pan.view.center = CGPointMake(pan.view.frame.size.width/2, pan.view.center.y);
                    return;
                } else if (pan.view.center.x >= self.frame.size.width-pan.view.frame.size.width/2) {
                    pan.view.center = CGPointMake(self.frame.size.width-pan.view.frame.size.width/2, pan.view.center.y);
                    return;
                }
            }else{
                if (pan.view.center.x<=self.limitMinimumValue/self.maximumValue*(self.frame.size.width-pan.view.frame.size.width)+pan.view.frame.size.width/2) {
                    pan.view.center = CGPointMake(self.limitMinimumValue/self.maximumValue*(self.frame.size.width-pan.view.frame.size.width)+pan.view.frame.size.width/2, pan.view.center.y);
                    return;
                } else if (pan.view.center.x >= self.limitMaximumValue/self.maximumValue*(self.frame.size.width-pan.view.frame.size.width)+pan.view.frame.size.width/2) {
                    pan.view.center = CGPointMake(self.limitMaximumValue/self.maximumValue*(self.frame.size.width-pan.view.frame.size.width)+pan.view.frame.size.width/2, pan.view.center.y);
                    return;
                }
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(glSlider:currentValue:panType:)]) {
                [self.delegate glSlider:self currentValue:(pan.view.center.x-pan.view.frame.size.width/2)/(self.frame.size.width-pan.view.frame.size.width)*self.maximumValue panType:GLSliderPanTypeChange];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            _isPan = NO;
            _value = (pan.view.center.x-pan.view.frame.size.width/2)/(self.frame.size.width-pan.view.frame.size.width)*self.maximumValue;
            if (self.delegate && [self.delegate respondsToSelector:@selector(glSlider:currentValue:panType:)]) {
                [self.delegate glSlider:self currentValue:(pan.view.center.x-pan.view.frame.size.width/2)/(self.frame.size.width-pan.view.frame.size.width)*self.maximumValue panType:GLSliderPanTypeEnd];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_isPan) return;
    
    if (self.limitMaximumValue != 0.0) {
        if (!(self.minimumValue <= self.limitMinimumValue && self.limitMinimumValue <= self.value && self.value <= self.limitMaximumValue && self.limitMaximumValue <= self.maximumValue && self.limitMinimumValue != self.limitMaximumValue)) {
            NSLog(@"限制条件错误");
        }
    }
    
    self.maxTrackView.frame = CGRectMake(0, self.frame.size.height/2-self.trackHeight/2, self.frame.size.width, self.trackHeight);
    
    self.currentThumbView.frame = CGRectMake(0, 0, self.thumbTintSize.width, self.thumbTintSize.height);
    self.currentThumbView.center = CGPointMake(self.value/self.maximumValue*(self.frame.size.width-self.thumbTintSize.width)+self.thumbTintSize.width/2, self.frame.size.height/2);
    if (self.isThumbCornerRidus) {
        _currentThumbView.layer.cornerRadius = self.currentThumbView.frame.size.height/2;
    } else {
        _currentThumbView.layer.cornerRadius = 0;
    }
    
    self.minTrackView.frame = CGRectMake(0, self.maxTrackView.frame.origin.y, self.currentThumbView.center.x, self.maxTrackView.frame.size.height);
    
    if (self.isTruckCornerRidus) {
        self.minTrackView.layer.cornerRadius = self.minTrackView.frame.size.height/2;
        self.maxTrackView.layer.cornerRadius = self.maxTrackView.frame.size.height/2;
    }else{
        self.minTrackView.layer.cornerRadius = 0;
        self.maxTrackView.layer.cornerRadius = 0;
    }
}

@end
