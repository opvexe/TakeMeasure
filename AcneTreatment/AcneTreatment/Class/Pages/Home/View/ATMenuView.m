//
//  ATMenuView.m
//  AcneTreatment
//
//  Created by FaceBook on 2019/2/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ATMenuView.h"
@interface ATMenuView()
@property(nonatomic,strong)UIView *container;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *dislikeButton;
@property(nonatomic,strong)UIView *bottomlineView;
@property(nonatomic,strong)UIView *templeView;
@property(nonatomic,assign)BOOL  isReverse;
@end

static CGFloat MenuHeight = 140.0f;
static CGFloat ArrowWidth = 15.0f; ///倒三角宽度
static CGFloat ArrowHeight = 10.0f; ///倒三角高度
static CGFloat kDefaultMargin  = 10.0f ;//间隙 与三角高度相等
@implementation ATMenuView

- (instancetype)initWithFrame:(CGRect)frame relyonView:(id)view{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor =  [UIColor colorWithRed:(0.0/255.0f) green:(0.0/255.0f) blue:(0.0/255.0f) alpha:0.3];
        self.frame = [UIScreen mainScreen].bounds;
        
        NSAssert([view isKindOfClass:[UIView class]],@"relyonView必须是UIView");
        self.templeView = view;
        self.cornerRaius = 10.0f;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
        [self addGestureRecognizer:tap];
        
        [self setupMaskLayer];
        [self configViews];
    }
    return self;
}


-(void)setupMaskLayer{
    
    ///MARK: 记录点击对象坐标
    CGPoint refPoint = CGPointZero;
    ///MARK: 获取点击对象的坐标
    CGRect absoluteRect = [_templeView convertRect:_templeView.bounds toView:[UIApplication sharedApplication].keyWindow];
    ///MARK: 判断正反面
    if (absoluteRect.origin.y + absoluteRect.size.height + MenuHeight + ArrowHeight> SCREEN_HEIGHT - 10.0f) {
        refPoint = CGPointMake(absoluteRect.origin.x + absoluteRect.size.width / 2, absoluteRect.origin.y);
        _isReverse = YES;  ///MARK: 三角锚点向下
    }else{
        refPoint = CGPointMake(absoluteRect.origin.x + absoluteRect.size.width / 2, absoluteRect.origin.y + absoluteRect.size.height);
        _isReverse = NO;  ///MARK: 三角锚点向上
    }
    
    CGFloat originX = 40.0f;  ///MARK: 左边距40.0f ...右边距 10.0f ...
    CGFloat originY;
    if (_isReverse) {
        originY = refPoint.y - kDefaultMargin/2;
        self.container.frame = CGRectMake(originX, originY - MenuHeight,self.frame.size.width - 40.0f - 10.0f, MenuHeight);
    }else{
        originY = refPoint.y + kDefaultMargin/2;
        self.container.frame = CGRectMake(originX, originY,self.frame.size.width - 40.0f - 10.0f, MenuHeight);
    }
    
    CAShapeLayer *layer =[[CAShapeLayer alloc] init];
    ///MARK: 绘制左下角
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置画笔起始点   40.0f , 5
    [path moveToPoint:CGPointMake(kDefaultMargin,_cornerRaius+kDefaultMargin)];
    // 从当前点到指定点绘制直线 40.0f ,
    [path addLineToPoint: CGPointMake(kDefaultMargin, self.container.height - _cornerRaius-kDefaultMargin)];
    // 添加弧线
    [path addArcWithCenter: CGPointMake(_cornerRaius+kDefaultMargin,self.container.height - _cornerRaius-kDefaultMargin) radius: _cornerRaius startAngle: -M_PI endAngle: -M_PI-M_PI_2 clockwise: NO];
    
    if (_isReverse) {  ///方向下  40是左边距
        [path addLineToPoint:CGPointMake(absoluteRect.origin.x - 40.0f + absoluteRect.size.width/2- ArrowWidth/2, self.container.height - kDefaultMargin)];
        [path addLineToPoint:CGPointMake(absoluteRect.origin.x - 40.0f + absoluteRect.size.width/2 , self.container.height)];
        [path addLineToPoint:CGPointMake(absoluteRect.origin.x - 40.0f + absoluteRect.size.width/2 + ArrowWidth/2, self.container.height - kDefaultMargin)];
    }
    
    ///MARK: 绘制右下角
    [path addLineToPoint:CGPointMake(self.container.width- _cornerRaius-kDefaultMargin, self.container.height-kDefaultMargin)];
    [path addArcWithCenter:CGPointMake(self.container.width -_cornerRaius-kDefaultMargin , self.container.height -_cornerRaius-kDefaultMargin) radius:_cornerRaius startAngle:-M_PI-M_PI_2 endAngle: -M_PI*2 clockwise:NO];
    
    ///MARK: 绘制右上角
    [path addLineToPoint:CGPointMake(self.container.width-kDefaultMargin, _cornerRaius+kDefaultMargin)];
    [path addArcWithCenter:CGPointMake(self.container.width - _cornerRaius-kDefaultMargin, _cornerRaius+kDefaultMargin) radius:_cornerRaius startAngle:0 endAngle:-M_PI_2 clockwise:NO];
    
    if (!_isReverse) { //// 向上
        [path addLineToPoint:CGPointMake(absoluteRect.origin.x - 40.0f + absoluteRect.size.width/2 + ArrowWidth/2, kDefaultMargin)];
        [path addLineToPoint:CGPointMake(absoluteRect.origin.x -40.0f + absoluteRect.size.width/2, 0)];
        [path addLineToPoint:CGPointMake(absoluteRect.origin.x -40.0f + absoluteRect.size.width/2 - ArrowWidth/2, kDefaultMargin)];
    }
    
    ///MARK: 绘制左上角
    [path addLineToPoint:CGPointMake(kDefaultMargin+_cornerRaius,kDefaultMargin)];
    [path addArcWithCenter:CGPointMake(_cornerRaius+kDefaultMargin, _cornerRaius+kDefaultMargin) radius:_cornerRaius startAngle:-M_PI_2 endAngle: -M_PI clockwise:NO];
    [path closePath];
    
    [layer setPath:path.CGPath];
    self.container.layer.mask = layer;
}

