//
//  ResumeListController.m
//  LePin-Ent
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntResumeListController.h"
#import "ResumeData.h"
#import "ResumeCell.h"
#import "Global.h"
#import "NSString+Hash.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "ResumeDetailsController.h"

@interface EntResumeListController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>
@property (nonatomic, strong) NSMutableDictionary * params;
@property (nonatomic, strong) NSMutableArray * data;
@property (nonatomic, assign) NSUInteger PAGE;
@property (nonatomic, assign) NSUInteger QUANTITY;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, copy) NSString * keyWord;
@property (weak, nonatomic) UILabel  * titleLable;
@property (weak, nonatomic) UIView * headView;
@property (weak, nonatomic) UIButton * closeBtn;
@property (weak, nonatomic) UITableView * tableView;
@property (copy, nonatomic) NSString  * titleText;
@property (copy, nonatomic) NSString  * addr;
@property (assign, nonatomic) NSInteger  type;
@end
@implementation EntResumeListController

#define PageMaxItem 20
-(instancetype)initWithType:(NSInteger)type;
{
    self=[super init];
    _type= type;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_type==0) {
        params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_CHECKRESUMELIST_BY_USERID"];
        _addr=@"/appent/getCheckResumeListByUserID.do";
        _titleText=@"我查看了谁的简历";
    }
    else
    {
        _titleText=@"不合适的简历";
        params[@"longitude"] = [NSString stringWithFormat:@"%f",longitude];
        params[@"latitude"] = [NSString stringWithFormat:@"%f",latitude];
         params[@"TYPE"] =[NSNumber numberWithLong:4];
        _addr=@"/appent/getResumeListForPosition.do";
        params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_RESUME_FOR_POSITION"];
         params[@"POSITIONPOSTED_ID"] = @"";
    }
    self.PAGE=1;
    self.QUANTITY=PageMaxItem;
    if (USER_ID==nil) {params[@"USER_ID"] = @"";}else{params[@"USER_ID"] = USER_ID;};
    params[@"PAGE"] =[NSNumber numberWithLong:self.PAGE];
    params[@"QUANTITY"] = [NSNumber numberWithLong:self.QUANTITY];
    params[@"SEQ"] = [NSNumber numberWithInt:0];
    
    params[@"mac"] =mac;
    _params=params;
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView=[UITableView new];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=LPUIBgColor;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    UIButton  *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn=closeBtn;
    [closeBtn setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    // [closeBtn setTitle:@"返回" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:LPUIMainColor forState:UIControlStateNormal];
    [headView addSubview:closeBtn];
    
    UILabel  * titleLable=[UILabel new];
    _titleLable=titleLable;
    titleLable.font=LPTitleFont;
    titleLable.textAlignment=NSTextAlignmentCenter;
    titleLable.text=_titleText;
    titleLable.textColor=[UIColor whiteColor];
    [headView addSubview:titleLable];
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    _headView.frame=CGRectMake(0, 0, width, 64);
    _closeBtn.frame=CGRectMake(10, 20, height*2, height);
    _titleLable.frame=CGRectMake(width/4, 20, width/2, height);
    closeBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, _closeBtn.frame.size.width*0.7);
    closeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -_closeBtn.frame.size.width*0.3, 0, 0);


    CGFloat y=CGRectGetMaxY(_headView.frame);
    _tableView.frame=CGRectMake(0, y, width, self.view.frame.size.height-y);
    

    [self GetPositionData];
    [self setupFooter];
}
- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    [refreshFooter addToScrollView:self.tableView isEffectedByNavigationController:NO];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}
- (void)footerRefresh
{
    [self GetMorePositionData];
}
-(void)dealloc
{
    [_refreshFooter free];
}

-(void)closeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)GetMorePositionData
{
    NSUInteger num=_data.count;
    if(num%_QUANTITY){_PAGE=num/_QUANTITY+2;}else{_PAGE=num/_QUANTITY+1;}
    _params[@"PAGE"] =[NSNumber numberWithLong:_PAGE];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:_addr] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"resumeList"];
             if (positionlist.count)
             {
                 for (NSDictionary *dict in positionlist)
                 {
                     ResumeData * PositionFrame = [ResumeData CreateWithlist:dict];
                     [_data addObject: PositionFrame];
                 }
                 [self.tableView reloadData];
             }
             else
             {
                 [MBProgressHUD showError:@"没数据了"];
             }
             [_refreshFooter endRefreshing];
             
         }
     } failure:^(NSError *error)
     {
         [_refreshFooter endRefreshing];
     }];
    
    
}
- (void)GetPositionData
{
    _PAGE=1;

    self.params[@"PAGE"] =[NSNumber numberWithLong:_PAGE];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:_addr] params:_params view:_tableView success:^(id json)
     {

         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"resumeList"];
             [ Global showNoDataImage:_tableView withResultsArray:positionlist];
             if (positionlist.count)
             {
                 NSMutableArray * PositionFrames=[[NSMutableArray alloc]init];
                 for (NSDictionary *dict in positionlist)
                 {
                     ResumeData* PositionFrame = [ResumeData CreateWithlist:dict];
                     [PositionFrames addObject: PositionFrame];
                 }
                 _data=PositionFrames;
                 self.tableView.contentInset=UIEdgeInsetsZero;
                 self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
                 [self.tableView reloadData];
             }
             else
             {
                 _data=nil;
                 self.tableView.contentInset=UIEdgeInsetsZero;
                 [self.tableView reloadData];
             }
         }
     } failure:^(NSError *error)
     {
     }];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResumeCell*cell= [tableView dequeueReusableCellWithIdentifier:@"ResumeCell"];
    if (cell==nil)
    {
        cell = [[ResumeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ResumeCell"];
        if (IS_IOS9) {
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
    }
    cell.data= self.data[indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ResumeCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResumeData * data = self.data[indexPath.row];
    ResumeDetailsController * PositionDetailsTabBar=[[ResumeDetailsController alloc]initWithResumeData:data];
    [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];
}

#pragma mark - UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id)context viewControllerForLocation:(CGPoint) point
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[context sourceView]];
    ResumeData * data = self.data[indexPath.row];
    ResumeDetailsController * PositionDetailsTabBar=[[ResumeDetailsController alloc]initWithResumeData:data];
    [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];
    PositionDetailsTabBar.preferredContentSize = CGSizeMake(0.0f,600.f);
    return nil;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    
    [self showViewController:viewControllerToCommit sender:self];
}

@end
