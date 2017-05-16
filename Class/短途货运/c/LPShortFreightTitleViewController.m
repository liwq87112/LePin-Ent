//
//  LPShortFreightTitleViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/12.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPShortFreightTitleViewController.h"
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
#import "FindFactoryMoreFilterController.h"
typedef void (^CompleteBlock)();
@interface LPShortFreightTitleViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _data[3];
}
@property (weak, nonatomic)  LPFilterToolView * toolView;
@property (strong, nonatomic)  SelectAreaViewController * areaController;
@property (strong, nonatomic)  SelectIndustryController * industryController;
@property (strong, nonatomic)  FindFactoryMoreFilterController * moreFilterController;
@property (strong, nonatomic) AreaData *SelectAreaData;
@property (copy, nonatomic) CompleteBlock completeBlock;
@property (weak, nonatomic)  UIControl * bgView;
@property (strong, nonatomic)NSMutableDictionary * params;
@property (assign, nonatomic)NSInteger selectNum;
@property (strong, nonatomic) categoryData *selectData;
@property (weak, nonatomic) UITableView *tableView;
@end

@implementation LPShortFreightTitleViewController

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



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIControl *bgView=[UIControl new];
    bgView.backgroundColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.5];
    bgView.tag=0;
    [self.view addSubview:bgView];
    CGFloat x=self.view.frame.size.height-44-64;
    bgView.frame=CGRectMake(0,44-x, self.view.frame.size.width, x);
    [bgView addTarget:self  action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    _bgView=bgView;
    
    LPFilterToolView * toolView=[[LPFilterToolView alloc]initWithTitleArray:@[@"地区",@"车型",@"车长",@"尾板"]];
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
    _data[0]=nil;
    _data[1]=nil;
    _data[2]=nil;
    
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
            [self selectPlantType];
            break;
        case 2:
            [self selectPlantAcreage];
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
            if ([self.params objectForKey:@"car_type"]==nil) {
                UIButton * beforeBtn=_toolView.views[1];
                beforeBtn.selected=NO;
            }
            break;
        case 2:
            if ([self.params objectForKey:@"length"]==nil) {
                UIButton * beforeBtn=_toolView.views[2];
                beforeBtn.selected=NO;
            }
            break;
        case 3:
            if ([self.params objectForKey:@"has_pygidium"]==nil) {
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
        weakSelf.params[@"ADDRESS_TYPE"] =weakSelf.SelectAreaData.AreaType;
        switch (a) {
            case 1:
                weakSelf.params[@"ADDRESS_ID"]=weakSelf.SelectAreaData.PROVINCE_ID;
                [btn setTitle:weakSelf.SelectAreaData.PROVINCE_NAME forState:UIControlStateNormal];
                break;
            case 2:
                weakSelf.params[@"ADDRESS_ID"]=weakSelf.SelectAreaData.CITY_ID;
                [btn setTitle:weakSelf.SelectAreaData.CITY_NAME forState:UIControlStateNormal];
                break;
            case 3:
                weakSelf.params[@"ADDRESS_ID"]=weakSelf.SelectAreaData.County_ID;
                [btn setTitle:weakSelf.SelectAreaData.County_NAME forState:UIControlStateNormal];
                break;
            case 4:
                weakSelf.params[@"ADDRESS_ID"]=weakSelf.SelectAreaData.TOWN_ID;
                [btn setTitle:weakSelf.SelectAreaData.TOWN_NAME forState:UIControlStateNormal];
                break;
            case 5:
                weakSelf.params[@"ADDRESS_ID"]=weakSelf.SelectAreaData.VILLAGE_ID;
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

-(void)selectPlantType
{
    UIButton *btn = _toolView.views[1];
    if (_tableView==nil ||_tableView.tag==2) {
        if (_data[0]==nil) {
            [self GetPlantType];
        }
        else{
            [self CreateTableView:1];
        }
        
    }
    //    else if(_tableView.tag==2)
    //    {
    //       [self GetPlantType];
    //    }
    else
    {
        [self showBgView:NO];
        if ([self.params objectForKey:@"car_type"]==nil) {
            btn.selected=NO;
        }
    }
}

#pragma mark ---car Length
-(void)selectPlantAcreage
{
    UIButton *btn = _toolView.views[2];

    if (_tableView==nil || _tableView.tag==1) {
        
        if (_data[1]==nil) {
            [self GetPlantAcreage ];
        }
        else{
            [self CreateTableView:2];
        }
        //[self GetPlantAcreage ];
        
    }
    //    else if(_tableView.tag==1)
    //    {
    //        [self GetPlantAcreage ];
    //    }
    else
    {
        [self showBgView:NO];
        if ([self.params objectForKey:@"length"]==nil) {
            btn.selected=NO;
        }
    }
}
-(void)selectMoreFilter
{
    UIButton *btn = _toolView.views[3];

    if (_tableView==nil || _tableView.tag==4) {

        if (_data[2]==nil) {
            [self GetMoreFilter];
        }
        else{
//            [self showBgView:NO];
//            _data[2] = nil;
//            if ([self.params objectForKey:@"has_p"]==nil) {
//                btn.selected=NO;
//            }
            [self CreateTableView:3];
        }
    }
    else
        {
            [self showBgView:NO];
            
            if ([self.params objectForKey:@"has_p"]==nil) {
                btn.selected=NO;
                _data[2] = nil;
            }
        }
    

}
-(BOOL)checkMoreFilter
{
    BOOL  x=0;
    NSArray * listName=@[@"property",@"new_old",@"factory_architecture",@"dining_room",@"unit_price",@"power_distribution",@"blank_acreage"];
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

#pragma mark  ----car type
- (void)GetPlantType
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BIANMA"] = @"car_type";
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
                 _data[0]=array;
                 [self CreateTableView:1];
             }
         }
     } failure:^(NSError *error) {}];
}
- (void)GetPlantAcreage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BIANMA"] = @"car_length";
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
                 for (NSDictionary *dict in list)
                 {
                     BasicData * data = [BasicData BasicWithlist:dict];
                     // if ([data.NAME isEqualToString:@"不限"]){continue;}
                     [array addObject: data];
                 }
                 _data[1]=array;
                 [self CreateTableView:2];
             }
         }
     } failure:^(NSError *error) {}];
}

