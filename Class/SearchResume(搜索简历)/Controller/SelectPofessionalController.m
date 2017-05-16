//
//  SelectPofessionalController.m
//  LePin-Ent
//
//  Created by apple on 15/11/28.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "SelectPofessionalController.h"
#import "AreaCollectionViewCell.h"
#import "PofessionalCategoryData.h"
#import "PofessionalNameData.h"
#import "NSString+Hash.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "Global.h"
#import "SelectPofessionalData.h"
#import "SelectPofessionalCell.h"
typedef void (^block)(NSString * categoryIDS,NSString * categoryNAMES,NSString * ProfessionalIDS,NSString * ProfessionalNAMES);
@interface SelectPofessionalController ()<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate>
@property (nonatomic, strong) NSArray * data;

@property (nonatomic, strong) NSArray *sourceData;
@property (weak, nonatomic) UICollectionView * collectionView;
@property (weak, nonatomic) UISearchBar *searchBar;
//@property (weak, nonatomic) UIView *searchBarBgView;
@property (assign, nonatomic) BOOL model;
@property (copy, nonatomic) NSString * PROCATEGORY_ID;
@property (assign, nonatomic)NSInteger wide;
@property (nonatomic, copy) block CompleteBlock;
@property (nonatomic, assign) BOOL isCreateSelectAllBtn;
@property (weak, nonatomic) UIView * toolView;
@property (weak, nonatomic) UIButton * toolBtn1;
@property (weak, nonatomic) UIButton * toolBtn2;
@property (weak, nonatomic) UIButton * toolBtn3;
@property (weak, nonatomic) UIView * toolLine1;
@property (weak, nonatomic) UIView * toolLine2;
//@property (nonatomic, strong) UIBarButtonItem * allSelectBtn;
//@property (nonatomic, strong) UIBarButtonItem * allCancelBtn;
@end

@implementation SelectPofessionalController

static NSString * const reuseIdentifier = @"Area";
static NSString * const PofessionalIdentifier = @"SelectPofessionalCell";

