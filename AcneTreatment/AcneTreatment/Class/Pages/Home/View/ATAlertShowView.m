//
//  ATAlertShowView.m
//  AcneTreatment
//
//  Created by FaceBooks on 2018/8/19.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "ATAlertShowView.h"
#import "WYTextView.h"
@interface ATAlertShowView()
@property (nonatomic,copy)void(^complete)(NSString *comments);
@property (nonatomic,strong) KLCPopup *popup;
@property(nonatomic,strong)UIView *container;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *cancel;
@property(nonatomic,strong)UIButton *send;
@property(nonatomic,strong)UIView *bottomlineView;
@property(nonatomic,strong)WYTextView *textView;
@end
@implementation ATAlertShowView

+ (ATAlertShowView *)showWithCompelet:(void(^)(NSString *comments))completeBlock{
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,
                                               KLCPopupVerticalLayoutBottom);
    ATAlertShowView *view = [[ATAlertShowView alloc] initWithFrame:CGRectZero];
    KLCPopup *popup = [KLCPopup popupWithContentView:view
                                            showType:KLCPopupShowTypeSlideInFromBottom
                                         dismissType:KLCPopupDismissTypeSlideOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    popup.dimmedMaskAlpha = 0.3f;
    [popup  showWithLayout:layout];
    view.complete = completeBlock;
    view.popup = popup;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    frame = CGRectMake(0,0.0f,SCREEN_WIDTH,SCREEN_HEIGHT*0.7);
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configViews];
    }
    return self;
}

-(void)configViews{
    
    _container = ({
        UIView *iv = [[UIView alloc]init];
        iv.backgroundColor = [UIColor whiteColor];
        iv.frame = self.bounds;
        [self addSubview:iv];
        iv;
    });
    
    ///MARK: 绘制左右两侧圆角
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, self.frame.size.height) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
    CAShapeLayer *layer =[[CAShapeLayer alloc] init];
    [layer setPath:path.CGPath];
    self.container.layer.mask = layer;
    
    _cancel = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.container addSubview:iv];
        [iv setTitle:@"取消" forState:UIControlStateNormal];
        [iv setTitle:@"取消" forState:UIControlStateSelected];
        [iv setTitle:@"取消" forState:UIControlStateHighlighted];
        [iv setTitle:@"取消" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYPingFangSCLightFontOfSize:13.0f]];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20.0f);
            make.top.mas_equalTo(10.0f);
            make.width.mas_lessThanOrEqualTo(60.0f);
            make.height.mas_equalTo(20.0f);
        }];
        iv;
    });
    
    _send = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.container addSubview:iv];
        [iv setTitle:@"发送" forState:UIControlStateNormal];
        [iv setTitle:@"发送" forState:UIControlStateSelected];
        [iv setTitle:@"发送" forState:UIControlStateHighlighted];
        [iv setTitle:@"发送" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYPingFangSCLightFontOfSize:13.0f]];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20.0f);
            make.top.mas_equalTo(10.0f);
            make.width.mas_lessThanOrEqualTo(60.0f);
            make.height.mas_equalTo(20.0f);
        }];
        iv;
    });
    
    _label = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor = [UIColor TextColor];
        iv.numberOfLines = 3;
        iv.text = @"《流浪地球》大火后，吴京被十万条脏话骂上热搜！《流浪地球》大火后，吴京被十万条脏话骂上热搜！《流浪地球》大火后，吴京被十万条脏话骂上热搜！《流浪地球》大火后，吴京被十万条脏话骂上热搜！";
        iv.font = [UIFont SYPingFangSCLightFontOfSize:12.0f];
        iv.textAlignment = NSTextAlignmentLeft;
        [self.container addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20.0f);
            make.right.mas_equalTo(-20.0f);
            make.top.mas_equalTo(self.cancel.mas_bottom).mas_offset(20.0f);
        }];
        iv;
    });
    
    
    _bottomlineView = ({
        UIView *iv = [[UIView alloc] init];
        iv.backgroundColor = [UIColor BgLineColor];
        [self.container addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(self.label.mas_bottom).mas_offset(10.0f);
            make.left.mas_equalTo(20.0f);
            make.right.mas_equalTo(0);
        }];
        iv;
    });
    
    _textView = ({
        WYTextView *iv = [[WYTextView alloc] init];
        iv.placeholder = @"分享你的想法...";
        iv.placeholderColor = UIColorFromRGB(0x909090);
        iv.placeholderFont = [UIFont SYPingFangSCLightFontOfSize:14.0f];
        iv.font = [UIFont SYPingFangSCLightFontOfSize:14.0f];
        iv.textColor = UIColorFromRGB(0X323232);
        [self.container addSubview:iv];
        [iv  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bottomlineView.mas_bottom);
            make.left.mas_equalTo(20.0f);
            make.right.mas_equalTo(-20.0f);
            make.bottom.mas_equalTo(0.0f);
        }];
        iv;
    });
}

-(void)Click:(UIButton *)sender{
    if ([self.textView.text length]) {
        if (self.complete) {
            self.complete(self.textView.text);
        }
        [self dismiss];
    }else{
        NSLog(@"评论不能为空");
    }
}

- (void)dismiss{
    [self.popup dismiss:YES];
}

@end
