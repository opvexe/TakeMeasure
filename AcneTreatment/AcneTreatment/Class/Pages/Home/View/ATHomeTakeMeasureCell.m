//
//  ATHomeTableViewCell.m
//  AcneTreatment
//
//  Created by FaceBook on 2018/8/21.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "ATHomeTakeMeasureCell.h"
#import "ATHomeContentModel.h"
@interface ATHomeTakeMeasureCell()
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *author;
@property(nonatomic,strong)UIButton *dislike;
@property(nonatomic,strong)UIButton *comment;
@property(nonatomic,strong)UIButton *favorite;
@property(nonatomic,strong)UIView *middlelineView;
@property(nonatomic,strong)FLAnimatedImageView *illustration;
@property(nonatomic,strong)ATHomeContentModel *model;
@end
@implementation ATHomeTakeMeasureCell

+(instancetype)CellWithTableView:(UITableView *)tableview{
    static NSString *ID = @"ATHomeTakeMeasureCell";
    ATHomeTakeMeasureCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ATHomeTakeMeasureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)ATSinitConfingViews{
    
    _illustration = ({
        FLAnimatedImageView *iv = [FLAnimatedImageView new];
        [self.contentView addSubview:iv];
        iv.layer.masksToBounds = YES;
        iv.backgroundColor = [UIColor Theme_ColorRandom];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Number(10.0f));
            make.right.mas_equalTo(-10.0f);
            make.size.mas_equalTo(CGSizeMake(60.0f, 60.0f));
        }];
        iv;
    });
    
    _title = ({
        UILabel *iv = [[UILabel alloc]init];
        [self.contentView addSubview:iv];
        iv.numberOfLines = 3;
        iv.textColor = [UIColor blackColor];
        iv.textAlignment = NSTextAlignmentLeft;
        iv.font = [UIFont SYPingFangSCSemiboldFontOfSize:Number(16.0f)];
//        iv.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 90.0f;  ///自适应高度
//        [iv setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Number(10.0f));
            make.top.mas_equalTo(NumberHeight(10.0f));
            make.right.mas_equalTo(self.illustration.mas_left).mas_offset(-Number(10.0f));
        }];
        iv;
    });
    
    _author = ({
        UILabel *iv = [[UILabel alloc]init];
        [self.contentView addSubview:iv];
        iv.textColor = [UIColor TextColor];
        iv.textAlignment = NSTextAlignmentLeft;
        iv.font = [UIFont SYPingFangSCLightFontOfSize:Number(13.0f)];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.title);
            make.top.mas_equalTo(self.illustration.mas_bottom).mas_offset(-20.0f);
            make.width.mas_lessThanOrEqualTo(Number(120.0f));
            make.height.mas_equalTo(NumberHeight(20.0f));
        }];
        iv;
    });
    
    _dislike = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"close_dislike"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"close_dislike"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"close_dislike"] forState:UIControlStateDisabled];
        [iv setImage:[UIImage imageNamed:@"close_dislike"] forState:UIControlStateHighlighted];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.tag = ClickTypeDislike;
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.author);
            make.right.mas_equalTo(self.illustration.mas_left).mas_offset(-Number(10.0f));
            make.size.mas_equalTo(CGSizeMake(17.0f, 12.0f));
        }];
        iv;
    });
    
    _middlelineView = ({
        UIView *iv = [[UIView alloc] init];
        iv.backgroundColor = [UIColor BgLineColor];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(self.author.mas_bottom).mas_offset(10.0f);
            make.left.mas_equalTo(self.title);
            make.right.mas_equalTo(0);
        }];
        iv;
    });
    
    _comment = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"oppoint_nor"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"oppoint_nor"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"oppoint_nor"] forState:UIControlStateDisabled];
        [iv setImage:[UIImage imageNamed:@"oppoint_nor"] forState:UIControlStateHighlighted];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.tag = ClickTypeComment;
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.middlelineView).mas_offset(NumberHeight(10.0f));
            make.right.mas_equalTo(-Number(15.0f));
            make.size.mas_equalTo(CGSizeMake(16.0f, 16.0f));
        }];
        iv;
    });
    
    _favorite = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:iv];
        [iv setImage:[UIImage imageNamed:@"oppoint_nor"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"oppoint_nor"] forState:UIControlStateSelected];
        [iv setImage:[UIImage imageNamed:@"oppoint_nor"] forState:UIControlStateDisabled];
        [iv setImage:[UIImage imageNamed:@"oppoint_nor"] forState:UIControlStateHighlighted];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.tag = ClickTypeFavorite;
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.comment);
            make.right.mas_equalTo(self.comment.mas_left).mas_offset(-Number(15.0f));
            make.size.mas_equalTo(CGSizeMake(16.0f, 16.0f));
        }];
        iv;
    });
}

#pragma mark Action
-(void)Click:(UIButton *)sender{
    if (self.delegate) {
        [self.delegate tapTableviewCell:self sliderType:DisplayTypeDefalut tapType:sender.tag model:_model relyonView:sender];
    }
}


-(void)InitDataWithModel:(ATHomeContentModel *)model{
    _model = model;
    [self.illustration sd_setImageWithURL:URLFromString(model.middle_image) placeholderImage:ATImageNamed(@"")];
    self.title.text = model.title;
    self.author.text = model.source;
    
    CGFloat height = [ATToolManger getHeightContain:model.title font:[UIFont SYPingFangSCSemiboldFontOfSize:Number(16.0f)] Width:SCREEN_WIDTH - 90.0f];
    
    if (height > 40.0f) {
        [self.author mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.title);
            make.top.mas_equalTo(self.title.mas_bottom).mas_offset(10.0f);
            make.width.mas_lessThanOrEqualTo(Number(120.0f));
            make.height.mas_equalTo(NumberHeight(20.0f));
        }];
    }else{
        [self.author mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.title);
            make.top.mas_equalTo(self.illustration.mas_bottom).mas_offset(-20.0f);
            make.width.mas_lessThanOrEqualTo(Number(120.0f));
            make.height.mas_equalTo(NumberHeight(20.0f));
        }];
    }
}

+ (CGFloat)getCellHeight:(ATHomeContentModel *)model{
    
    CGFloat height = [ATToolManger getHeightContain:model.title font:[UIFont SYPingFangSCSemiboldFontOfSize:Number(16.0f)] Width:SCREEN_WIDTH - 90.0f]>40.0f?[ATToolManger getHeightContain:model.title font:[UIFont SYPingFangSCSemiboldFontOfSize:Number(16.0f)] Width:SCREEN_WIDTH - 90.0f] + 30.0f:60.0f;
    return height + 50.0f;
}

-(void)setFrame:(CGRect)frame{
    frame.size.height -= 5;
    [super setFrame:frame];
}

@end
