//
//  ATHomeViewController.m
//  AcneTreatment
//
//  Created by FaceBooks on 2018/8/19.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "ATHomeViewController.h"
#import "ATHomeTakeMeasureCell.h"
#import "ATHomeContentModel.h"
#import "ATAlertShowView.h"
#import "ATSlideTabBar.h"
#import "ATMenuView.h"
@interface ATHomeViewController ()
<
ATBaseTableViewCellActionProtocol,
ATSlideTabBarDelegate,
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)ATSlideTabBar *slideTabBar;
@property(nonatomic,strong)UITableView *tableListView;
@property(nonatomic,strong)NSMutableArray *lists;
@end

@implementation ATHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableViewDidTriggerHeaderRefresh:DisplayTypeDefalut];
    [self configView];

}

-(void)configView{
    
    _slideTabBar = ({
        ATSlideTabBar *iv = [[ATSlideTabBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, Number(152.0f),40.0f)];
        iv.delegate = self;
        self.navigationItem.titleView = iv;
        iv;
    });
    [_slideTabBar setLabels:@[@"好看",@"精选"] tabIndex:0];
    
    _tableListView = ({
        UITableView *iv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:iv];
        iv.showsVerticalScrollIndicator = YES;
        iv.showsHorizontalScrollIndicator = NO;
        iv.separatorStyle = UITableViewCellSeparatorStyleNone;
        iv.dataSource = self;
        iv.delegate = self;
        iv.tableFooterView  =[UIView new];
        iv.backgroundColor =[UIColor BgTableViewColor];
        @weakify(self);
        iv.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self tableViewDidTriggerHeaderRefresh:DisplayTypeDefalut];
        }];
        iv.mj_header.automaticallyChangeAlpha = YES;
        iv.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self tableViewDidTriggerFooterRefresh:DisplayTypeDefalut];
        }];
        iv.mj_footer.automaticallyChangeAlpha = YES;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iOS11) {
                make.edges.mas_equalTo(self.view.safeAreaInsets);
            }else{
                make.edges.mas_equalTo(self.view);
            }
        }];
        iv;
    });
}

- (void)tableViewDidTriggerHeaderRefresh:(DisplayType)type{
    NSDictionary *home =  [NSString readJson2DicWithFileName:@"home"];
    self.lists = [ATHomeContentModel mj_objectArrayWithKeyValuesArray:home[@"data"]];
    [self.tableListView reloadData];
}

- (void)tableViewDidTriggerFooterRefresh:(DisplayType)type{
    
}

-(void)reloadDataSoucre:(DisplayType)type{
    self.tableListView.mj_header.hidden  =NO;
    self.tableListView.mj_footer.hidden  =NO;
    [self tableViewDidTriggerHeaderRefresh:type];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(velocity.y>0){
        [UIView animateWithDuration:0.25f animations:^{
            self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, AT_TabbarHeight);
            CGRect frame = self.view.frame;
            frame.size.height = SCREEN_HEIGHT - AT_TabbarSafeBottomMargin;
            self.view.frame = frame;
        }];
    }else{
        [UIView animateWithDuration:0.25f animations:^{
            self.tabBarController.tabBar.transform = CGAffineTransformIdentity;
            CGRect frame = self.view.frame;
            frame.size.height = SCREEN_HEIGHT - AT_TabbarHeight;
            self.view.frame = frame;
        }];
    }
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lists.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ATHomeTakeMeasureCell getCellHeight:self.lists[indexPath.row]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ATHomeTakeMeasureCell *cell = [ATHomeTakeMeasureCell CellWithTableView:tableView];
    [cell InitDataWithModel:self.lists[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
}

#pragma mark 适配ios11
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

#pragma mark <ATSlideTabBarDelegate>
- (void)onTabTapAction:(NSInteger)index{
    
}

#pragma mark ATBaseTableViewCellActionProtocol
-(void)tapTableviewCell:(ATBaseTableViewCell *)cell sliderType:(DisplayType)playType tapType:(ClickType)tapType model:(ATBaseModel *)model relyonView:(id)view{
    switch (tapType) {
        case ClickTypeComment:{
            ATAlertShowView *comment = [ATAlertShowView showWithCompelet:^(NSString *comments) {
                
            }];
        }
            break;
            
        case ClickTypeDislike:{
            ATMenuView *dislike = [[ATMenuView alloc]initWithFrame:CGRectZero relyonView:view];
            [dislike show];
        }
            break;
            
        case ClickTypeFavorite:{
            
        }
            break;
            
        default:
            break;
    }
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
