//
//  ResumeManageController.m
//  LePin-Ent
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "ResumeManageController.h"
#import "ResumeData.h"
#import "ResumeCell.h"
#import "Global.h"
#import "NSString+Hash.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "PositionEntData.h"
#import "ShowItemNumView.h"
#import "ResumeDetailsController.h"
#import "LPLoginNavigationController.h"
#import "HomeEntController.h"


@interface ResumeManageController()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate,UIScrollViewDelegate>
{
    ShowItemNumView * _itemNumView[3];
}
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray * data;
@property (nonatomic, strong) NSMutableArray * data2;
@property (nonatomic, strong) NSMutableArray * data3;
@property (nonatomic, assign) NSUInteger PAGE;
@property (nonatomic, assign) NSUInteger QUANTITY;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (weak, nonatomic) UILabel  * titleLable;
@property (weak, nonatomic) UILabel  * departLable;
@property (weak, nonatomic) UIView * headView;
@property (weak, nonatomic) UIButton * closeBtn;
@property (weak, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UITableView * tableView2;
@property (strong, nonatomic) UITableView * tableView3;
@property (weak, nonatomic) UIView * tipView;
@property (strong, nonatomic) PositionEntData * positionEntData;
@property (assign, nonatomic) NSInteger  type;

@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation ResumeManageController
#define PageMaxItem 20

-(instancetype)initWithData:(PositionEntData *)positionEntData Type:(NSInteger)type
{
    self=[super init];

    _positionEntData=positionEntData;
    self.PAGE=1;
    self.QUANTITY=PageMaxItem;
    _type=type;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"POS_TYPE"]=[NSNumber numberWithInt:1];
    if (USER_ID==nil) {params[@"USER_ID"] = @"";}else{params[@"USER_ID"] = USER_ID;};
    params[@"longitude"] = [NSString stringWithFormat:@"%f",longitude];
    params[@"latitude"] = [NSString stringWithFormat:@"%f",latitude];
    params[@"PAGE"] =[NSNumber numberWithLong:self.PAGE];
    params[@"QUANTITY"] = [NSNumber numberWithLong:self.QUANTITY];
    params[@"SEQ"] = [NSNumber numberWithInt:0];
    params[@"POSITIONPOSTED_ID"] = _positionEntData.POSITIONPOSTED_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_RESUME_FOR_POSITION"];
    params[@"mac"] =mac;
    _params=params;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=LPUIBgColor;
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor  ;
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
    titleLable.text=_positionEntData.POSITIONNAME;
    titleLable.textColor=[UIColor whiteColor];
    [headView addSubview:titleLable];
    
    UILabel  * departLable=[UILabel new];
    _departLable=departLable;
    departLable.font=LPTimeFont;
    departLable.text=_positionEntData.DEPT_NAME;
    departLable.textColor=[UIColor whiteColor];
    departLable.textAlignment=NSTextAlignmentRight;
    [headView addSubview:departLable];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*2, self.scrollView.frame.size.height);
 
    UITableView *tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=LPUIBgColor;
    tableView.bounces = NO;
    [self.scrollView addSubview:tableView];
    [self.scrollView addSubview:self.tableView2];