-(void)CreateTableView:(NSInteger)type
{
    UITableView * tableView=[UITableView new];
    tableView.dataSource=self;
    tableView.delegate=self;
    CGFloat w=_bgView.frame.size.width/2;
    if (type==1) {
        tableView.frame=CGRectMake(w/2, 0, w, _bgView.frame.size.height-60);
    }
    if (type==2)
    {
        tableView.frame=CGRectMake(w, 0, w, _bgView.frame.size.height-60);
    }
    if (type==3){
      tableView.frame=CGRectMake(w+w/2, 0, w, _bgView.frame.size.height-60);
    }
    //tableView.frame=CGRectMake(w, 0, w, _bgView.frame.size.height-60);
    //tableView.contentInset=UIEdgeInsetsMake(44, 0, 0, 0);
    tableView.tag=type;
    [self removeBGChildView];
    [_bgView addSubview:tableView];
    _tableView=tableView;

    [_tableView reloadData];
    [self showBgView:YES];
    UIButton *btn = _toolView.views[type];
    btn.selected=YES;
    _toolView.tag=type;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (_data[2].count ==2) {
        return 3;
    }
    else{
        return _data[tableView.tag-1].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil)
    {cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];}
    if (_data[2].count == 2) {
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"不限";
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"有尾板";
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"没尾板";
        }
        
        return cell;
    }
    else
    {
    BasicData * data=_data[tableView.tag-1][indexPath.row];
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
}

//这里参数 传过去 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UIButton *btn = _toolView.views[tableView.tag];

    if (_data[2].count == 2)
    {

        _data[2] = nil;
        btn.selected=YES;
        if (indexPath.row == 0) {
             [btn setTitle:@"不限" forState:UIControlStateSelected];
            [self.params removeObjectForKey:@"has_pygidium"];
            btn.selected=NO;
        }
        if (indexPath.row == 1) {
            [btn setTitle:@"有尾板" forState:UIControlStateSelected];
            self.params[@"has_pygidium"] = @1;
        }
        if (indexPath.row == 2) {
            [btn setTitle:@"没尾板" forState:UIControlStateSelected];
            self.params[@"has_pygidium"] = @2;
        }
        [_tableView reloadData];
        
        _tableView = nil;
    }
    else
    {
         BasicData *data=_data[tableView.tag-1][indexPath.row];
    for (BasicData *data in _data[tableView.tag-1]) {
        data.isSelect=NO;
    }
    if(data.ZD_ID==nil)
    {
        if (tableView.tag==1)
        {
            [self.params removeObjectForKey:@"car_type"];
        }
        if (tableView.tag==2)
        {
            [self.params removeObjectForKey:@"length"];
        }
        else{
//            [self.params removeObjectForKey:@"has_pygidium"];
        }
        btn.selected=NO;
    }
    else
    {
        data.isSelect=YES;
        
        if (tableView.tag==1)
        {
            self.params[@"car_type"]=data.ZD_ID;
        }
        if (tableView.tag==2)
        {
            self.params[@"length"]=data.ZD_ID;
        }
        else{
//         self.params[@"has_pygidium"]=data.ZD_ID;
        }
        btn.selected=YES;
        [btn setTitle:data.NAME forState:UIControlStateSelected];
        [_tableView reloadData];
    }
    }
    _completeBlock();
    [self showBgView:NO];
}

