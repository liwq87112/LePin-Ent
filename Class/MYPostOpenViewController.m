//
//  MYPostOpenViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/1/6.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "MYPostOpenViewController.h"
#import "Global.h"
#import "LPEOpenPositionsViewController.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "postModel.h"
#import "LPEMyPostTableViewCell.h"
#import "SDRefresh.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "LPEPostDetaViewController.h"
#import "LPXGBussLicViewController.h"
#import "LPWZPListViewController.h"
#import "LPLoginNavigationController.h"

#define serverW [UIScreen mainScreen].bounds.size.width
#define serverH [UIScreen mainScreen].bounds.size.height
#define QUANTITY 10

@interface MYPostOpenViewController ()<UITableViewDelegate,UITableViewDataSource,SDRefreshViewAnimationDelegate,UIAlertViewDelegate>
{
    BOOL seleBool;
}
@property (nonatomic, strong) SDRefreshFooterView * refreshFooter;
@property (nonatomic, strong) SDRefreshHeaderView * refreshHeader;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *bgtableView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic, assign) NSInteger SeleIndex;
@property (nonatomic, strong) NSMutableArray *seleIndexArr;

@property (nonatomic, strong) NSMutableArray *delpArray;
@property (nonatomic, strong) NSArray *zhuandArray;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) BOOL opSend;

@property (nonatomic, strong) UIView *opVIew;

@end

@implementation MYPostOpenViewController

+ (MYPostOpenViewController *)sharedManager
{
    static MYPostOpenViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableDictionary *)params
{
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

- (NSMutableArray *)delpArray
{
    if (!_delpArray) {
        _delpArray = [NSMutableArray array];
    }
    return _delpArray;
}

- (NSMutableArray *)seleIndexArr
{
    if (!_seleIndexArr) {
        _seleIndexArr = [NSMutableArray array];
    }
    return _seleIndexArr;
}

- (UIView *)opVIew
{
    CGFloat w = self.view.frame.size.width;
    if (!_opVIew) {
        _opVIew = [[UIView alloc]initWithFrame:CGRectMake(0, serverH-40-48, w, 40)];
        _opVIew.backgroundColor = [UIColor whiteColor];
        UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame = CGRectMake(10, 8, w-20, 24);
        [but1 setTitle:@"发布新职位" forState:UIControlStateNormal];
        [but1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        but1.titleLabel.font = [UIFont systemFontOfSize:15];
        [but1 addTarget:self action:@selector(openSend) forControlEvents:UIControlEventTouchUpInside];
        but1.backgroundColor = LPUIMainColor;
//        but1.layer.borderWidth = 0.5;
        but1.layer.cornerRadius = 5;
//        but1.layer.borderColor = [[UIColor orangeColor]CGColor];
        [_opVIew addSubview:but1];
    }
    return _opVIew;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = LPUIBgColor;
    _zhuandArray = @[@"不限",@"待审核",@"已发布",@"不通过",@"下线"];
    [self getNav];
    
    self.bgtableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+30, serverW, serverH) style:UITableViewStyleGrouped];
    _bgtableView.delegate = self;
    _bgtableView.dataSource = self;
    _bgtableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _bgtableView.backgroundColor = [UIColor whiteColor];
    [self deparPost];
}

- (void)getNav
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    headView.backgroundColor = LPUIMainColor;
    [self.view addSubview:headView];
//    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//    but.frame = CGRectMake(0, 18, 60, 54);
//    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
//    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [but addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat w =self.view.frame.size.width;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((w-120)/2, 18, 120, 55)];
    label.text = @"职位";
    [label setTextAlignment:NSTextAlignmentCenter];
    label.textColor = [UIColor whiteColor];


    [headView addSubview:label];
//    [headView addSubview:but];
//    [headView addSubview:but1];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.opVIew];
    
    
    [self getBut];
    
    [self setupHeader];
    [self setupFooter];

    [self.tableView registerNib:[UINib nibWithNibName:@"LPEMyPostTableViewCell" bundle:nil] forCellReuseIdentifier:@"LPEMyPostTableViewCell"];

}