//    [self.scrollView addSubview:self.tableView3];
    
    UIView  * toolView=[UIView new];
    toolView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:toolView];
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    _headView.frame=CGRectMake(0, 0, width, 64);
    _closeBtn.frame=CGRectMake(10, 20, height*2, height);
    closeBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, _closeBtn.frame.size.width*0.7);
    closeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -_closeBtn.frame.size.width*0.3, 0, 0);
    _titleLable.frame=CGRectMake(width/4, 20, width/2, height);
    departLable.frame=CGRectMake(width/4*3, 30, width/4-10, height-10);
    CGFloat y=CGRectGetMaxY(_headView.frame);
    toolView.frame=CGRectMake(0, y, width, 50);
    CGFloat x=(width-30)/2;
    for (int a=0; a<2; a++) {
        ShowItemNumView * itemNumView=[[ShowItemNumView alloc]init];
        itemNumView.itemTitle.textColor=LPFrontGrayColor;
        itemNumView.itemNum.textColor=LPFrontGrayColor;
        [toolView addSubview:itemNumView];
        _itemNumView[a]=itemNumView;
        itemNumView.tag=a;
        itemNumView.frame=CGRectMake(10+a*(5+x), 10, x, 30);
        [itemNumView addTarget:self action:@selector(toolViewAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    _itemNumView[0].itemTitle.text=@"主动投递";
    _itemNumView[0].itemNum.text=_positionEntData.RESUME_POST_COUNT;
    _itemNumView[1].itemTitle.text=@"系统推荐";
    _itemNumView[1].itemNum.text=_positionEntData.RECOMMEND_COUNT;
//    _itemNumView[2].itemTitle.text=@"考虑中";
//    _itemNumView[2].itemNum.text=_positionEntData.THINKING_COUNT;
    
    y=y+50;
    _tableView.frame=CGRectMake(0, 0, width, self.scrollView.frame.size.height);
    
    [self setupFooter];
    [self initToolView];
}
- (void)initToolView
{
    for (int a=0; a<2; a++)
    {
        if (a==_type)
        {
            _itemNumView[a].itemTitle.textColor=LPUIMainColor;
            _itemNumView[a].itemNum.textColor=LPUIMainColor;
        }
        else
        {
            _itemNumView[a].itemTitle.textColor=LPFrontGrayColor;
            _itemNumView[a].itemNum.textColor=LPFrontGrayColor;
        }
    }
    [self geitSW];
//    [self GetPositionData];
    
}

- (void)geitSW
{
    switch (_type) {
        case 0:
            _scrollView.contentOffset = CGPointMake(0, 0);
            break;
        case 1:
            _scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
            break;
        case 2:
            _scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width*2, 0);
            break;
            
        default:
            break;
    }
}

- (void)toolViewAction:(UIControl *)btn
{
    
    if (_type==btn.tag) {return;}
    _type=btn.tag;
    [self geitSW];
    for (int a=0; a<3; a++)
    {
        if (a==btn.tag)
        {
            _itemNumView[a].itemTitle.textColor=LPUIMainColor;
            _itemNumView[a].itemNum.textColor=LPUIMainColor;
        }
        else
        {
            _itemNumView[a].itemTitle.textColor=LPFrontGrayColor;
            _itemNumView[a].itemNum.textColor=LPFrontGrayColor;
        }
    }
    [self GetPositionData];
    
}
- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    switch (_type) {
        case 0:
            [refreshFooter addToScrollView:self.tableView isEffectedByNavigationController:NO];
            break;
        case 1:
            [refreshFooter addToScrollView:self.tableView2 isEffectedByNavigationController:NO];
            break;
        case 2:
            [refreshFooter addToScrollView:self.tableView3 isEffectedByNavigationController:NO];
            break;
            
        default:
            break;
    }
    
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
    self.params[@"longitude"] = [NSString stringWithFormat:@"%f",longitude];
    self.params[@"latitude"] = [NSString stringWithFormat:@"%f",latitude];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getResumeListForPosition.do"] params:_params success:^(id json)
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self GetPositionData];
}
- (void)GetPositionData
{
    _PAGE=1;
    self.params[@"PAGE"] =[NSNumber numberWithLong:_PAGE];
    self.params[@"TYPE"] =[NSNumber numberWithLong:_type+1];
    self.params[@"longitude"] = [NSString stringWithFormat:@"%f",longitude];
    self.params[@"latitude"] = [NSString stringWithFormat:@"%f",latitude];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getResumeListForPosition.do"] params:_params view:nil success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         
         NSLog(@"%@",json);
         
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"resumeList"];
             NSDictionary * count =[json objectForKey:@"count"];
             NSNumber * RESUME_POST_COUNT=[count objectForKey:@"RESUME_POST_COUNT"];
             NSNumber * THINKING_COUNT=[count objectForKey:@"THINKING_COUNT"];
             _itemNumView[0].itemNum.text=_positionEntData.RESUME_POST_COUNT=[NSString stringWithFormat:@"%@",RESUME_POST_COUNT];
             _itemNumView[2].itemTitle.text=@"考虑中";
             _itemNumView[2].itemNum.text=_positionEntData.THINKING_COUNT=[NSString stringWithFormat:@"%@",THINKING_COUNT];
             HomeEntController *hc=[HomeEntController sharedManager];
             [hc refreshTableView];
             NSLog(@"--------%ld",_type);
             NSLog(@"%ld",positionlist.count);
             if (_type == 0) {
                 [ Global showNoDataImage:_tableView withResultsArray:positionlist];
                
             }
             if (_type == 1) {
                 [ Global showNoDataImage:self.tableView2 withResultsArray:positionlist];
                 
             }
             if (_type == 2)
             {
                 [ Global showNoDataImage:self.tableView3 withResultsArray:positionlist];
                 
             }
             
             if (positionlist.count)
             {
                 NSMutableArray * PositionFrames=[[NSMutableArray alloc]init];
                 for (NSDictionary *dict in positionlist)
                 {
                     ResumeData* PositionFrame = [ResumeData CreateWithlist:dict];
                     [PositionFrames addObject: PositionFrame];
                 }
                 
                 self.tableView.contentInset=UIEdgeInsetsZero;
               //  self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
                 if (_type == 0) {
                     _data=PositionFrames;
                     [self.tableView reloadData];
                 }
                 if (_type == 1) {
                     self.data2 = PositionFrames;
                     [self.tableView2 reloadData];
                 }
                 if (_type == 2)
                 {
                     self.data3 = PositionFrames;
                     [self.tableView3 reloadData];
                 }
                 
             }
             else
             {
                 if (_type == 0) {
                     _data=nil;
                     [self.tableView reloadData];
                 }
                 if (_type == 1) {
                     self.data2 = nil;
                     [self.tableView2 reloadData];
                 }
                 if (_type == 2)
                 {
                     self.data3 = nil;
                     [self.tableView3 reloadData];
                 }
               //  self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
             }
             
         }
     } failure:^(NSError *error)
     {
     }];
}

