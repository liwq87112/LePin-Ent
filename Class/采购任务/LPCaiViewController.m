//
//  LPCaiViewController.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/12.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPCaiViewController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "LPLoginOnPassWordViewController.h"
#import "LPLoginNavigationController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import "BasicInfoTableViewController.h"
#import "LPShowImageController.h"
#import "MyPurchaseCell.h"
#import "MyPurchaseData.h"
#import "EntSettingController.h"
#import "EntResumeListController.h"
//#import "LPGotoinfoViewController.h"
#import "PurchaseReceiveController.h"
#import "postPurchaseController.h"
@interface LPCaiViewController ()<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(weak,nonatomic)UIView *headView;
@property(weak,nonatomic)UIView *titleHeadView;
@property(weak,nonatomic)UILabel * titleView;
@property(weak,nonatomic)UIImageView * headImageView;
@property(weak,nonatomic)UILabel * headName;
@property(weak,nonatomic)UIButton * headBtn;
@property(weak,nonatomic)UITableView * tableView;
@property(strong,nonatomic)NSMutableArray * data;

@end

@implementation LPCaiViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *titleHeadView=[UIView new];
    _titleHeadView=titleHeadView;
    titleHeadView.backgroundColor = LPUIMainColor;
    [self.view addSubview:titleHeadView];
    UIButton *but =[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 15, 50, 50);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:30];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(gbz) forControlEvents:UIControlEventTouchUpInside];
    [titleHeadView  addSubview:but];
    UILabel * titleView=[UILabel new];
    _titleView=titleView;
    titleView.textAlignment =UIBaselineAdjustmentAlignCenters;
    titleView.textColor=[UIColor whiteColor];
    titleView.text=@"我的采购任务";
    titleView.font=LPTitleFont;
    [titleHeadView addSubview:titleView];
    UITableView * tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    
    _tableView=tableView;
    self.tableView.separatorStyle =1;
    [self.view addSubview:tableView];
    
    
    CGFloat w=self.view.frame.size.width;
    //CGFloat h=self.view.frame.size.height;
    titleHeadView.frame=CGRectMake(0, 0, w, 64);
    titleView.frame=CGRectMake(w/4, 20, w/2, 44);
    
    tableView.frame=CGRectMake(0, 64, w, self.view.frame.size.height);
    
    [self GetUserData];
    [self GetMyPurchaseData];
}

- (void)gbz{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)GetUserData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(USER_ID==nil){params[@"USER_ID"] = @"";}else{params[@"USER_ID"] = USER_ID;}
    params[@"PROORENT"] = [NSNumber numberWithInt:1];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BACKGROUND"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBackgroundByName.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSLog(@"json-%@",json);
             
             NSString * headURL_New=  [LPAppInterface GetURLWithInterfaceImage: [json objectForKey:@"PHOTO"]];
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             NSString *headURL = [defaults stringForKey:@"headURL"];
             if (![headURL_New isEqualToString:headURL])
             {
                 [_headImageView  setImageWithURL:[NSURL URLWithString:headURL_New] placeholderImage:[UIImage imageNamed: @"简历上传头像"]];
                 [defaults setObject:headURL_New forKey:@"headURL"];
                 [defaults synchronize];
             }
             NSString * Name=[json objectForKey:@"NAME"];
             if ( Name==nil)
             {
                 _headName.text=@"请登录" ;
             }
             else
             {
                 //                 USER_NAME=Name;
                 //                 _headName.text=Name ;
                 //                 HomeTableViewController *vc=[HomeTableViewController sharedManager];
                 //                 [vc headNameUpdate:USER_NAME];
                 //                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                 //                 [defaults setObject:USER_NAME forKey:@"USER_NAME"];
                 //                 [defaults synchronize];
             }
             
         }
     } failure:^(NSError *error){}];
}