-(void)setCornerRaius:(CGFloat)cornerRaius{
    _cornerRaius = cornerRaius;
    
}

-(UIView *)container{
    if (!_container) {
        _container = [[UIView alloc]init];
        _container.backgroundColor = [UIColor whiteColor];
        [self addSubview:_container];
    }
    return _container;
}


-(void)configViews{
    
    _label = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor = [UIColor blackColor];
        iv.text = @"不喜欢的原因";
        iv.font = [UIFont SYPingFangSCSemiboldFontOfSize:12.0f];
        iv.textAlignment = NSTextAlignmentLeft;
        [self.container addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20.0f);
            make.top.mas_equalTo(20.0f);
            make.width.mas_lessThanOrEqualTo(180.0f);
            make.height.mas_equalTo(20.0f);
        }];
        iv;
    });
    
    _dislikeButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.container addSubview:iv];
        [iv setTitle:@"不感兴趣" forState:UIControlStateNormal];
        [iv setTitle:@"不感兴趣" forState:UIControlStateSelected];
        [iv setTitle:@"不感兴趣" forState:UIControlStateHighlighted];
        [iv setTitle:@"不感兴趣" forState:UIControlStateDisabled];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [iv.titleLabel setFont:[UIFont SYPingFangSCLightFontOfSize:10.0f]];
        [iv setBackgroundColor:[UIColor orangeColor]];
        iv.titleLabel.textAlignment = NSTextAlignmentCenter;
        iv.layer.masksToBounds = YES;
        iv.layer.cornerRadius = 5.0f;
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20.0f);
            make.centerY.mas_equalTo(self.label);
            make.width.mas_equalTo(50.0f);
            make.height.mas_equalTo(25.0f);
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
            make.left.mas_equalTo(self.label);
            make.right.mas_equalTo(self.dislikeButton.mas_right);
        }];
        iv;
    });
    

}


-(void)show{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    
    self.container.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.25f animations:^{
        self.container.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
        self.container.alpha = 1.0f;
    }];
}

-(void)dismiss{
    
    [UIView animateWithDuration: 0.25f animations:^{
        self.container.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
        self.container.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)Tap:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
}
@end