#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{return 1;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"type - %ld",(long)_type);
    if (tableView == _tableView) {
        return self.data.count;
    }
    if (tableView == _tableView2) {
        return self.data2.count;
    }
    if (tableView == _tableView3)
    {
        return self.data3.count;
    }
    return 0;
    
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
    NSLog(@"newType = %ld",(long)_type);
    if (tableView == _tableView) {
        cell.data= self.data[indexPath.row];
        return cell;
    }
    if (tableView == _tableView2) {
        cell.data= self.data2[indexPath.row];
        return cell;
    }
    if (tableView == _tableView3)
    {
        cell.data= self.data3[indexPath.row];
        return cell;
    }
    return nil;
    

}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ResumeCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(USER_ID==nil)
    {
        
        LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^
                                          {
                                              if (USER_ID!=nil)
                                              {
                                                  ResumeData * data = self.data[indexPath.row];
                                                  if (_type==0) {
                                                      data.newItem=1;
                                                  }
                                                  ResumeDetailsController * PositionDetailsTabBar=[[ResumeDetailsController alloc]initWithResumeData:data];
                                                  [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];
                                              }
                                          }];
        [self presentViewController:vc animated: YES completion: nil];
    }
    else
    {
        ResumeData * data;
        if (tableView == _tableView) {
             data = self.data[indexPath.row];

        }
        if (tableView == _tableView2) {
              data = self.data2[indexPath.row];

        }
        if (tableView == _tableView3)
        {
            data = self.data3[indexPath.row];

        }
        if (_type==0) {
            data.newItem=1;
        }
        ResumeDetailsController * PositionDetailsTabBar=[[ResumeDetailsController alloc]initWithResumeData:data];
        [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}
#pragma mark - UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id)context viewControllerForLocation:(CGPoint) point
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[context sourceView]];
    ResumeData * data = self.data[indexPath.row];
    ResumeDetailsController * PositionDetailsTabBar=[[ResumeDetailsController alloc]initWithResumeData:data];
    //    [self.navigationController.navigationBar setHidden:NO];
    //    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];
    PositionDetailsTabBar.preferredContentSize = CGSizeMake(0.0f,600.f);
    return nil;
}
//- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
//{
//    
//    [self showViewController:viewControllerToCommit sender:self];
//}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+50, self.view.frame.size.width, self.view.frame.size.height - 64-50)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        
    }
    return _scrollView;
}