- (void)getBut
{
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, serverW, 30)];
    [self.view addSubview:toolView];
    UIButton *areaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    areaBtn.frame = CGRectMake(0, 0, serverW/2-0.5, 30);
    [areaBtn setTitle:@"部门"  forState:UIControlStateNormal];
    [areaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    areaBtn.tag = 33;
    [areaBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    areaBtn.titleLabel.font=LPContentFont;
    [areaBtn setImage:[UIImage imageNamed:@"筛选小三角灰"] forState:UIControlStateNormal];
    [areaBtn setImage:[UIImage imageNamed:@"筛选小三角蓝"] forState:UIControlStateSelected];
    CGFloat ww = (serverW-1)/2;
    areaBtn.titleEdgeInsets=UIEdgeInsetsMake(5, 0, 5, ww*0.2);
    areaBtn.imageEdgeInsets=UIEdgeInsetsMake(5, ww*0.8, 5, ww*0.05);
    
    [areaBtn addTarget:self action:@selector(delp:) forControlEvents:UIControlEventTouchUpInside];
    areaBtn.backgroundColor = [UIColor whiteColor];
    [toolView addSubview:areaBtn];
    
    UIButton *industryBut = [UIButton buttonWithType:UIButtonTypeCustom];
    industryBut.frame = CGRectMake(serverW/2+0.5, 0, serverW/2, 30);
    [industryBut setTitle:@"状态" forState:UIControlStateNormal];
    [industryBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [industryBut setTitleColor:LPUIMainColor forState:UIControlStateSelected];
    industryBut.tag = 34;
    [industryBut setImage:[UIImage imageNamed:@"筛选小三角灰"] forState:UIControlStateNormal];
    [industryBut setImage:[UIImage imageNamed:@"筛选小三角蓝"] forState:UIControlStateSelected];
    industryBut.titleEdgeInsets=UIEdgeInsetsMake(5, 0, 5, ww*0.2);
    industryBut.imageEdgeInsets=UIEdgeInsetsMake(5, ww*0.8, 5, ww*0.05);
    industryBut.titleLabel.font=LPContentFont;
    [industryBut addTarget:self action:@selector(delp:) forControlEvents:UIControlEventTouchUpInside];
    industryBut.backgroundColor = [UIColor whiteColor];
    toolView.backgroundColor = [UIColor lightGrayColor];
    [toolView addSubview:industryBut];

    [self boolShowAlert];
}

- (void)delp:(UIButton *)butt
{
    [self.bgtableView reloadData];
    butt.selected = !butt.selected;
    if (_SeleIndex != 0) {
        UIButton *but = [self.view viewWithTag:_SeleIndex];
        but.selected = NO;
    }
    if (!butt.selected) {
        [self tap];
        for (NSString *str in self.seleIndexArr) {
            if ([str integerValue] == butt.tag) {
                [_seleIndexArr removeObject:str];
                break;
            }
        }
        self.SeleIndex = 0;
        return;
    }
    self.SeleIndex = butt.tag;
    
    for (NSString *str in self.seleIndexArr) {
        if ([str integerValue] == butt.tag) {
            
        }else{
        [_seleIndexArr addObject:[NSString stringWithFormat:@"%ld",self.SeleIndex]];
            break;
        }
    }
    _bgtableView.frame = CGRectMake(0, 64+30, serverW, 44*5);
    
    [self.view addSubview:_bgtableView];
    [_bgtableView reloadData];
    [self.view addSubview:self.bgView];
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgtableView.frame), serverW, serverH - CGRectGetMaxY(self.bgtableView.frame))];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [_bgView addGestureRecognizer:tap];
        
    }
    return _bgView;
}

