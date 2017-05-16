//
//  EntFilterViewController.m
//  LePin-Ent
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntFilterViewController.h"
#import "LPFilterToolView.h"
#import "Global.h"
#import "SelectAreaViewController.h"
#import "SelectIndustryController.h"
#import "categoryData.h"
#import "Global.h"
#import "NSString+Hash.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "BasicData.h"
#import "EntMoreFilterController.h"
typedef void (^CompleteBlock)();
@interface EntFilterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  SelectAreaViewController * areaController;
@property (strong, nonatomic)  SelectIndustryController * industryController;
@property (strong, nonatomic)  EntMoreFilterController * moreFilterController;
@property (strong, nonatomic) AreaData *SelectAreaData;
@property (copy, nonatomic) CompleteBlock completeBlock;
@property (weak, nonatomic)  UIControl * bgView;
@property (strong, nonatomic)NSMutableDictionary * params;
@property (assign, nonatomic)NSInteger selectNum;
@property (strong, nonatomic) categoryData *selectData;
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray * data;
@end
@implementation EntFilterViewController
-(void)setOpenViewRect:(CGRect)openViewRect
{
    _openViewRect=openViewRect;
    openViewRect.size.height=44;
    _closeViewRect=openViewRect;
    self.view.frame=openViewRect;
}
-(instancetype)initWithArea:(AreaData *)SelectAreaData params:(NSMutableDictionary*)params  Block:completeBlock
{
    self =[super init];
    if (self) {
        //_searchBar=searchBar;
        _SelectAreaData=SelectAreaData;
        _completeBlock=completeBlock;
        _params=params;
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIControl *bgView=[UIControl new];
    bgView.backgroundColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.5];
    bgView.tag=0;
    [self.view addSubview:bgView];
    CGFloat x=self.view.frame.size.height-44-64;
    bgView.frame=CGRectMake(0,44-x, self.view.frame.size.width, x);
    [bgView addTarget:self  action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    _bgView=bgView;
    
    LPFilterToolView * toolView=[[LPFilterToolView alloc]initWithTitleArray:@[@"地区",@"行业",@"时间",@"更多"]];
    _toolView=toolView;
    toolView.frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
    [self.view addSubview:toolView];
    
    UIView *lineTop=[UIView new];
    lineTop.backgroundColor=[UIColor lightGrayColor];
    [toolView addSubview:lineTop];
    lineTop.frame=CGRectMake(0, 0, self.view.frame.size.width, 0.5);
    
    UIView *lineButtom=[UIView new];
    lineButtom.backgroundColor=[UIColor lightGrayColor];
    [toolView addSubview:lineButtom];
    lineButtom.frame=CGRectMake(0, 44-0.5, self.view.frame.size.width, 0.5);
    
    //    CGRect rect=self.view.frame;
    //    rect.size.height=44;
    //    self.view.frame=rect;
    
    if (_SelectAreaData.CITY_NAME!=nil) {
        UIButton *btn = toolView.views[0];
        [btn setTitle:_SelectAreaData.CITY_NAME forState:UIControlStateNormal];
    }
    
    
    NSInteger num=0;
    for (UIButton *btn in toolView.views) {
        btn.tag=num;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        num++;
    }
    
}
-(void)showBgView:(BOOL)show
{
    if (show )
    {
        [UIView animateWithDuration:0.5 animations:^{
            _bgView.transform = CGAffineTransformMakeTranslation(0,_bgView.frame.size.height);
        } completion:^(BOOL finished) {
            _bgView.tag=show;
            self.view.frame=_openViewRect;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            _bgView.transform = CGAffineTransformMakeTranslation(0,0);
        } completion:^(BOOL finished) {
            _areaController=nil;
            _moreFilterController=nil;
            _tableView=nil;
            self.view.frame=_closeViewRect;
            _bgView.tag=show;
        }];
    }
}
-(void)btnAction:(UIButton *)btn
{
    [self.view endEditing:YES];
    if (_bgView.tag) {
        [self checkInput:_toolView.tag];
    }
    switch (btn.tag) {
        case 0:
            if(_areaController==nil)
            {
                [self selectArea];
                btn.selected=YES;
                _toolView.tag=0;
            }
            else
            {
                [self showBgView:NO];
                self.areaController=nil;
                btn.selected=NO;
                
            }
            
            break;
        case 1:
            if (_industryController==nil) {
                [self selectIndustry];
                _toolView.tag=1;
            }
            else
            {
                [self showBgView:NO];
                self.industryController=nil;
                if ([self.params objectForKey:@"INDUSTRYNATURE_ID1"]==nil) {
                    btn.selected=NO;
                }
                
                
            }
            break;
        case 2:
            [self selectPosition];
            break;
        case 3:
            
            [self selectMoreFilter];
            break;
        default:
            break;
    }
}
-(void)closeFilter
{
    if (_bgView.tag) {
        [self checkInput:_toolView.tag];
        [self showBgView:NO];
    }
    
}
-(void)checkInput:(NSInteger)num
{
    switch (_toolView.tag) {
        case 0:
        {
            UIButton * beforeBtn=_toolView.views[0];
            beforeBtn.selected=NO;
        }
            break;
            
        case 1:
            if ([self.params objectForKey:@"INDUSTRYNATURE_ID1"]==nil) {
                UIButton * beforeBtn=_toolView.views[1];
                beforeBtn.selected=NO;
            }
            break;
        case 2:
            if ([self.params objectForKey:@"UPDATETONOW"]==nil) {
                UIButton * beforeBtn=_toolView.views[2];
                beforeBtn.selected=NO;
            }
            break;
        case 3:
            if (![self checkMoreFilter]) {
                UIButton * beforeBtn=_toolView.views[3];
                beforeBtn.selected=NO;
            }
            break;
        default:
            break;
    }
}
-(void)selectArea
{
    UIButton *btn = _toolView.views[0];
    __block typeof(self) weakSelf=self;
    SelectAreaViewController *areaController=[[SelectAreaViewController alloc]initWithType:AreaTypeVillageFilter andAreData:_SelectAreaData currentArea:currentArea CompleteBlock:^(AreaData *SelectAreaData){
        weakSelf.SelectAreaData=SelectAreaData;
        NSInteger a=weakSelf.SelectAreaData.AreaType.intValue;
        weakSelf.params[@"areaType"] =weakSelf.SelectAreaData.AreaType;
        switch (a) {
            case 1:
                weakSelf.params[@"areaId"]=weakSelf.SelectAreaData.PROVINCE_ID;
                [btn setTitle:weakSelf.SelectAreaData.PROVINCE_NAME forState:UIControlStateNormal];
                break;
            case 2:
                weakSelf.params[@"areaId"]=weakSelf.SelectAreaData.CITY_ID;
                [btn setTitle:weakSelf.SelectAreaData.CITY_NAME forState:UIControlStateNormal];
                break;
            case 3:
                weakSelf.params[@"areaId"]=weakSelf.SelectAreaData.County_ID;
                [btn setTitle:weakSelf.SelectAreaData.County_NAME forState:UIControlStateNormal];
                break;
            case 4:
                weakSelf.params[@"areaId"]=weakSelf.SelectAreaData.TOWN_ID;
                [btn setTitle:weakSelf.SelectAreaData.TOWN_NAME forState:UIControlStateNormal];
                break;
            case 5:
                weakSelf.params[@"areaId"]=weakSelf.SelectAreaData.VILLAGE_ID;
                [btn setTitle:weakSelf.SelectAreaData.VILLAGE_NAME forState:UIControlStateNormal];
                break;
        }
        
        weakSelf.completeBlock();
        btn.selected=NO;
        [weakSelf showBgView:NO];
        weakSelf.areaController=nil;
    }];
    //[self addChildViewController:areaController];
    [self removeBGChildView];
    [_bgView addSubview:areaController.view];
    _areaController=areaController;
    areaController.view.frame=CGRectMake(0, 0, _bgView.frame.size.width,  _bgView.frame.size.height);
    [areaController setViewFrame];
    
    [self showBgView:YES];
    //[self addChildViewController:areaController];
}


-(void)selectIndustry
{
    UIButton *btn = _toolView.views[1];
    if (_industryController==nil) {
        __block typeof(self) weakSelf=self;
        
        SelectIndustryController *industryController=[[SelectIndustryController alloc]initWithType:YES Block:^(categoryData * selectData){
            weakSelf.selectData=selectData;
            //[btn setTitleColor:LPUIMainColor forState:UIControlStateNormal];
            //weakSelf.params[@"INDUSTRYCATEGORY_ID"]=weakSelf.selectData.IndustryCategoriesID;
            if (weakSelf.selectData.PURPOSE_INDUSTRY_ID1==nil) {
                [weakSelf.params removeObjectForKey:@"INDUSTRYNATURE_ID1"];
                btn.selected=NO;
            }
            else
            {
                weakSelf.params[@"INDUSTRYNATURE_ID1"]=weakSelf.selectData.PURPOSE_INDUSTRY_ID1;
                btn.selected=YES;
            }
            if (weakSelf.selectData.PURPOSE_INDUSTRY_ID2==nil) {
                [weakSelf.params removeObjectForKey:@"INDUSTRYNATURE_ID2"];
            }else
            {
                weakSelf.params[@"INDUSTRYNATURE_ID2"]=weakSelf.selectData.PURPOSE_INDUSTRY_ID2;
            }
            if (weakSelf.selectData.PURPOSE_INDUSTRY_ID3==nil) {
                [weakSelf.params removeObjectForKey:@"INDUSTRYNATURE_ID3"];
            }else
            {
                weakSelf.params[@"INDUSTRYNATURE_ID3"]=weakSelf.selectData.PURPOSE_INDUSTRY_ID3;
            }
            
            //            INDUSTRYNATURE_ID2
            [btn setTitle:selectData.URPOSE_INDUSTRY_NAME1 forState:UIControlStateSelected];
            weakSelf.completeBlock();
            [weakSelf showBgView:NO];
            weakSelf.areaController=nil;
            _industryController= nil;
            //[self.navigationController popViewControllerAnimated:NO];
        }];
        
        //        SelectIndustryController
        
        industryController.seleData =_selectData;
        [self removeBGChildView];
        [_bgView addSubview:industryController.view];
        _industryController=industryController;
        industryController.view.frame=CGRectMake(0, 0, _bgView.frame.size.width,  _bgView.frame.size.height);
        [industryController setViewFrame];
        [self showBgView:YES];
        btn.selected =YES;
    }
    
}

-(void)selectPosition
{
    UIButton *btn = _toolView.views[2];
    if (_tableView==nil) {
        if (_data==nil) {
            [self GetPositionLevel];
        }
        else{
            [self CreateTableView];
        }
        
    }
    else
    {
        [self showBgView:NO];
        if ([self.params objectForKey:@"UPDATETONOW"]==nil) {
            btn.selected=NO;
        }
    }
}
-(void)selectMoreFilter
{
    UIButton *btn = _toolView.views[3];
    if (_moreFilterController==nil) {
        [self GetMoreFilter];
    }
    else
    {
        [self showBgView:NO];
        
        if (![self checkMoreFilter]) {
            btn.selected=NO;
        }
    }
}
-(BOOL)checkMoreFilter
{
    BOOL  x=0;
    NSArray * listName=@[@"SEX",@"AGE_E",@"AGE_S",@"MONTHLYPAY_S",@"MONTHLYPAY_E"];
    for (NSString * name in listName)
    {
        NSNumber *num= [_params objectForKey:name];
        if (num!=nil) {
            x=YES;
            break;
        }
    }
    return x;
}
- (void)GetPositionLevel
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BIANMA"] = @"UPDATETONOW";
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBaseDataByCode.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * list =[json objectForKey:@"baseDataList"];
             if (list.count>0) {
                 NSMutableArray *array=[NSMutableArray array];
                 BasicData * data = [[BasicData alloc]init];
                 data.NAME=@"不限";
                 [array addObject: data];
                 for (NSDictionary *dict in list) {
                     BasicData * data = [BasicData BasicWithlist:dict];
                     // if ([data.NAME isEqualToString:@"不限"]){continue;}
                     [array addObject: data];
                 }
                 _data=array;
                 [self CreateTableView];
             }
             
         }
     } failure:^(NSError *error) {}];
}
-(void)CreateTableView
{
    UITableView * tableView=[UITableView new];
    tableView.dataSource=self;
    tableView.delegate=self;
    CGFloat w=_bgView.frame.size.width/2;
    tableView.frame=CGRectMake(w, 0, w, _bgView.frame.size.height-60);
    //tableView.contentInset=UIEdgeInsetsMake(44, 0, 0, 0);
    [self removeBGChildView];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [_bgView addSubview:tableView];
    _tableView=tableView;
    
    
    //                 UIButton * cleanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //                 [cleanBtn setTitleColor:LPUIMainColor forState:UIControlStateNormal];
    //                 cleanBtn.backgroundColor=[UIColor whiteColor];
    //                 [cleanBtn setTitle:@"不限" forState:UIControlStateNormal];
    //                 cleanBtn.frame=CGRectMake(0, 0, tableView.frame.size.width, 44 );
    //                 [tableView addSubview:cleanBtn];
    
    [_tableView reloadData];
    [self showBgView:YES];
    UIButton *btn = _toolView.views[2];
    btn.selected=YES;
    _toolView.tag=2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil)
    {cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];}
    BasicData * data=_data[indexPath.row];
    cell.textLabel.text=data.NAME;
    if (data.isSelect) {
        cell.textLabel.textColor=LPUIMainColor;
    }
    else
    {
        cell.textLabel.textColor=[UIColor blackColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BasicData *data=_data[indexPath.row];
    UIButton *btn = _toolView.views[2];
    for (BasicData *data in _data) {
        data.isSelect=NO;
    }
    if(data.ZD_ID==nil)
    {
        [self.params removeObjectForKey:@"UPDATETONOW"];
        btn.selected=NO;
    }
    else
    {
        data.isSelect=YES;
        self.params[@"UPDATETONOW"]=data.ZD_ID;
        btn.selected=YES;
        [btn setTitle:data.NAME forState:UIControlStateSelected];
        [_tableView reloadData];
    }
    _completeBlock();
    [self showBgView:NO];
}
- (void)GetMoreFilter
{
    EntMoreFilterController * moreFilterController=[[EntMoreFilterController alloc]initWithParams:self.params  CompleteBlock:^{
        _completeBlock();
        [self showBgView:NO];
        if (![self checkMoreFilter]) {
            UIButton *btn = _toolView.views[3];
            btn.selected=NO;
        }
    }];
    [self removeBGChildView];
    [_bgView addSubview:moreFilterController.view];
    _moreFilterController=moreFilterController;
    moreFilterController.view.frame=CGRectMake(0, 0, _bgView.frame.size.width, _bgView.frame.size.height);
    // [moreFilterController setViewFrame];
    [self showBgView:YES];
    UIButton *btn = _toolView.views[3];
    btn.selected=YES;
    _toolView.tag=3;
    
}
-(void)removeBGChildView
{
    _areaController=nil;
    _industryController=nil;
    _moreFilterController=nil;
    _tableView=nil;
    for (UIView * view in _bgView.subviews)
    {
        [view  removeFromSuperview];
    }
}
-(void)closeAction
{
    // [self removeBGChildView];
    [self showBgView:NO];
}
@end
