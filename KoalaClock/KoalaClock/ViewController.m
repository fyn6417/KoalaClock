//
//  ViewController.m
//  KoalaClock
//
//  Created by ff'Mac on 2018/11/27.
//  Copyright © 2018 ff. All rights reserved.
//

#import "ViewController.h"

#define kScreenW                [UIScreen mainScreen].bounds.size.width
#define kScreenH                [UIScreen mainScreen].bounds.size.height

#define kSizeOfText             175
#define kAlphaOfView            0.8
#define kCornerRadius           12
#define f_margin                50
#define h_line                  6
#define kTextColor              FFColorWithRGBA(185, 182, 185, 1)
#define kBGColor                FFColorWithRGBA(44, 42, 44, 1)

@interface ViewController ()
{
    UIView *v_hour;
    UIView *v_minute;
    UILabel *lab_hour;
    UILabel *lab_minute;
    UILabel *lab_star;//闪烁冒号
    UILabel *lab_sec;
    
    UIView *v_hourLine;
    UIView *v_minuteLine;
    
    UIView *v_one;
    UIView *v_two;
    UIView *v_three;
    NSArray *arr_stp;
}

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

#pragma mark - Life Circle Method

- (void)viewDidLoad {
    [super viewDidLoad];
    [self zd_config];
    [self zd_buildView];
    [self zd_layout];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"ViewController dealloc");
}

#pragma mark - Config Method

- (void)zd_config
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    self.view.backgroundColor = [UIColor blackColor];
}

#pragma mark - Build View Method

- (void)zd_buildView
{
    
    CGFloat w = kScreenH - f_margin*2;
    v_hour = [[UIView alloc] initWithFrame:CGRectZero];
    v_hour.layer.cornerRadius = kCornerRadius;
    v_hour.backgroundColor = kBGColor;
    v_hour.alpha = kAlphaOfView;
    
    [self.view addSubview:v_hour];
    [v_hour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.left.mas_equalTo(self.view.mas_left).offset(f_margin);
        make.size.mas_equalTo(CGSizeMake(w, w));
    }];
    
    lab_hour = [FFUtil ff_labWithText:[self str_hour] textColor:kTextColor ali:NSTextAlignmentCenter font:FFBoldFontSize(kSizeOfText)];
    [v_hour addSubview:lab_hour];
    [lab_hour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->v_hour.mas_centerX);
        make.centerY.mas_equalTo(self->v_hour.mas_centerY);
    }];
    
    v_hourLine = [[UIView alloc] initWithFrame:CGRectZero];
    v_hourLine.backgroundColor = [UIColor blackColor];
    [v_hour addSubview:v_hourLine];
    
    [v_hourLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->v_hour.mas_left);
        make.right.mas_equalTo(self->v_hour.mas_right);
        make.centerY.mas_equalTo(self->v_hour.mas_centerY);
        make.height.mas_equalTo(h_line);
    }];
    
    v_minute = [[UIView alloc] initWithFrame:CGRectZero];
    v_minute.layer.cornerRadius = kCornerRadius;
    v_minute.backgroundColor = kBGColor;
    v_minute.alpha = kAlphaOfView;
    
    [self.view addSubview:v_minute];
    [v_minute mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-f_margin);
        make.size.mas_equalTo(CGSizeMake(w, w));
    }];
    
    lab_minute = [FFUtil ff_labWithText:[self str_minute] textColor:kTextColor ali:NSTextAlignmentCenter font:FFBoldFontSize(kSizeOfText)];
    [v_minute addSubview:lab_minute];
    [lab_minute mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->v_minute.mas_centerX);
        make.centerY.mas_equalTo(self->v_minute.mas_centerY);
    }];
    
    v_minuteLine = [[UIView alloc] initWithFrame:CGRectZero];
    v_minuteLine.backgroundColor = [UIColor blackColor];
    [v_minute addSubview:v_minuteLine];

    [v_minuteLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->v_minute.mas_left);
        make.right.mas_equalTo(self->v_minute.mas_right);
        make.centerY.mas_equalTo(self->v_minute.mas_centerY);
        make.height.mas_equalTo(h_line);
    }];

    lab_star = [FFUtil ff_labWithText:@":" textColor:kTextColor ali:NSTextAlignmentCenter font:FFBoldFontSize(kSizeOfText-3)];
    [lab_star.layer addAnimation:[self opacityForever_Animation:.5] forKey:nil];
    [self.view addSubview:lab_star];
    [self.timer fire];
    
    [lab_star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self->v_hour.mas_centerY).offset(-10);
    }];
    
    lab_sec = [FFUtil ff_labWithText:[self str_sec] textColor:kTextColor ali:NSTextAlignmentCenter
                                font:FFBoldFontSize(40)];
    [self.view addSubview:lab_sec];
    
    [lab_sec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->v_minute.mas_right);
        make.bottom.mas_equalTo(self->v_minute.mas_bottom);
    }];
}

