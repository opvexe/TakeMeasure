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
@property(nonatomic,strong)UIButton *confirm;
@property(nonatomic,strong)UIView *bottomlineView;
@property(nonatomic,strong)UIView *templeView;
@property(nonatomic,assign)BOOL  isReverse;
@end

static CGFloat MenuHeight = 120.0f;
static CGFloat ArrowWidth = 15.0f; ///倒三角宽度
static CGFloat ArrowHeight = 10.0f; ///倒三角高度
static CGFloat rightMargin = 10.0f; ///右侧间隙
@implementation ATMenuView

- (instancetype)initWithFrame:(CGRect)frame relyonView:(id)view{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor =  [UIColor colorWithRed:(0.0/255.0f) green:(0.0/255.0f) blue:(0.0/255.0f) alpha:0.3];
        self.frame = [UIScreen mainScreen].bounds;
        
        NSAssert([view isKindOfClass:[UIView class]],@"relyonView必须是UIView");
        self.templeView = view;
        self.cornerRaius = 5.0f;
        
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
        _isReverse = YES;  ///MARK: 三角锚点向上
    }else{
        refPoint = CGPointMake(absoluteRect.origin.x + absoluteRect.size.width / 2, absoluteRect.origin.y + absoluteRect.size.height);
        _isReverse = NO;  ///MARK: 三角锚点向下
    }
    
    CGFloat originX = 40.0f;  ///MARK: 左边距40.0f ...右边距 10.0f ...
    CGFloat originY;
    if (_isReverse) {
        originY = refPoint.y - ArrowHeight;
        self.container.frame = CGRectMake(originX, originY - MenuHeight,self.frame.size.width - 40.0f - 10.0f, MenuHeight);
    }else{
        originY = refPoint.y + ArrowHeight;
        self.container.frame = CGRectMake(originX, originY,self.frame.size.width - 40.0f - 10.0f, MenuHeight);
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];

   
    [path moveToPoint:CGPointMake(40.0f, originY)];
    [path addLineToPoint: CGPointMake(0, bottomLeftArcCenter.y)];
    [path addArcWithCenter: bottomLeftArcCenter radius: 5.0f startAngle: -M_PI endAngle: -M_PI-M_PI_2 clockwise: NO];
    
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    
    self.container.layer.mask = maskLayer;
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
            make.left.mas_equalTo(10.0f);
            make.top.mas_equalTo(10.0f);
            make.width.mas_lessThanOrEqualTo(180.0f);
            make.height.mas_equalTo(20.0f);
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
