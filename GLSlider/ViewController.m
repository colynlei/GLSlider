//
//  ViewController.m
//  GLSlider
//
//  Created by 雷国林 on 2018/9/10.
//  Copyright © 2018年 雷国林. All rights reserved.
//

#import "ViewController.h"
#import "GLSlider.h"

@interface ViewController ()<GLSliderDelegate>

@property (nonatomic, strong) GLSlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat x = 100;
    self.slider = [[GLSlider alloc] initWithFrame:CGRectMake(x, 400, self.view.frame.size.width-2*x, 30)];
//    self.silder.backgroundColor = [UIColor brownColor];
    self.slider.delegate = self;
    self.slider.value = 10;
    self.slider.limitMinimumValue = 10;
    self.slider.limitMaximumValue = 10;
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 100;
    self.slider.thumbTintSize = CGSizeMake(40, 20);
    self.slider.isTruckCornerRidus = NO;
    self.slider.isThumbCornerRidus = NO;
    self.slider.minimumTrackTintColor = [UIColor greenColor];
    self.slider.maximumTrackTintColor = [UIColor redColor];
    self.slider.thumbTintColor = [UIColor blackColor];
    [self.view addSubview:self.slider];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.slider.thumbTintSize = CGSizeMake(20, 20);
        self.slider.isThumbCornerRidus = YES;
        self.slider.value = 50;
        self.slider.limitMinimumValue = 50;
        self.slider.limitMaximumValue = 50;
    });
}
- (IBAction)dddd:(UISlider *)sender {
    NSLog(@"1==%d==%f",(int)sender.value,sender.value);
}
- (IBAction)valueChange:(UISlider *)sender {
    NSLog(@"2==%d==%f",(int)sender.value,sender.value);
}

- (void)glSlider:(GLSlider *)slider panType:(GLSliderPanType)panType{
    NSLog(@"jjjjjj==%f==%d",slider.value,(int)slider.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
