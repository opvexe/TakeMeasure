//
//  ATSlideTabBar.m
//  AcneTreatment
//
//  Created by FaceBook on 2019/2/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ATSlideTabBar.h"
@interface ATSlideTabBar ()
@property (nonatomic, strong) UIView                           *slideLightView;
@property (nonatomic, strong) NSMutableArray<UILabel *>        *labels;
@property (nonatomic, strong) NSMutableArray<NSString *>       *titles;
@property (nonatomic, assign) NSInteger                        tabIndex;
@property (nonatomic, assign) CGFloat                          itemWidth;
@end
@implementation ATSlideTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        _labels = [NSMutableArray array];
        _titles = [NSMutableArray array];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if(_titles.count == 0) {
        return;
    }
    
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        [subView removeFromSuperview];
    }];
    [_labels removeAllObjects];
    
    CGFloat itemWidth = _itemWidth = self.frame.size.width/_titles.count;
    [_titles enumerateObjectsUsingBlock:^(NSString * title, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc]init];
        label.text = title;
        label.textColor = [UIColor TextColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont SYPingFangSCLightFontOfSize:14.0f];
        label.tag = idx;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)]];
        [self.labels addObject:label];
        [self addSubview:label];
        label.frame = CGRectMake(idx*itemWidth, 0, itemWidth, self.bounds.size.height);
        if(idx != self.titles.count - 1) {
            UIView *spliteLine = [[UIView alloc] initWithFrame:CGRectMake((idx+1)*itemWidth - 0.25f, 15.0f, 0.5f, self.bounds.size.height - 30.0f)];
            spliteLine.backgroundColor = [UIColor blackColor];
            spliteLine.layer.zPosition = 10;
            [self addSubview:spliteLine];
        }
    }];
    _labels[_tabIndex].textColor = [UIColor blackColor];
    
    _slideLightView = [[UIView alloc] init];
    _slideLightView.backgroundColor = [UIColor blackColor];
    _slideLightView.frame = CGRectMake(_tabIndex * itemWidth + 15, self.bounds.size.height, itemWidth - 30, 2);
    [self addSubview:_slideLightView];
}

- (void)setLabels:(NSArray<NSString *> *)titles tabIndex:(NSInteger)tabIndex {
    [_titles removeAllObjects];
    [_titles addObjectsFromArray:titles];
    _tabIndex = tabIndex;
}

- (void)onTapAction:(UITapGestureRecognizer *)sender {
    NSInteger index = sender.view.tag;
    if(_delegate) {
        [UIView animateWithDuration:0.25
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect frame = self.slideLightView.frame;
                             frame.origin.x = self.itemWidth * index + 15;
                             [self.slideLightView setFrame:frame];
                             [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
                                 label.textColor = index == idx ? [UIColor blackColor] : [UIColor TextColor];
                             }];
                         } completion:^(BOOL finished) {
                             [self.delegate onTabTapAction:index];
                         }];
        
    }
}
@end