- (void)tap{
    
    if (self.SeleIndex) {
        UIButton *but = [self.view viewWithTag:self.SeleIndex];
        self.SeleIndex = 0;
        but.selected = NO;
    }
    [_bgView removeFromSuperview];
    [_bgtableView removeFromSuperview];
}

- (void)goB{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)openSend
{
    if (!USER_ID) {
        LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^{
            if (USER_ID!=nil)
            {
//                LPEOpenPositionsViewController *send = [[LPEOpenPositionsViewController alloc]initWithNibName:@"LPEOpenPositionsViewController" bundle:nil];
//                [self.navigationController pushViewController:send animated:YES];
            }
        }];
        [self presentViewController:vc animated: YES completion: nil];
    }else{
    
    
//    if (!_boolYesOrPrf) {
//        NSString  * message=@"您的招聘资料未完善，不能发布职位";
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
//                                  @"温馨提示" message:message delegate:self
//                                                 cancelButtonTitle:@"浏览其它页面" otherButtonTitles:@"完善资料", nil];
//        alertView.tag = 1;
//        [alertView show];
//        return;
//    }
    
    if (_opSend) {
        if (self.dataArray.count < 3) {
            LPEOpenPositionsViewController *send = [[LPEOpenPositionsViewController alloc]initWithNibName:@"LPEOpenPositionsViewController" bundle:nil];
            [self.navigationController pushViewController:send animated:YES];
        }else
        {
//            [MBProgressHUD showError:@"未上传营业执照，只能发布两个职位"];
            NSString  * message=@"您的身份认证资料未上传,只能发布两个职位,请及时认证";
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                      @"温馨提示" message:message delegate:self
                                                     cancelButtonTitle:@"取消" otherButtonTitles:@"立即认证", nil];
            alertView.tag = 2;
            [alertView show];
        }
    }
    else{
        LPEOpenPositionsViewController *send = [[LPEOpenPositionsViewController alloc]initWithNibName:@"LPEOpenPositionsViewController" bundle:nil];
        [self.navigationController pushViewController:send animated:YES];
    }
    }
}

//判断是否身份认证
- (void)boolShowAlert
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITION_BY_USER"];
    params[@"ENT_ID"] = ENT_ID;
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getIsauthen.do"] params:params view:_tableView success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSNumber * isauthen= [json objectForKey:@"ISAUTHEN"];
         if(1==[result intValue])
         {
             switch ( [isauthen intValue] ) {
                 case 0:
                     _opSend = YES;
                     break;

                     break;
                 case 3:
                     _opSend = YES;
                     break;
                 default:
                     break;
             }
         }
     } failure:^(NSError *error)
     {
     }];
    
}

- (void)getData
{
    _page = 1;
    
  self.params[@"USER_ID"] = USER_ID;
    self.params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"ENT_G_POSITION"];
    self.params[@"PAGE"] = [NSNumber numberWithInteger:_page];
     self.params[@"QUANTITY"] =  [NSNumber numberWithInteger:QUANTITY];

    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionPosted.do"] params:self.params view:self.tableView success:^(id json) {
        NSNumber * result = json[@"result"];
        if ([result intValue] == 1) {
            [Global showNoDataImage:_tableView withResultsArray:json[@"positionPostList"]];
            self.dataArray = [postModel dataWithDict:json];
        }
        [self.tableView reloadData];
        [_refreshHeader endRefreshing];
    } failure:^(NSError * error) {
        [_refreshHeader endRefreshing];
    }];
}

- (void)getMoreData
{
    self.params[@"PAGE"] = [NSNumber numberWithInteger:_page+1];
//    self.params[@"QUANTITY"] =  [NSNumber numberWithInteger:QUANTITY];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionPosted.do"] params:self.params view:self.tableView success:^(id json) {
        NSNumber * result = json[@"result"];
        if ([result intValue] == 1) {
            NSMutableArray *arrat = [NSMutableArray array];
            arrat = [postModel dataWithDict:json];
            if (arrat.count >0) {
                for (postModel *model in arrat) {
                    [self.dataArray addObject:model];
                }
                _page ++;
            }
            else{
                [MBProgressHUD showError:@"没数据了"];
            }
        }
        [self.tableView reloadData];
        [_refreshFooter endRefreshing];
    } failure:^(NSError * error) {
        [_refreshFooter endRefreshing];
    }];
    
}