#pragma  mark --是否带尾板
- (void)GetMoreFilter
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
//    has_pygidium
     params[@"BIANMA"] = @"has_pygidium";
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBaseDataByCode.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
//             NSMutableArray * totalArray=[NSMutableArray array];
//             NSArray * listTitle=@[@"属性",@"新旧程度",@"厂房结构",@"食堂",@"租金",@"配电量",@"厂区空地面积"];
//             NSArray * listName=@[@"plant_property",@"plant_newold",@"plant_architecture",@"plant_dining_room",@"plant_price",@"plant_power",@"plant_blank_acreage"];
//             for (NSString * name in listName)
//             {
//                 NSArray * dataList =[json objectForKey:name];
//                 NSMutableArray *array=[NSMutableArray array];
//                 for (NSDictionary *dict in dataList)
//                 {
//                     BasicData *data = [BasicData BasicWithlist:dict];
//                     [data calculateTitleW];
//                     [array addObject:data ];
//                 }
//                 [totalArray addObject:array];
//             }
//                          listName=@[@"UPDATETONOW",@"SEX",@"COMPANY_SIZE",@"ENTNATURE",@"EDU",@"AGE",@"MONTHLYPAY"];
//             NSArray *arraydata=@[listTitle,listName,totalArray];
//             FindFactoryMoreFilterController * moreFilterController=[[FindFactoryMoreFilterController alloc]initWithParams:self.params array:arraydata CompleteBlock:^{
//                 _completeBlock();
//                 [self showBgView:NO];
//                 if (![self checkMoreFilter]) {
//                     UIButton *btn = _toolView.views[3];
//                     btn.selected=NO;
//                 }
//             } CloseBlock:^{
//                 [self showBgView:NO];
//                 if (![self checkMoreFilter]) {
//                     UIButton *btn = _toolView.views[3];
//                     btn.selected=NO;
//                 }
//             } ];
//             [self removeBGChildView];
//             [_bgView addSubview:moreFilterController.view];
//             _moreFilterController=moreFilterController;
//             moreFilterController.view.frame=CGRectMake(0, 0, _bgView.frame.size.width, _bgView.frame.size.height);
//             [moreFilterController setViewFrame];
//             [self showBgView:YES];
//             UIButton *btn = _toolView.views[3];
//             btn.selected=YES;
//             _toolView.tag=3;
             
//             NSArray * list =[json objectForKey:@"baseDataList"];
//             if (list.count>0) {
//                 NSMutableArray *array=[NSMutableArray array];
//                 BasicData * data = [[BasicData alloc]init];
//                 data.NAME=@"不限";
//                 [array addObject: data];
//                 for (NSDictionary *dict in list) {
//                     BasicData * data = [BasicData BasicWithlist:dict];
//                     // if ([data.NAME isEqualToString:@"不限"]){continue;}
//                     [array addObject: data];
//                 }
//                 _data[0]=array;
//                 [self CreateTableView:1];
//             }
             NSMutableArray * list = [[NSMutableArray alloc]initWithArray:[json objectForKey:@"baseDataList"]];
//            NSMutableArray *listArray=[NSMutableArray array];
//             NSMutableArray *listArray2=[NSMutableArray array];
             if (list.count == 0) {
                 NSMutableArray *array=[NSMutableArray array];
                 BasicData * data = [[BasicData alloc]init];
                 data.NAME=@"不限";
                  [array addObject: data];
                 data.NAME=@"不限";
                 [array addObject: data];
//                 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                 dic[@"NAME"] = @"带尾板";
//                 dic[@"ZD_ID"] = @"1111";
//                 [list addObject:dic];
////                 ZD_ID
////                 [listArray2 addObject:dic];
////                 [listArray addObject:listArray2];
//                 dic[@"NAME"] = @"不带尾板";
//                 dic[@"ZD_ID"] = @"2222";
//                 [list addObject:dic];
//                 [listArray addObject:list];
                 
//                 for (NSDictionary *dict in list)
//                 {
//                     NSLog(@"%@",dict);
//                     
////                     
//                     BasicData * data = [BasicData BasicWithlist:dict];
////                     // if ([data.NAME isEqualToString:@"不限"]){continue;}
//                     [array addObject: data];
//                 }
                 _data[2]=array;
                 [self CreateTableView:3];
             }
            

         }
     } failure:^(NSError *error) {}];
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