#pragma mark - Build Layout Method

- (void)zd_layout
{
    //
}

#pragma mark - Timer Method

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ff_timerAction) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (NSArray *)arr_stp
{
    arr_stp = [[self str_time] componentsSeparatedByString:@":"];
    return arr_stp;
}

- (void)ff_timerAction
{
    lab_hour.text = [self str_hour];
    lab_minute.text = [self str_minute];
    lab_star.text = @":";
    lab_sec.text = [self str_sec];
    
    [lab_hour.layer addAnimation:[self rotationWithDuration:.3 repeatCount:1] forKey:nil];
    
    NSString *str = [self str_time];
    NSArray *arr = [str componentsSeparatedByString:@":"];
    NSLog(@"%@时：%@分：%@秒\n", lab_hour.text, lab_minute.text, arr[2]);
}

- (NSString *)str_time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}

- (NSString *)str_hour
{
    return self.arr_stp[0];
}

- (NSString *)str_minute
{
    return self.arr_stp[1];
}

- (NSString *)str_sec
{
    return self.arr_stp[2];
}

#pragma mark - Route Method

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark - Animation Method

-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];///没有的话是均匀的动画。
    return animation;
}

-(CABasicAnimation *)rotationWithDuration:(CGFloat )dur repeatCount:(NSInteger )repeatCount
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.fromValue = [NSNumber numberWithFloat:(10/360)*M_PI];
    animation.toValue = [NSNumber numberWithFloat:(355/360)*M_PI];
    animation.autoreverses = NO;
    animation.cumulative = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = dur;
    animation.repeatCount = repeatCount;
//    animation.delegate = self;
    
    return animation;
    
}

- (void)rotation:(UIView *)view1 :(UIView *)view2 :(UIView *)view3
{
    view1.alpha = 1;
    view2.alpha = 1;
    view3.alpha = 1;
    
    [self rotationFirst:view2];
    [self rotationSecond:view3];
    [self performSelector:@selector(hideView) withObject:nil afterDelay:0.9];
}

- (void)rotationFirst:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.fromValue = [NSNumber numberWithFloat:(-10/360)*M_PI*2];
    animation.toValue = [NSNumber numberWithFloat:(-355/360)*M_PI*2];
    animation.autoreverses = NO;
    animation.cumulative = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 1;
    animation.duration = 3;
    [view.layer addAnimation:animation forKey:@"rotationSecond"];
}

- (void)rotationSecond:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.fromValue = [NSNumber numberWithFloat:(355/360)*M_PI*2];
    animation.toValue = [NSNumber numberWithFloat:(10/360)*M_PI*2];
    animation.autoreverses = NO;
    animation.cumulative = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 0;
    animation.duration = 1;
    [view.layer addAnimation:animation forKey:@"rotationFirst"];
}

- (void)hideView
{
    v_one.alpha = 0;
    v_two.alpha = 0;
    v_three.alpha = 0;
}

/*
func rotation(A:UIView,B:UIView,C:UIView){
    
    A.alpha = 1
    
    B.alpha = 1
    
    C.alpha = 1
    
    rotationFirst(view: B)
    
    //本文中提到的B，显示13
    
    rotationSecond(view: C)
    
    //本文中提到的C，显示14
    
    self.perform(#selector(self.initializeABC),with: nil, afterDelay: 0.9)
    
    //最后为了过度顺利，提前0.1秒让A/B/C小时
    
    //initializeABC函数设置A/B/C隐藏
    
}



func rotationFirst(view:UIView){
    
    //旧值标签，先出来
    
    let animation = CABasicAnimation(keyPath: "transform.rotation.x")
    
    animation.fromValue = (-10/360)*Double.pi
    
    animation.toValue = (-355/360)*Double.pi
    
    animation.duration = 1.0
    
    animation.repeatCount = 0
    
    animation.delegate = selfas? CAAnimationDelegate
    
    view.layer.add(animation, forKey: "rotationSecond")
    
    view.alpha = 1
    
}





func rotationSecond(view:UIView) {
    
    //新值标签，后
    
    let animation = CABasicAnimation(keyPath: "transform.rotation.x")
    
    animation.fromValue = (355/360)*Double.pi
    
    animation.toValue = (10/360)*Double.pi
    
    animation.duration = 1.0
    
    animation.repeatCount = 0
    
    animation.delegate = self as? CAAnimationDelegate
    
    view.layer.add(animation, forKey: "rotationFirst")
    
    view.alpha = 1
    
}

*/

@end
