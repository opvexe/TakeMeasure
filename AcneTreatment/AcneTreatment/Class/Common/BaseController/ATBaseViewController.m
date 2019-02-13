//
//  ATBaseViewController.m
//  AcneTreatment
//
//  Created by FaceBooks on 2018/8/18.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "ATBaseViewController.h"
#import "ATBaseNavigationViewController.h"
#import "ATLoginViewController.h"
#import "AppDelegate.h"

@interface ATBaseViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *placeholderView;
@end

@implementation ATBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

///MARK: 关闭键盘
- (void)dismissKeyBoard{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTextField)];
    [self.view addGestureRecognizer:tap];
    self.view.userInteractionEnabled  =YES;
    tap.delegate  = self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (![touch.view isEqual:self.view]) {
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self closeTextField];
}

- (void)closeTextField{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

///MARK: 提示图
- (void)makeToast:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:message duration:1.0f position:CSToastPositionCenter];
    });
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(ToastPositionType)position{
    NSString *positionType =@"CSToastPositionTop";
    switch (position) {
        case ToastPositionTypeTop:
            positionType =@"CSToastPositionTop";
            break;
        case ToastPositionTypeBottom:
            positionType =@"CSToastPositionBottom";
            break;
        case ToastPositionTypeCenter:
            positionType =@"CSToastPositionCenter";
            break;
        default:
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.view makeToast:message duration:duration position:positionType];
    });
}

-(void)makeToast:(NSString *)message backImageView:(NSString *)image {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:message duration:1.0f position:CSToastPositionCenter title:nil image:[UIImage imageNamed:image] style:nil completion:nil];
    });
}

-(void)networkErrorWithView:(UIView*)view {
    [self createPlaceholderView:nil message:@"你的网络好像被人蹭走了" image:[UIImage imageNamed:@"network"] withView:view action:@selector(reloadDataSoucre)];
}

- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self createPlaceholderView:title message:message image:image withView:superView action:nil];
    });
    
}