//-(instancetype)init
//{
//    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
//    return [super initWithCollectionViewLayout:layout];
//}
//-(UICollectionView *)collectionView
//{
//    if (_collectionView==nil) {
//        UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
//        collectionView.contentInset=UIEdgeInsetsMake(44, 0, 0, 0);
//        collectionView.dataSource=self;
//        collectionView.delegate=self;
//        _collectionView=collectionView;
//        [self.view addSubview:collectionView];
//    }
//    return _collectionView;
//}
//-(UISearchBar *)searchBar
//{
//    if (_searchBar==nil) {
//        UISearchBar *searchBar=[[ UISearchBar alloc]init];
//        _searchBar=searchBar;
//        searchBar.placeholder=@"请输入关键字";
//        searchBar.barStyle=UIBarStyleDefault;
//        searchBar.searchBarStyle=UISearchBarStyleMinimal;
//        searchBar.delegate=self;
//        //searchBar.backgroundColor=[UIColor redColor];
//        self.navigationItem.titleView=searchBar;
//        //[self.view addSubview:searchBar];
//    }
//    return _searchBar;
//}
//-(void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    
//    if (_state) {
//        CGRect  rect=self.view.bounds;
//        self.collectionView.frame=rect;
//        //CGRect searchBar =CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame), rect.size.width, 44);
//       // self.searchBar.frame=searchBar;
//        CGRect tipBtn=searchBar;
//        tipBtn.origin.y=tipBtn.origin.y-tipBtn.size.height;
//        _state=0;
//    }
//}
-(UIView *)toolView
{
    if (_toolView==nil) {
        UIView * toolView =[UIView new];
        toolView.backgroundColor =[UIColor whiteColor];
        _toolView=toolView;
        [self.view addSubview:toolView];
        
        UIButton *toolBtn1=[UIButton buttonWithType:UIButtonTypeSystem];
        [toolBtn1 setTitle:@"全选" forState:UIControlStateNormal];
        [toolBtn1 addTarget:self action:@selector(allSelect) forControlEvents:UIControlEventTouchUpInside];
        [toolBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _toolBtn1=toolBtn1;
        [toolView addSubview:toolBtn1];
        
        UIButton *toolBtn2=[UIButton buttonWithType:UIButtonTypeSystem];
        [toolBtn2 setTitle:@"取消" forState:UIControlStateNormal];
        [toolBtn2 addTarget:self action:@selector(allCancel) forControlEvents:UIControlEventTouchUpInside];
        [toolBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _toolBtn2=toolBtn2;
        [toolView addSubview:toolBtn2];
        
        UIButton *toolBtn3=[UIButton buttonWithType:UIButtonTypeSystem];
        [toolBtn3 setTitle:@"确定" forState:UIControlStateNormal];
        [toolBtn3 addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
        [toolBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _toolBtn3=toolBtn3;
        [toolView addSubview:toolBtn3];
        
        UIView * toolLine1=[UIView new];
        toolLine1.backgroundColor=[UIColor lightGrayColor];
        _toolLine1=toolLine1;
        [toolView addSubview:toolLine1];
        
        UIView * toolLine2=[UIView new];
        toolLine2.backgroundColor=[UIColor lightGrayColor];
        _toolLine2=toolLine2;
        [toolView addSubview:toolLine2];
        
    }
    return _toolView;
}
-(instancetype)initWithBlock:CompleteBlock
{
    self=[super init];
    if (self) {
        _CompleteBlock=CompleteBlock;
        _model=0;
    }
    return self;
}
-(instancetype)initWithID:(NSString *)ID Block:CompleteBlock
{
    self=[super init];
    if (self) {
        _CompleteBlock=CompleteBlock;
        _model=0;
    }
    return self;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length==0)
    {
        if (_model) {
             //self.isCreateSelectAllBtn=YES;
            [self GetProfessionalData];
        }
        else
        {
            [self GetProcategoryData];
        }
        return;
    }
    _model=1;
    [self GetProfessionalDataWithKeyWord:searchText];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationItem.titleView endEditing:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.navigationItem.titleView endEditing:YES];
}
//-(BOOL)isCreateSelectAllBtn
//{
//    if (_isCreateSelectAllBtn==0) {
//        [self  createSelectAllBtn];
//        //self.navigationItem.rightBarButtonItems =@[okBtn,allSelectBtn,empty,allCancelBtn];
//        _isCreateSelectAllBtn=1;
//    }
//    return _isCreateSelectAllBtn;
//}
//-(void)setIsCreateSelectAllBtn:(BOOL)isCreateSelectAllBtn
//{
//    if (isCreateSelectAllBtn)
//    {
//        [self  createSelectAllBtn];
//    }
//    else
//    {
//        self.navigationItem.rightBarButtonItems =nil;
//    }
//    _isCreateSelectAllBtn=isCreateSelectAllBtn;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect=[UIScreen mainScreen].bounds;
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame: rect collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    collectionView.contentInset=UIEdgeInsetsMake(44, 0, 0, 0);
    collectionView.dataSource=self;
    collectionView.delegate=self;
    _collectionView=collectionView;
    [self.view addSubview:collectionView];
    
    self.navigationItem.title=@"选择专业";
//    UIView * searchBarBgView=[[UIView alloc]init];
//    searchBarBgView.backgroundColor=[UIColor whiteColor];
//    _searchBarBgView=searchBarBgView;
//    self.navigationItem.titleView=searchBarBgView;
    
    UISearchBar *searchBar=[[ UISearchBar alloc]init];
    _searchBar=searchBar;
    searchBar.placeholder=@"请输入专业关键字";
    searchBar.barStyle=UIBarStyleDefault;
    searchBar.searchBarStyle=UISearchBarStyleDefault;
    searchBar.delegate=self;
    searchBar.frame=CGRectMake(0, 64, rect.size.width, 44);
    //searchBar.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:searchBar];
    

    //self.navigationItem.titleView=searchBar;
    
//   UIBarButtonItem * okBtn= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector (ok)];
//
////    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector (ok)];
//   // self.navigationItem.title=@"请选择专业名称";
//    UIBarButtonItem * allSelectBtn = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector (allSelect)];
//    UIBarButtonItem * empty= [[UIBarButtonItem alloc] init];
//    UIBarButtonItem * allCancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector (allCancel)];
//    self.navigationItem.rightBarButtonItems =@[okBtn,allSelectBtn,empty,allCancelBtn];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.collectionView registerClass:[AreaCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[SelectPofessionalCell class] forCellWithReuseIdentifier:PofessionalIdentifier];
    [self GetProcategoryData];
}
-(void)allCancel
{
    if (_data==nil) {return;}
    for ( SelectPofessionalData *data in _data ) {data.isSelect=NO;}
    [self.collectionView reloadData];
}
-(void)allSelect
{
    if (_data==nil) {return;}
    for ( SelectPofessionalData *data in _data ) {data.isSelect=YES;}
    [self.collectionView reloadData];
}
//- (NSArray *)data
//{
//    if (_data==nil)
//    {
//        [self Getdata];
//    }
//    return _data;
//}
//-(void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//
//}
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    CGRect rect=_searchBarBgView.bounds;
//    _searchBar.frame=rect;
//}


-(void)ok
{
    NSString * categoryIDS=nil;
    NSString * categoryNAMES=nil;
    NSString * ProfessionalIDS=nil;
    NSString * ProfessionalNAMES=nil;
    NSMutableArray *array=[[NSMutableArray alloc]init];
    if(!_model){ [MBProgressHUD showError:@"请选择专业类别或者专业名称"];return;}
    // BOOL xx
    for (SelectPofessionalData *data in _data)
    {
        if (data.isSelect)
        {
            if (categoryIDS==nil)
            {
                categoryIDS=[NSString stringWithFormat:@"%@",data.PROCATEGORY_ID];
                categoryNAMES=[NSString stringWithFormat:@"%@",data.PROCATEGORY_NAME];
                [array addObject:data.PROCATEGORY_ID];
            }
            else
            {
                if ([self testRepeat:array ID:data.PROCATEGORY_ID])
                {
                    categoryIDS=[NSString stringWithFormat:@"%@,%@",categoryIDS,data.PROCATEGORY_ID];
                    categoryNAMES=[NSString stringWithFormat:@"%@,%@",categoryNAMES,data.PROCATEGORY_NAME];
                    [array addObject:data.PROCATEGORY_ID];
                }
            }
            
            if (ProfessionalIDS==nil) {ProfessionalIDS=[NSString stringWithFormat:@"%@",data.PROFESSIONAL_ID];}
            else{ProfessionalIDS=[NSString stringWithFormat:@"%@,%@",ProfessionalIDS,data.PROFESSIONAL_ID];}
            
            if (ProfessionalNAMES==nil) {ProfessionalNAMES=[NSString stringWithFormat:@"%@",data.PROFESSIONAL_NAME];}
            else{ProfessionalNAMES=[NSString stringWithFormat:@"%@,%@",ProfessionalNAMES,data.PROFESSIONAL_NAME];}
        }
    }
    if (ProfessionalIDS==nil) {[MBProgressHUD showError:@"请至少选择一个专业名称"];return;}

//    NSRange foundObj=[categoryIDS rangeOfString:@"," options:NSCaseInsensitiveSearch];
//    if(foundObj.length<=0){ categoryIDS=nil;}
    
    _CompleteBlock(categoryIDS,categoryNAMES,ProfessionalIDS,ProfessionalNAMES);
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)testRepeat:(NSMutableArray *)array ID:(NSNumber  *)ID
{
    BOOL state=YES;
    for (NSNumber * num in array) {if([num isEqualToNumber:ID]) {state= NO;}}
    return state;
}
-(void)GetProcategoryData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PROCATEGORYLIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getProcategoryList.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * list =[json objectForKey:@"procategorylist"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:list];
             NSMutableArray * datas=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in list)
             {
                 PofessionalCategoryData * data = [PofessionalCategoryData PofessionalCategoryWithlist:dict];
                 [datas addObject: data];
             }
             _data=datas;
             [self.collectionView reloadData];
             
         }
     } failure:^(NSError *error){}];
}
-(void)createSelectAllBtn
{
    if (_model==1) {
        if (_isCreateSelectAllBtn==0)
        {
            CGRect rect=[UIScreen mainScreen].bounds;
            self.toolView.frame=CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), rect.size.width, 50);
            CGFloat width=rect.size.width/3;
            _toolBtn1.frame=CGRectMake(0, 0, width, 50);
            _toolBtn2.frame=CGRectMake(width, 0, width, 50);
            _toolBtn3.frame=CGRectMake(2*width, 0, width, 50);
            _toolLine1.frame=CGRectMake(width, 5, 2, 40);
            _toolLine2.frame=CGRectMake(2*width, 5, 2, 40);
            _searchBar.frame=CGRectMake(0, 64+50, rect.size.width, 44);
            _collectionView.frame=CGRectMake(0, 50, rect.size.width, rect.size.height-50);
            _isCreateSelectAllBtn=1;
        }
    }
   else
   {
       self.navigationItem.rightBarButtonItems =nil;
       _isCreateSelectAllBtn=0;
   }
}
-(void)GetProfessionalData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_PROCATEGORY_ID==nil) {params[@"PROCATEGORY_ID"] =@"";}else{ params[@"PROCATEGORY_ID"] =_PROCATEGORY_ID;}
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PROFESSIONALLIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getProfessionalList.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * list =[json objectForKey:@"professionallist"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:list];
             NSMutableArray * datas=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in list)
             {
                  SelectPofessionalData * data = [SelectPofessionalData CreateWithlist:dict];
                 [datas addObject: data];
             }
             _data=datas;
             _model=1;
             [self createSelectAllBtn];
             [self.collectionView reloadData];
         }
     } failure:^(NSError *error){}];
}
-(void)GetProfessionalDataWithKeyWord:(NSString *)KeyWord
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //if (_PROCATEGORY_ID==nil) {params[@"PROCATEGORY_ID"] =@"";}else{ params[@"PROCATEGORY_ID"] =_PROCATEGORY_ID;}
    params[@"PROCATEGORY_ID"] =@"";
    params[@"KEYWORD"] = KeyWord;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PROFESSIONALLIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getProfessionalList.do?"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * list =[json objectForKey:@"professionallist"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:list];
             NSMutableArray * datas=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in list)
             {
                 SelectPofessionalData * data = [SelectPofessionalData CreateWithlist:dict];
                 [datas addObject: data];
             }
             _data=datas;
            // _sourceData=datas;
             [self createSelectAllBtn];
             [self.collectionView reloadData];
         }
     } failure:^(NSError *error) {}];
}
-(NSInteger)wide
{
    if (_wide==0) {
        CGFloat width=[UIScreen mainScreen].bounds.size.width;
        if (width==414.0) {_wide=90;}else {_wide=(width-40)/3;}
    }
    return _wide;
}
#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {return self.data.count;}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    SelectPofessionalCell *PofessionalCell;
    AreaCollectionViewCell *AreaCell ;
    if (_model)
    {
        PofessionalCell =[collectionView dequeueReusableCellWithReuseIdentifier:PofessionalIdentifier forIndexPath:indexPath];
        SelectPofessionalData *data=self.data[indexPath.item];
        [PofessionalCell.showBtn setTitle:data.PROFESSIONAL_NAME forState:UIControlStateNormal];
        if (data.isSelect) {PofessionalCell.showBtn.selected=YES;}else{PofessionalCell.showBtn.selected=NO;}
        cell=PofessionalCell;
    }
    else
    {
        AreaCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        PofessionalCategoryData *data=self.data[indexPath.item];
        AreaCell .AreaID=data.PROCATEGORY_ID;
        AreaCell .AreaName.text= data.PROCATEGORY_NAME;
        cell=AreaCell;
    }
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.wide, 60);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PofessionalCategoryData *categoryData;
    SelectPofessionalData *PofessionalData;
    if (_model) {
        PofessionalData=_data[indexPath.row];
        PofessionalData.isSelect=!PofessionalData.isSelect;
        [self.collectionView reloadData];
    }else
    {
        categoryData=_data[indexPath.row];
        _PROCATEGORY_ID=(NSString *)categoryData.PROCATEGORY_ID;
        [self GetProfessionalData];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.navigationItem.titleView endEditing:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.navigationItem.titleView endEditing:YES];
}

@end
