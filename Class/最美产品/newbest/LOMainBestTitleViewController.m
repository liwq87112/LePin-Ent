//
//  LOMainBestTitleViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/13.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LOMainBestTitleViewController.h"
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
@interface LOMainBestTitleViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _data[4];
    BOOL isFronLTOH;
    BOOL isFronHTOL;
    BOOL countDataArr;
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

@implementation LOMainBestTitleViewController
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
    
    LPFilterToolView * toolView=[[LPFilterToolView alloc]initWithTitleArray:@[@"产品类别",@"价格排序"]];
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
    

    _data[0]=nil;
    _data[1]=nil;
    _data[2]=nil;
    _data[3]=nil;

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


-(void)closeFilter
{
    if (_bgView.tag) {
        [self checkInput:_toolView.tag];
        [self showBgView:NO];
    }
}
-(void)checkInput:(NSInteger)num
{
    
    //but1第一次进  都为 0  0  0再次点击为 1 。3  3    第三次为 0 3 0
    //but2第一次进  都为 0  0  0第次   点 1  1   1；         0   1
    //_toolView.tag = tableView.tag;
    switch (_toolView.tag) {
        case 0:
        {
            UIButton * beforeBtn=_toolView.views[0];
            beforeBtn.selected=NO;
        }
            break;
        case 1:
            if ([self.params objectForKey:@"PRODUCT_PRICE_ORDER"]==nil) {
                UIButton * beforeBtn=_toolView.views[1];
                beforeBtn.selected=NO;
                countDataArr = NO;
                _data[1] = nil;
            }
            break;
        case 2:
            if ([self.params objectForKey:@"acreage"]==nil) {
                UIButton * beforeBtn=_toolView.views[2];
                beforeBtn.selected=NO;
            }
            break;
        case 3:
            if ([self.params objectForKey:@"PRODUCT_TYPE"]==nil) {
                UIButton * beforeBtn=_toolView.views[0];
                beforeBtn.selected=NO;
            }
            break;
        default:
            break;
    }
}
-(void)selectArea
{
   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BIANMA"] = @"PRODUCT_TYPE";
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
                 _data[3]=array;
                 [self CreateTableView:3];
             }
         }
     } failure:^(NSError *error) {}];

}


#pragma mark  ---dddd
-(void)btnAction:(UIButton *)btn
{
    //but1第一次进  都为 0  0  0再次点击为 1 。3  3    第三次为 0 3 0
    //but2第一次进  都为 0  0  0第次   点 1  1   1；         0   1
    //_toolView.tag = tableView.tag;
    NSLog(@"_bgView.tag＝%ld",_bgView.tag);
    NSLog(@"_toolView.tag＝%ld",_toolView.tag);
    NSLog(@"_tableView.tag＝%ld", _tableView.tag);
    
    if (_bgView.tag) {
        NSLog(@"第二次点击");
        [self checkInput:_toolView.tag];
        
    }
    switch (btn.tag) {
        case 0:
            
            [self selectBestType];
            
            break;
        case 1:
            [self selectPlantType];
            

//            [self butFromLowToHigh:btn];
            break;
        case 2:
//            [self butFromHighToLow:btn];
//             [self selectPlantAcreage];
            break;
        case 3:
           // [self selectMoreFilter];
            break;
        default:
            break;
    }
}

