//
//  RecruitManageController.m
//  LePin-Ent
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "RecruitManageController.h"
#import "MyLePinTableViewCellData.h"
#import "EntCenterTableViewController.h"
#import "PostPositionControl.h"
#import "PostSewingWorkerPositionController.h"
#import "PostFreshRawPositionController.h"
#import "SearchResumeController.h"
#import "FreshGraduatesSearchController.h"
#import "SewingWorkerSearchController.h"
#import "Global.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "ResumeBasicController.h"
#import "ChargeRegistrationController.h"
#import "ManageButtonCell.h"
@interface RecruitManageController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic)  UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *data;
@property (assign, nonatomic) CGFloat wide;
//@property (nonatomic, copy) Class destVcClass;
@end

@implementation RecruitManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    _collectionView=collectionView;
     [self.collectionView registerClass:[ManageButtonCell class] forCellWithReuseIdentifier:@"ManageButtonCell"];
    self.collectionView.delegate=self;
    self.collectionView.dataSource = self;
    collectionView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:collectionView];
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}

- (NSArray *)data
{
    if (_data == nil)
    {
        NSMutableArray * data=[[NSMutableArray alloc]init];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"个性化简历搜索" title:@"个性化简历搜索" destVcClass:[SearchResumeController class]]];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"应届生简历搜索" title:@"应届生简历搜索" destVcClass:[FreshGraduatesSearchController class]]];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"普工简历搜索" title:@"普工简历搜索" destVcClass:[SewingWorkerSearchController class]]];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"发布职位" title:@"发布职位" destVcClass:[PostPositionControl class]]];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"收取简历" title:@"收取简历" destVcClass:[ResumeBasicController class]]];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"查看普工报名" title:@"查看普工报名" destVcClass:[ChargeRegistrationController class]]];
        _data=data;
    }
    return _data;
}
#pragma mark - 数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ManageButtonCell *cell=[collectionView  dequeueReusableCellWithReuseIdentifier:@"ManageButtonCell" forIndexPath:indexPath];
    MyLePinTableViewCellData *data=self.data[indexPath.item];
    [cell.imageView setImage:[UIImage imageNamed:data.icon]];
    //cell.title.text=data.title;
    return  cell;
}
-(CGFloat)wide
{
    if (_wide==0.0) {
        CGFloat width=[UIScreen mainScreen].bounds.size.width;
       _wide=(width-40)/3-1;
    }
    return _wide;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.wide, self.wide*198.0/180.0);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 10, 10);
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyLePinTableViewCellData *data = self.data[indexPath.row];
    if ([PostPositionControl class] ==data.destVcClass ) {if(isChild){[MBProgressHUD showError:@"子账号不能发布职位"];return;}}
    if ([ResumeBasicController class] ==data.destVcClass ) {[self.navigationController pushViewController:[[ResumeBasicController alloc]initWithModel:1] animated:YES];return;}
    UIViewController *vc = [[data.destVcClass alloc] init];
    vc.title = data.title;
    [self.navigationController pushViewController:vc  animated:YES];
}


@end
