//
//  ATBaseTableViewCell.m
//  AcneTreatment
//
//  Created by FaceBooks on 2018/8/18.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "ATBaseTableViewCell.h"

@implementation ATBaseTableViewCell

+(id)CellWithTableView:(UITableView *)tableview{
    return nil;
};

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        [self ATSinitConfingViews];
        [self ATConfigSignalDataSoucre];
    }
    return  self ;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self ATSinitConfingViews];
    [self ATConfigSignalDataSoucre];
}

- (void)ATSinitConfingViews{
    _bottomlineView = ({
        UIView *iv = [[UIView alloc] init];
        iv.backgroundColor = [UIColor BgLineColor];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        iv;
    });
}

-(void)ATConfigSignalDataSoucre{
    
}

-(void)InitDataWithModel:(ATBaseModel *)model{
    
}

+(CGFloat)getCellHeight:(ATBaseModel *)model{
    
    return  0.0f;
}

-(void)dealloc{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}
@end