-(void)selectCount
{
    UIButton *btn = _toolView.views[1];
    if (_tableView==nil || _tableView.tag==1) {
        
        if (_data[2]==nil) {
            [self getBool ];
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
        if ([self.params objectForKey:@"PRODUCT_PRICE_END"]==nil) {
            btn.selected=NO;
        }
    }
}


- (void)getBool
{
    [self showBgView:YES];
    countDataArr =YES;
}

#pragma mark ----FROM TO
- (void)butFromLowToHigh:(UIButton *)but
{
    UIButton *butt = [self.view viewWithTag:2];
    butt.selected=NO;
    isFronHTOL = NO;
    if (!isFronLTOH) {
        but.selected = YES;
        [self showBgView:YES];
        self.params[@"PRODUCT_PRICE_ORDER"]=@"0";
        isFronLTOH = !isFronLTOH;
    }else
    {
        but.selected = NO;
        [self showBgView:NO];
        [self.params removeObjectForKey:@"PRODUCT_PRICE_ORDER"];
        isFronLTOH = !isFronLTOH;
        
    }
    _completeBlock();
}

- (void)butFromHighToLow:(UIButton *)but
{
    UIButton *butt = [self.view viewWithTag:1];
    butt.selected=NO;
    isFronLTOH = NO;
    if (!isFronHTOL) {
        but.selected = YES;
        [self showBgView:YES];
         self.params[@"PRODUCT_PRICE_ORDER"]=@"1";
        isFronHTOL = !isFronHTOL;
    }else
    {
        but.selected = NO;
        [self showBgView:NO];
        [self.params removeObjectForKey:@"PRODUCT_PRICE_ORDER"];
        isFronHTOL = !isFronHTOL;
    }
    _completeBlock();
}

#pragma mark --- 类型
-(void)selectBestType
{
    UIButton *btn = _toolView.views[0];

    if (_tableView==nil || _tableView.tag==1) {
        
        if (_data[3]==nil) {
            [self selectArea];
        }
        else{
            [self CreateTableView:3];
        }
    }
    else
    {
        [self showBgView:NO];
        if ([self.params objectForKey:@"PRODUCT_PRICE_END"]==nil) {
            btn.selected=NO;
        }
    }
}

#pragma mark  -- 起始价格

-(void)selectPlantType
{
    UIButton *btn = _toolView.views[1];
    if (_tableView==nil ||_tableView.tag==3) {
        if (_data[1]==nil) {
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
        if ([self.params objectForKey:@"type"]==nil) {
            btn.selected=NO;
        }
    }
}

#pragma mark --- 终极价格
-(void)selectPlantAcreage
{
    UIButton *btn = _toolView.views[2];

    if (_tableView==nil || _tableView.tag==1) {
        
        if (_data[2]==nil) {
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
        if ([self.params objectForKey:@"PRODUCT_PRICE_END"]==nil) {
            btn.selected=NO;
        }
    }
}
-(void)selectMoreFilter
{
    UIButton *btn = _toolView.views[3];

    if (_tableView==nil || _tableView.tag==2) {

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

#pragma mark  ----起始价格
- (void)GetPlantType
{
    NSArray *array = @[@"不限",@"从低到高",@"从高到低 "];
    _data[1]=array;
    countDataArr = YES;
    [self CreateTableView:1];
    
}
- (void)GetPlantAcreage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BIANMA"] = @"PRODUCT_TYPE";
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
                 _data[2]=array;
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
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    CGFloat w=_bgView.frame.size.width/2;

    if (type==1) {
        tableView.frame=CGRectMake(w*2/2, 0, w*2/2, _bgView.frame.size.height-60);
    }
    if (type==2)
    {
        tableView.frame=CGRectMake(w*2/3, 0, w*2/3, _bgView.frame.size.height-60);
    }
    if (type==3)
    {
        tableView.frame=CGRectMake(0, 0, w*2/2, _bgView.frame.size.height-60);
    }
        /*
    if (type==3){
        tableView.frame=CGRectMake(w+w/2, 0, w, _bgView.frame.size.height-60);
    }
  */
    //tableView.frame=CGRectMake(w, 0, w, _bgView.frame.size.height-60);
    //tableView.contentInset=UIEdgeInsetsMake(44, 0, 0, 0);
    tableView.tag=type;
    [self removeBGChildView];
    [_bgView addSubview:tableView];
    _tableView=tableView;
    
    [_tableView reloadData];
    [self showBgView:YES];
    UIButton *btn;
    if (type == 3) {
       btn = _toolView.views[type-3];
    }
    else
    {
        btn = _toolView.views[type];
    }
    btn.selected=YES;
    _toolView.tag=type;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (countDataArr) {
        return 3;
    }
    
    if (_data[2].count ==1 ) {
        return 3;
    }
    if (_data[1].count ==1 ) {
        return 3;
    }
   // if (_tableView.tag == 0) {
  //      return _data[tableView.tag+1].count;
   // }
    else{
        return _data[tableView.tag].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil)
    {cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];}
    
    if (countDataArr) {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"不限";
                }
                if (indexPath.row == 1) {
                    cell.textLabel.text = @"从低到高";
                }
                if (indexPath.row == 2) {
                    cell.textLabel.text = @"从高到低";
                }
         return cell;
    }
   
//    if (_data[1].count == 1) {
//        
//        if (indexPath.row == 0) {
//            cell.textLabel.text = @"不限";
//        }
//        if (indexPath.row == 1) {
//            cell.textLabel.text = @"大于100¥";
//        }
//        if (indexPath.row == 2) {
//            cell.textLabel.text = @"大于500¥";
//        }
//        
//        return cell;
//    }
    else
    {
        if (_tableView.tag == 3)
        {
            BasicData * data=_data[tableView.tag][indexPath.row];
            cell.textLabel.text=data.NAME;
            
            if (data.isSelect) {
                cell.textLabel.textColor=LPUIMainColor;
            }
            else
            {
                cell.textLabel.textColor=[UIColor blackColor];
            }
            return cell;

        }else
        {
         BasicData *data=_data[tableView.tag-1][indexPath.row];
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
}

//这里参数 传过去
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIButton *btn;

    if (countDataArr) {

         btn =_toolView.views[tableView.tag];
        if (indexPath.row == 0) {
            btn.selected=NO;
//            [btn setTitle:@"不限" forState:UIControlStateSelected];
            [self.params removeObjectForKey:@"PRODUCT_PRICE_ORDER"];
        }
        if (indexPath.row == 1) {
            [btn setTitle:@"从低到高¥" forState:UIControlStateSelected];
            self.params[@"PRODUCT_PRICE_ORDER"]=@"0";
            btn.selected=YES;
        }
        if (indexPath.row == 2) {
            [btn setTitle:@"从高到低" forState:UIControlStateSelected];
//            NSString *str = @"500";
            
            self.params[@"PRODUCT_PRICE_ORDER"]=@"1" ;
            btn.selected=YES;
        }
        countDataArr = NO;
        _data[1] =nil;
        
        [_tableView reloadData];

    }
    
    
    if (tableView.tag == 3) {
        btn =_toolView.views[tableView.tag-3];
    }
//    else{btn =_toolView.views[tableView.tag];NSLog(@"%ld",_data[0].count);}
    if (tableView.tag == 3) {
        BasicData *data=_data[tableView.tag][indexPath.row];
        for (BasicData *data in _data[tableView.tag]) {
            data.isSelect=NO;
        }
        if(data.ZD_ID==nil)
        {
            if (tableView.tag == 3) {
                [self.params removeObjectForKey:@"PRODUCT_TYPE_ID"];
            }
            
//            if (tableView.tag==1)
//            {
//                [self.params removeObjectForKey:@"PRODUCT_PRICE_ORDER"];
//            }
//            if (tableView.tag==2)
//            {
//                [self.params removeObjectForKey:@"PRODUCT_PRICE_END"];
//            }
//            else{
//                [self.params removeObjectForKey:@"has_p"];
//            }
            btn.selected=NO;
        }
        else
        {
            data.isSelect=YES;
            
            if (tableView.tag == 3) {
                self.params[@"PRODUCT_TYPE_ID"]=data.ZD_ID;
            }
//            if (tableView.tag==1)
//            {
//                self.params[@"PRODUCT_PRICE_START"]=data.ZD_ID;
//            }
//            if (tableView.tag==2)
//            {
//                self.params[@"PRODUCT_PRICE_END"]=data.ZD_ID;
//            }
//            else{
//                self.params[@"has_p"]=data.ZD_ID;
//            }
            btn.selected=YES;
            [btn setTitle:data.NAME forState:UIControlStateSelected];
            [_tableView reloadData];
        }

    }
//    else{
//        BasicData *data=_data[tableView.tag-1][indexPath.row];
//        for (BasicData *data in _data[tableView.tag-1]) {
//            data.isSelect=NO;
//        }
//        if(data.ZD_ID==nil)
//        {
//            if (tableView.tag==1)
//            {
//                [self.params removeObjectForKey:@"PRODUCT_PRICE_START"];
//            }
//            if (tableView.tag==2)
//            {
//                [self.params removeObjectForKey:@"PRODUCT_PRICE_END"];
//            }
//            else{
//                [self.params removeObjectForKey:@"has_p"];
//            }
//            btn.selected=NO;
//        }
//        else
//        {
//            data.isSelect=YES;
//            
//            if (tableView.tag==1)
//            {
//                self.params[@"PRODUCT_PRICE_START"]=data.ZD_ID;
//            }
//            if (tableView.tag==2)
//            {
//                self.params[@"PRODUCT_PRICE_END"]=data.ZD_ID;
//            }
//            else{
//                self.params[@"has_p"]=data.ZD_ID;
//            }
//            btn.selected=YES;
//            [btn setTitle:data.NAME forState:UIControlStateSelected];
//            [_tableView reloadData];
//        }
//    }

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

             NSMutableArray * list = [[NSMutableArray alloc]initWithArray:[json objectForKey:@"baseDataList"]];
             //            NSMutableArray *listArray=[NSMutableArray array];
             //             NSMutableArray *listArray2=[NSMutableArray array];
             if (list.count == 0) {
                 NSMutableArray *array=[NSMutableArray array];
                 BasicData * data = [[BasicData alloc]init];
                 data.NAME=@"不限";
                 [array addObject: data];
               
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