///MARK:  展位图
- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView action:(SEL)reloadAction{
    
    if (_placeholderView) {
        [_placeholderView removeFromSuperview];
        _placeholderView = nil;
    }
    if(superView==nil){
        superView=self.view;
    }
    
    _placeholderView = [[UIView alloc]initWithFrame:superView.bounds];
    [_placeholderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [_placeholderView setAutoresizesSubviews:YES];
    [_placeholderView setBackgroundColor:[UIColor clearColor]];
    [superView addSubview:_placeholderView];
    
    CGRect pf = CGRectMake(0, 0, superView.bounds.size.width, 0);
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"avatar_default"]];
    if(image){
        [icon setImage:image];
    }
    
    
    [icon setContentMode:UIViewContentModeScaleAspectFit];
    [icon setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    icon.frame = CGRectMake(0,0, pf.size.width, image.size.height);
    [_placeholderView addSubview:icon];
    
    CGFloat y= icon.frame.size.height+Number(20);
    if(title){
        CGFloat height=[ATToolManger getHeightContain:title font:[UIFont SYPingFangSCLightFontOfSize:15.0] Width:pf.size.width];
        
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, y, pf.size.width, height)];
        [lblTitle setText:title];
        [lblTitle setFont:[UIFont SYPingFangSCLightFontOfSize:15.0]];
        [lblTitle setTextColor:[UIColor TextColor]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblTitle setNumberOfLines:0];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [_placeholderView addSubview:lblTitle];
        y=y+height+5;
    }
    
    if(message){
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, y, pf.size.width, Number(20))];
        [lblTitle setText:message];
        [lblTitle setFont:[UIFont SYPingFangSCLightFontOfSize:16.0]];
        [lblTitle setTextColor:[UIColor TextColor]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblTitle setAutoresizesSubviews:YES];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [_placeholderView addSubview:lblTitle];
        y=y+Number(25);
    }
    //
    //    // 如果有重新加载方法，就显示重新加载按钮
    if(reloadAction){
        UIButton *reButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [reButton setFrame:CGRectMake(pf.size.width/2-Number(114)/2, y+5, Number(114), Number(30))];
        
        [reButton setBackgroundImage:[UIImage imageWithColor:[UIColor BgColor]] forState:UIControlStateNormal];
        [reButton setBackgroundImage:[UIImage imageWithColor:[UIColor BgColor]] forState:UIControlStateDisabled];
        [reButton setBackgroundImage:[UIImage imageWithColor:[UIColor BgColor]] forState:UIControlStateHighlighted];
        [reButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [reButton setTitle:@"      加载中..." forState:UIControlStateDisabled];
        [reButton setTitleColor:[UIColor MainColor] forState:UIControlStateNormal];
        [reButton setTitleColor:[UIColor MainColor] forState:UIControlStateDisabled];
        [reButton.titleLabel setFont:[UIFont SYPingFangSCLightFontOfSize:12.0]];
        [reButton addTarget:self action:reloadAction forControlEvents:UIControlEventTouchUpInside];
        [reButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
        reButton.layer.cornerRadius  = Number(15);
        reButton.layer.masksToBounds = YES;
        reButton.layer.borderColor =[UIColor MainColor].CGColor;
        reButton.layer.borderWidth = Number(0.5);
        [_placeholderView addSubview:reButton];
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.tag=10;
        [activityIndicator setFrame:CGRectMake(Number(192)/2-Number(45), Number(15), Number(20), Number(20))];
        [reButton addSubview:activityIndicator];
        y=y+Number(60);
    }
    pf.size.height=y;
    
    [_placeholderView setFrame:pf];
    [_placeholderView setCenter:CGPointMake(superView.width *0.5,superView.height*0.5)];
}

- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView refTitle:(NSString *)reftitle  action:(SEL)reloadAction{
    if (_placeholderView) {
        [_placeholderView removeFromSuperview];
        _placeholderView = nil;
    }
    if(superView==nil){
        superView=self.view;
    }
    
    _placeholderView = [[UIView alloc]initWithFrame:superView.bounds];
    [_placeholderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [_placeholderView setAutoresizesSubviews:YES];
    [_placeholderView setBackgroundColor:[UIColor clearColor]];
    [superView addSubview:_placeholderView];
    
    
    CGRect pf = CGRectMake(0, 0, superView.bounds.size.width, 0);
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"avatar_default"]];
    if(image){
        [icon setImage:image];
    }
    icon.userInteractionEnabled =YES;
    [icon setContentMode:UIViewContentModeScaleAspectFit];
    [icon setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    icon.frame = CGRectMake(0,0, pf.size.width, image.size.height);
    [_placeholderView addSubview:icon];
    CGFloat y= icon.frame.size.height+Number(20);
    if(title){
        CGFloat height=[ATToolManger getHeightContain:title font:[UIFont SYPingFangSCLightFontOfSize:15.0] Width:pf.size.width];
        
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, y, pf.size.width, height)];
        [lblTitle setText:title];
        [lblTitle setFont:[UIFont SYPingFangSCLightFontOfSize:15.0] ];
        [lblTitle setTextColor:[UIColor TextColor]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblTitle setNumberOfLines:0];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [_placeholderView addSubview:lblTitle];
        y=y+height+5;
    }
    
    if(message){
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, y, pf.size.width, Number(20))];
        [lblTitle setText:message];
        [lblTitle setFont:[UIFont SYPingFangSCLightFontOfSize:15.0] ];
        [lblTitle setTextColor:[UIColor TextColor]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblTitle setAutoresizesSubviews:YES];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [_placeholderView addSubview:lblTitle];
        y=y+Number(25);
    }
    
    // 如果有重新加载方法，就显示重新加载按钮
    if(reloadAction){
        UIButton *reButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [reButton setFrame:CGRectMake(pf.size.width/2-Number(114)/2, y+5, Number(114), Number(30))];
        [reButton setBackgroundImage:[UIImage imageWithColor:[UIColor BgColor]] forState:UIControlStateNormal];
        [reButton setBackgroundImage:[UIImage imageWithColor:[UIColor BgColor]] forState:UIControlStateDisabled];
        [reButton setBackgroundImage:[UIImage imageWithColor:[UIColor BgColor]] forState:UIControlStateHighlighted];
        [reButton setTitle:reftitle forState:UIControlStateNormal];
        [reButton setTitle:reftitle forState:UIControlStateDisabled];
        [reButton setTitleColor:[UIColor MainColor] forState:UIControlStateNormal];
        [reButton setTitleColor:[UIColor MainColor] forState:UIControlStateDisabled];
        [reButton.titleLabel setFont:[UIFont SYPingFangSCLightFontOfSize:12.0]];
        [reButton addTarget:self action:reloadAction forControlEvents:UIControlEventTouchUpInside];
        [reButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
        reButton.layer.cornerRadius  = Number(15);
        reButton.layer.masksToBounds = YES;
        reButton.layer.borderColor =[UIColor MainColor].CGColor;
        reButton.layer.borderWidth = Number(0.5);
        [_placeholderView addSubview:reButton];
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.tag=10;
        [activityIndicator setFrame:CGRectMake(Number(192)/2-Number(45), Number(15), Number(20), Number(20))];
        [reButton addSubview:activityIndicator];
        
        y=y+Number(60);
    }
    pf.size.height=y;
    
    [_placeholderView setFrame:pf];
    [_placeholderView setCenter:CGPointMake(superView.width *0.5,superView.height*0.5)];
}

- (void)removePlaceholderView{
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        if (self.placeholderView && self.placeholderView!=nil) {
            [self.placeholderView removeFromSuperview];
            self.placeholderView = nil;
        }
    });
}

///MARK: TOOD
-(void)loginOut{
    AppDelegate  *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController =[[ATBaseNavigationViewController alloc] initWithRootViewController: [[ATLoginViewController alloc] init]];
}

-(void)reloadDataSoucre{
    
}
-(void)dealloc{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