- (void)GetMyPurchaseData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(USER_ID==nil){params[@"USER_ID"] = @"";}else{params[@"USER_ID"] = USER_ID;}
//    if (isChild) {
//        [self showNoDataImage:_tableView show:isChild];
//        return;
//    }
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PURCHASELIST_BY_USERID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPurchaseListByUserID.do"] params:params success:^(id json)
     {
         NSLog(@"%@",json);
         
         
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
//             [self showNoDataImage:_tableView show:isChild];
             NSArray * purchaseList= [json objectForKey:@"purchaseList"];
             
             if (!purchaseList.count) {
                 NSLog(@"%ld",_data.count);
                 
                 [_data removeAllObjects];
                 [_tableView reloadData];
                 
                 [self BoolBestBeuf];
             }else{
             
             NSMutableArray * array=[NSMutableArray array];
             for (NSDictionary * dict in purchaseList) {
                 MyPurchaseData *data=[MyPurchaseData CreateWithDict:dict];
                 [array addObject:data];
             }
             _data=array;
            [_tableView reloadData];
         }
         }
     } failure:^(NSError *error){}];
}

-(void)showNoDataImage:(UIView *)parentView show:(BOOL)Results
{
    static __weak UIImageView * _view;
    UIImageView * view;
    if(Results)
    {
        if (_view!=nil) {[_view removeFromSuperview];}
        view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"请先登录"]];
        view.contentMode=UIViewContentModeCenter;
        view.bounds=CGRectMake(0, 0, 120, 70);
        view.center=parentView.center;
        UILabel *lable=[UILabel new];
        lable.text=@"子帐号不能查看报名消息";
        lable.textColor=LPFrontMainColor;
        lable.textAlignment=NSTextAlignmentCenter ;
        lable.frame=CGRectMake(0, 50, 120, 70);
        [view addSubview:lable];
        _view=view;
        [parentView addSubview:view];
    }else if(_view !=nil)
    {
        [_view removeFromSuperview];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 5;
        return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        MyPurchaseCell * cell= [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell==nil)
        {
            cell = [[MyPurchaseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
            cell.accessoryType=UITableViewCellSeparatorStyleSingleLine;
            //        [self registerForPreviewingWithDelegate:self sourceView:cellFavorites];
        }
        cell.data=_data[indexPath.row];
        return cell;

}


#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyPurchaseCell getCellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPurchaseData *data=_data[indexPath.row];
    PurchaseReceiveController *purchaseReceiveController=[[PurchaseReceiveController alloc]initWithID:data.PURCHASE_ID];
    [self.navigationController pushViewController:purchaseReceiveController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        MyPurchaseData * data= self.data[indexPath.row];
        NSString *str=[NSString stringWithFormat:@"是否删除 %@ 采购信息",data.PURCHASE_NAME];
        UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:str
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"删除",nil];
        [actionSheet showInView:self.view];
        actionSheet.tag=indexPath.row;
        
    }
}


#pragma mark -
#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self delPurchaseData:actionSheet.tag];
            break;
        case 1:

            break;
        default:
            break;
    }
}

-(void )delPurchaseData:(NSInteger )num
{
    MyPurchaseData * data= self.data[num];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PURCHASE_ID"] = data.PURCHASE_ID;
    params[@"USER_ID"] = USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"DEL_PURCHASE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/delPurchase.do"] params:params  success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [_data removeObjectAtIndex:num];
             [self.tableView reloadData];
         }else
         {
             NSString *Error=[[NSString alloc] initWithFormat:@"错误代码是%d",[result intValue]];
             [MBProgressHUD showError:Error];
         }
     } failure:^(NSError *error){}];
    
}



- (void)BoolBestBeuf
{
    
    NSString * message= [NSString stringWithFormat:@"您还没有发布任何采购信息,是否现在发布"];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    [alertView show];
    
    
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        
        postPurchaseController *post = [[postPurchaseController alloc]init];
        [self.navigationController pushViewController:post animated:YES];
    }
    if (buttonIndex == 0)
    {
        [self gbz];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate=self;
    //
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([[viewController class]isSubclassOfClass:[LPCaiViewController class]]){
        //        [self getMainXib];
        [_tableView reloadData];
        [self GetMyPurchaseData];
        
    }
    if(![[viewController class]isSubclassOfClass:[self class]]) {
        self.navigationController.delegate=nil;
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
