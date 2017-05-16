//
//  EntCenterController.m
//  LePin-Ent
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntCenterController.h"
#import "ManageButtonCell.h"
#import "ItemData.h"
#import "BasicInfoTableViewController.h"
#import "ResumeBasicController.h"
#import "ContactRecordController.h"
#import "InerviewHistoryController.h"
#import "CollectHistoryController.h"
#import "Global.h"
#import "LPLoginNavigationController.h"
#import "MainTabBarController.h"
#import "TalentPoolController.h"
#import "ChargeRegistrationController.h"
#import "PositionTemplateController.h"
#import "PublishedPositionViewController.h"
@interface EntCenterController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic)  UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *data;
@property (assign, nonatomic) CGFloat wide;
@end

@implementation EntCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"企业中心";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    _collectionView=collectionView;
    [self.collectionView registerClass:[ManageButtonCell class] forCellWithReuseIdentifier:@"ManageButtonCell"];
    self.collectionView.delegate=self;
    self.collectionView.dataSource = self;
    collectionView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:collectionView];
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出账号" style:UIBarButtonItemStyleDone target:self action:@selector (logout)];
}
-(void)logout
{
    NSString  * message=@"是否要退出当前账号";
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"提示" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIWindow * mianWindow;
    NSUserDefaults *defaults;
    switch (buttonIndex)
    {
        case 0:
            break;
        case 1:
            USER_ID=nil;
            defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:nil forKey:@"USER_ID"];
            [defaults synchronize];
            mianWindow=self.view.window;
            LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^
                                              {
                                                  MainTabBarController *MainTabBar=[[MainTabBarController alloc]init];
                                                  mianWindow.rootViewController = MainTabBar ;
                                              }];
            mianWindow.rootViewController =vc;
            break;
    }
}
- (NSArray *)data
{
    if (_data == nil)
    {
        NSMutableArray * data=[[NSMutableArray alloc]init];
        [data addObject:[ItemData itemWithIcon:@"职位模板设置" title:@"职位模板设置"]];
        // [data addObject:[ItemData itemWithIcon:@"查看简历" title:@"收取简历"]];
        [data addObject:[ItemData itemWithIcon:@"推送简历" title:@"推送简历"]];
        [data addObject:[ItemData itemWithIcon:@"邀请面试记录" title:@"邀请面试记录"]];
        [data addObject:[ItemData itemWithIcon:@"收藏简历" title:@"收藏简历"]];
        [data addObject:[ItemData itemWithIcon:@"已发布职位" title:@"已发布职位"]];
        [data addObject:[ItemData itemWithIcon:@"人才库" title:@"人才库"]];
        // [data addObject:[ItemData itemWithIcon:@"报名信息" title:@"查看普工报名"]];
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
    ItemData *data=self.data[indexPath.item];
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int mum=(int)indexPath.row;
    //  ItemData *Data; ContactRecordControllerPublishedPositionController
    PositionTemplateController * PositionSetting;
    ResumeBasicController * ResumeBasic;
    PublishedPositionViewController * PublishedPosition;
    InerviewHistoryController * InerviewHistory;
    CollectHistoryController *CollectHistory;
    TalentPoolController *TalentPool;
    // ChargeRegistrationController * ChargeRegistration;
    switch (mum)
    {
        case 0:
            PositionSetting=[[PositionTemplateController alloc]init];
            [self.navigationController pushViewController:PositionSetting animated:YES];
            break;
            //        case 1:
            //            ResumeBasic=[[ResumeBasicController alloc]initWithModel:1];
            //            [self.navigationController pushViewController:ResumeBasic animated:YES];
            //            break;
        case 1:
            ResumeBasic=[[ResumeBasicController alloc]initWithModel:4];
            [self.navigationController pushViewController:ResumeBasic animated:YES];
            break;
        case 2:
            InerviewHistory=[[InerviewHistoryController alloc]init];
            [self.navigationController pushViewController:InerviewHistory animated:YES];
            break;
        case 3:
            CollectHistory=[[CollectHistoryController alloc]init];
            [self.navigationController pushViewController:CollectHistory animated:YES];
            break;
        case 4:
            PublishedPosition=[[ PublishedPositionViewController alloc]init];
            [self.navigationController pushViewController:PublishedPosition animated:YES];
            break;
        case 5:
            TalentPool=[[TalentPoolController  alloc]init];
            [self.navigationController pushViewController:TalentPool animated:YES];
            break;
            //        case 6:
            //            ChargeRegistration=[[ChargeRegistrationController  alloc]init];
            //            [self.navigationController pushViewController:ChargeRegistration animated:YES];
            //            break;
        default:
            break;
    }

}


@end