- (void)deparPost
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_MY_DEPT"];
    params[@"USER_ID"] = USER_ID;
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getMyDept.do?"] params:params success:^(id json) {
        NSNumber *result = json[@"result"];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:json[@"depts"]];
        if ([result intValue] == 1) {
            self.delpArray = arr;

        }
    } failure:^(NSError *error) {
        
    }];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+30, serverW, serverH-64-30-50-40) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;        
    }
    return _tableView;
}

-(void)dealloc
{
    [_refreshHeader free];
    [_refreshFooter free];
}
- (void)footerRefresh
{
    [Global getLatWithBlock:^{
        [self getMoreData];
    }];
}
- (void)headerRefresh
{
    [Global getLatWithBlock:^{
        [self getData];
    }];
}
- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshViewWithStyle:SDRefreshViewStyleClassical];
    refreshHeader.delegate = self;
    [refreshHeader addToScrollView:_tableView];
    _refreshHeader = refreshHeader;
    [refreshHeader addTarget:self refreshAction:@selector(headerRefresh)];
}
- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    refreshFooter.delegate = self;
    [refreshFooter addToScrollView:_tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_bgtableView == tableView) {
        UIButton *but = [self.view viewWithTag:33];
        if (but.selected) {
            return _delpArray.count;
        }else{
            return _zhuandArray.count;
        }
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _bgtableView) {
        static NSString *str = @"my";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        UIButton *but = [self.view viewWithTag:33];
        if (but.selected) {
            cell.textLabel.text = self.delpArray[indexPath.row][@"DEPT_NAME"];;
        }else{
            cell.textLabel.text = _zhuandArray[indexPath.row];
        }
        return cell;
        
    }else{
    LPEMyPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPEMyPostTableViewCell"];
    cell.modelData = self.dataArray[indexPath.row];
        return cell;}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_bgtableView == tableView) {
        UIButton *but = [self.view viewWithTag:self.SeleIndex];
        NSString *str;
        if (self.SeleIndex == 33) {
            str=self.delpArray[indexPath.row][@"DEPT_NAME"];
            self.params[@"DEPT_ID"] = self.delpArray[indexPath.row][@"DEPT_ID"];
        }else{
            str =_zhuandArray[indexPath.row];
            
            switch (indexPath.row) {
                case 0:
                    self.params[@"STATE"] = nil;
                    break;
                case 1:
                    self.params[@"STATE"] = @1;
                    break;
                case 2:
                    self.params[@"STATE"] = @3;
                    break;
                case 3:
                    self.params[@"STATE"] = @2;
                    break;
                case 4:
                    self.params[@"STATE"] = @5;
                    break;
                
                default:
                    break;
            }
            
            
        }

        [but setTitle:str forState:UIControlStateNormal];
        [self tap];
        [self getData];
    }else{
    LPEPostDetaViewController *deta = [[LPEPostDetaViewController alloc]init];
    deta.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:deta animated:YES];}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bgtableView == tableView) {
        return 44;
    }
    return 95;
}


- (void)viewWillAppear:(BOOL)animated
{
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2) {
        if(buttonIndex==1)
        {
            LPXGBussLicViewController *bus = [[LPXGBussLicViewController alloc]init];
            [self.navigationController pushViewController:bus animated:YES];
        }
    }
    if (alertView.tag == 1) {
        if(buttonIndex==1)
        {
            LPWZPListViewController *zp = [[LPWZPListViewController alloc]init];
            [self.navigationController pushViewController:zp animated:YES];
        }
    }
    
}



@end