- (UITableView *)tableView2
{
    if (!_tableView2) {
        _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) style:UITableViewStyleGrouped];
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.backgroundColor = LPUIBgColor;
        _tableView2.bounces = NO;
    }
    return _tableView2;
}

- (UITableView *)tableView3
{
    if (!_tableView3) {
        _tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width*2, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) style:UITableViewStyleGrouped];
        _tableView3.delegate = self;
        _tableView3.dataSource = self;
        _tableView3.backgroundColor = LPUIBgColor;
        _tableView3.bounces = NO;
    }
    return _tableView3;
}

- (NSMutableArray *)data2
{
    if (!_data2) {
        _data2 = [NSMutableArray array];
    }
    return _data2;
}

- (NSMutableArray *)data3
{
    if (!_data3) {
        _data3 = [NSMutableArray array];
    }
    return _data3;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"%f",scrollView.contentOffset.x);
//    ShowItemNumView * itemNumView;
//    if (scrollView.contentOffset.x == self.view.frame.size.width) {
//        itemNumView = [self.view viewWithTag:1];
//        
//        [self toolViewAction:itemNumView];
//    }
//    if (scrollView.contentOffset.x == self.view.frame.size.width*2) {
//        itemNumView = [self.view viewWithTag:2];
//        [self toolViewAction:itemNumView];
//    }
//    if (scrollView.contentOffset.x == self.view.frame.size.width) {
//        itemNumView = [self.view viewWithTag:1];
//        
//        [self toolViewAction:itemNumView];
//    }
//    if (scrollView.contentOffset.x == 0) {
//        itemNumView = [self.view viewWithTag:0];
//        [self toolViewAction:itemNumView];
//    }
//}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.x);
    ShowItemNumView * itemNumView;
    if (scrollView.contentOffset.x == self.view.frame.size.width) {
        itemNumView = [self.view viewWithTag:1];
        
        [self toolViewAction:itemNumView];
    }
    if (scrollView.contentOffset.x == self.view.frame.size.width*2) {
        itemNumView = [self.view viewWithTag:2];
        [self toolViewAction:itemNumView];
    }
    if (scrollView.contentOffset.x == self.view.frame.size.width) {
        itemNumView = [self.view viewWithTag:1];
        
        [self toolViewAction:itemNumView];
    }
    if (scrollView.contentOffset.x == 0) {
        itemNumView = [self.view viewWithTag:0];
        [self toolViewAction:itemNumView];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.x);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    ShowItemNumView * itemNumView;
    if (_scrollView.contentOffset.x == self.view.frame.size.width) {
        itemNumView = [self.view viewWithTag:1];
        
        [self toolViewAction:itemNumView];
    }
    if (_scrollView.contentOffset.x == self.view.frame.size.width*2) {
        itemNumView = [self.view viewWithTag:2];
        [self toolViewAction:itemNumView];
    }
    if (_scrollView.contentOffset.x == self.view.frame.size.width) {
        itemNumView = [self.view viewWithTag:1];
        
        [self toolViewAction:itemNumView];
    }
    if (_scrollView.contentOffset.x == 0) {
        itemNumView = [self.view viewWithTag:0];
        [self toolViewAction:itemNumView];
    }
    
}

@end
