//
//  LPHYXZViewController.m
//  LePin
//
//  Created by lwq   LI SAR on 16/12/7.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPHYXZViewController.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "Global.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "categoryData.h"
#import "IndustryNatureData.h"
#import "LPHYCollectionViewCell.h"
#import "LPSeleIndurCollectionViewCell.h"
#define hangyeFont [UIFont systemFontOfSize:13]
#define serverW [UIScreen mainScreen].bounds.size.width
#define collectionBGColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]
#define collectionLayColor [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]
#define collectionLabelColor [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0]
@interface LPHYXZViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    BOOL firstSeleBool;
}
@property (strong, nonatomic) NSArray * data;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionView *seleCollectionView;
@property (nonatomic, strong) NSMutableArray *industryArr;
@property (nonatomic, strong) NSMutableArray *industryIdArr;
@property (nonatomic, strong) UIView *seleView;
@property (strong, nonatomic) categoryData * selectData;
@property (nonatomic,assign) BOOL deleAll;
@property (nonatomic, strong) NSMutableArray *ArrTap;
@property (nonatomic, strong) NSMutableArray *seleInduArr;
@property (nonatomic, strong) LPHYCollectionViewCell *industryCell;
@end

@implementation LPHYXZViewController

- (NSMutableArray *)seleInduArr
{
    if (!_seleInduArr) {
        _seleInduArr = [NSMutableArray array];
    }
    return _seleInduArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIView *myHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    myHeadView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:myHeadView];
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    backBut.frame = CGRectMake(5, 20, 51, 44);
    [backBut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [myHeadView addSubview:backBut];
    
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width -100)/2, 22, 100, 44)];
    labelTitle.text = @"选择行业";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [myHeadView addSubview:labelTitle];
    
    
    
    self.industryArr = [NSMutableArray array];
    self.industryIdArr = [NSMutableArray array];
      self.ArrTap = [NSMutableArray array];
    _selectData=[[categoryData alloc]init];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = @"选择行业";
    [self.view addSubview:self.collevtionView];
    
    [self createBut];
    [self creadSeleIndustry];
    [self GetIndustryNatures];
  
}

- (void)creadSeleIndustry
{
    _seleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, serverW, 75)];
    [self.view addSubview:_seleView];
    
    UILabel *showLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 20)];
    [_seleView addSubview:showLabel];
    
    showLabel.text = @"已选行业:";
    showLabel.textColor = [UIColor greenColor];
    showLabel.font = hangyeFont;
    _seleView.backgroundColor = [UIColor whiteColor];
    
    UILabel * note = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, 220, 20)];
    note.text = @"最多只能选择3个行业";
    note.textColor = [UIColor orangeColor];
    note.font = hangyeFont;
    
    [_seleView addSubview:note];
    
    
    [self seleBut];
    
    
}


- (void)seleBut
{
    
    
    if (!firstSeleBool) {
        
        if (_URPOSE_INDUSTRY_NAME1.length>1) {
            [self.seleInduArr addObject:_URPOSE_INDUSTRY_NAME1];
        }
        if (_URPOSE_INDUSTRY_NAME2.length>1) {
            [self.seleInduArr addObject:_URPOSE_INDUSTRY_NAME2];
        }
        if (_URPOSE_INDUSTRY_NAME3.length>1) {
            [self.seleInduArr addObject:_URPOSE_INDUSTRY_NAME3];
        }
        
    }else{
        self.seleInduArr = _industryArr;
    }
    
    [_seleView addSubview:self.seleCollectionView];
    
    
}


- (void)back{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)createBut
{
    for (int i = 0; i < 2; i++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.tag = i+1;
        switch (i+1) {
            case 1:
                [but setTitle:@"确定" forState:UIControlStateNormal];
                break;
//            case 2:
//                [but setTitle:@"清空" forState:UIControlStateNormal];
//                break;
            case 2:
                [but setTitle:@"取消" forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
        [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        but.frame = CGRectMake(5+(self.view.frame.size.width)/4*(i+1), CGRectGetMaxY(_collectionView.frame)+3, (self.view.frame.size.width-40)/4, 25);
        but.titleLabel.font = hangyeFont;
        but.layer.borderWidth = 1;
        but.layer.borderColor = [[UIColor orangeColor]CGColor];
        but.layer.cornerRadius = 5;
        but.layer.masksToBounds = YES;
        [but addTarget:self action:@selector(but:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:but];
    }
    
    UIImage *lineImage = [self imageWithSize:CGSizeMake(serverW, 1) borderColor:[UIColor orangeColor] borderWidth:1];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_collectionView.frame), serverW-10, 1)];
    imageView.image = lineImage;
    [self.view addSubview:imageView];

}

- (UIImage *)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [[UIColor clearColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGFloat lengths[] = { 3, 1 };
    CGContextSetLineDash(context, 0, lengths, 1);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, size.width, 0.0);
    CGContextAddLineToPoint(context, size.width, size.height);
    CGContextAddLineToPoint(context, 0, size.height);
    CGContextAddLineToPoint(context, 0.0, 0.0);
    CGContextStrokePath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UICollectionView *)seleCollectionView
{
    if (!_seleCollectionView) {
        UICollectionViewFlowLayout *flowLayot = [[UICollectionViewFlowLayout alloc] init];
        flowLayot.scrollDirection = UICollectionViewScrollDirectionVertical;
        _seleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 , 20, serverW, 38) collectionViewLayout:flowLayot];
        _seleCollectionView.backgroundColor = [UIColor whiteColor];
        _seleCollectionView.delegate = self;
        _seleCollectionView.dataSource = self;
        _seleCollectionView.allowsMultipleSelection = YES;//默认为NO,是否可以多选
        //        [_collevtionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:@"idcard"];
        [_seleCollectionView registerNib:[UINib nibWithNibName:@"LPSeleIndurCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LPSeleIndurCollectionViewCell"];
        
    }
    return _seleCollectionView;
}

- (UICollectionView *)collevtionView {
    if (!_collectionView) {
        CGFloat width=self.view.frame.size.width;
        UICollectionViewFlowLayout *flowLayot = [[UICollectionViewFlowLayout alloc] init];
        flowLayot.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 , 64+75, width, self.view.frame.size.height-30-75-64) collectionViewLayout:flowLayot];
        _collectionView.backgroundColor = collectionBGColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = YES;//默认为NO,是否可以多选
        //        [_collevtionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:@"idcard"];
        [_collectionView registerNib:[UINib nibWithNibName:@"LPHYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"idcard"];
        
    }
    return _collectionView;
}

-(void)GetIndustryNatures
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"INDUSTRYCATEGORY_ID"] = @"";
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_INDUSTRYNATURELISTBYICID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getIndustrynatureList.do?"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * industrycategorylist =[json objectForKey:@"industrynatureList"];
         if(1==[result intValue])
         {

             [Global showNoDataImage:self.view withResultsArray:industrycategorylist];
             _data = [IndustryNatureData dataWithJson:industrycategorylist];
             [_collectionView reloadData];
            
             
         }
         [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
         
     } failure:^(NSError *error)
     {
          [MBProgressHUD showError:@"网络连接失败"];
     }];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_seleCollectionView == collectionView) {
        if (!firstSeleBool) {
            return _seleInduArr.count;
        }else{
            return _industryArr.count;
        }
        
    }
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_seleCollectionView == collectionView) {
        LPSeleIndurCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPSeleIndurCollectionViewCell" forIndexPath:indexPath];
        cell.but.tag = indexPath.row+1;
        [cell.but addTarget:self action:@selector(seleButt:) forControlEvents:UIControlEventTouchUpInside];
        if (!firstSeleBool) {
            cell.label.text = _seleInduArr[indexPath.row];
            
            
        }else{
            cell.label.text = _industryArr[indexPath.row];
        }
        cell.label.backgroundColor = [UIColor greenColor];
        cell.label.font = hangyeFont;
        cell.label.textColor = collectionLabelColor;
        return cell;
    }
    else{
        _industryCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"idcard" forIndexPath:indexPath];
        IndustryNatureData * data= _data[indexPath.row];
        _industryCell.labelTitle.text = data.IndustryNatureName;
        _industryCell.labelTitle.font = hangyeFont;
        _industryCell.labelTitle.textColor = collectionLabelColor;
        if (_industryArr.count < 3) {
            UIView* selectedBGView = [[UIView alloc] initWithFrame:_industryCell.bounds];
            selectedBGView.backgroundColor = [UIColor greenColor];
            _industryCell.selectedBackgroundView = selectedBGView;
        }
        
        _industryCell.imageView .tag = indexPath.row + 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        _industryCell.imageView.userInteractionEnabled = YES;
        [_industryCell.imageView addGestureRecognizer:tap];
        _industryCell.imageView.backgroundColor = [UIColor whiteColor];
        //    LPUIBgColor;
        
        
        if (!_deleAll) {
            if ([_URPOSE_INDUSTRY_NAME1 isEqualToString:data.IndustryNatureName] || [_URPOSE_INDUSTRY_NAME2 isEqualToString:data.IndustryNatureName]  || [_URPOSE_INDUSTRY_NAME3 isEqualToString:data.IndustryNatureName] ) {
                if (!firstSeleBool) {
                    [_industryArr addObject:data.IndustryNatureName];
                    [_industryIdArr addObject:data.IndustryNatureID];
                }
                
                
                
                [_ArrTap addObject:[NSString stringWithFormat:@"%d",indexPath.row+1]];
                _industryCell.imageView.backgroundColor = [UIColor greenColor];
                //            _industryCell.labelTitle.textColor = [UIColor whiteColor];
            }
        }
        
        
        return _industryCell;}
}

- (void)tap:(UITapGestureRecognizer *)tapp
{
    
    if (!firstSeleBool) {
        firstSeleBool = !firstSeleBool;
    }
    
    _ArrTap = [NSMutableArray array];
    [_ArrTap addObject:[NSString stringWithFormat:@"%d",tapp.view.tag]];
    for (NSString *newTap in _ArrTap) {
        if ([newTap intValue] == tapp.view.tag) {
            IndustryNatureData * data = _data[tapp.view.tag - 1];
            for (NSString * str in _industryArr) {
                if ([data.IndustryNatureName isEqualToString:str]) {
                    if ([data.IndustryNatureName isEqualToString:_URPOSE_INDUSTRY_NAME1]) {
                        _URPOSE_INDUSTRY_NAME1 = nil;
                    }
                    if ([data.IndustryNatureName isEqualToString:_URPOSE_INDUSTRY_NAME2]) {
                        _URPOSE_INDUSTRY_NAME2 = nil;
                    }
                    if ([data.IndustryNatureName isEqualToString:_URPOSE_INDUSTRY_NAME3]) {
                        _URPOSE_INDUSTRY_NAME3 = nil;
                    }
                    [_industryArr removeObject:data.IndustryNatureName];
                    [_industryIdArr removeObject:data.IndustryNatureID];
                    [_ArrTap removeObject:newTap];
                    tapp.view.backgroundColor = [UIColor whiteColor];
                    [_seleCollectionView reloadData];
                    return;
                    
                }
            }
        }
        
    }
    if (_industryArr.count >=3) {
        [MBProgressHUD showError:@"行业最多选3个"];
        return;
    }
    IndustryNatureData * data = _data[tapp.view.tag - 1];
    [_industryArr addObject:data.IndustryNatureName];
    [_industryIdArr addObject:data.IndustryNatureID];
    if (_industryArr.count == 1) {
        _URPOSE_INDUSTRY_NAME1 = data.IndustryNatureName;
    }
    if (_industryArr.count == 2) {
        _URPOSE_INDUSTRY_NAME2 = data.IndustryNatureName;
    }
    if (_industryArr.count == 3) {
        _URPOSE_INDUSTRY_NAME3 = data.IndustryNatureName;
    }
    
    
    //    [self seleBut];
    [_seleCollectionView reloadData];
    tapp.view.backgroundColor = [UIColor greenColor];
}


//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat w = self.view.frame.size.width;
    return CGSizeMake((w-40)/4, 30);
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);//分别为上、左、下、右
}

////选择了某个cell
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    //    [cell setBackgroundColor:[UIColor greenColor]];
//    
//    
//    if (_industryArr.count >3) {
//        return;
//    }
//    IndustryNatureData * data = _data[indexPath.row];
//    NSLog(@"%d",_industryIdArr.count);
//    
//    [_industryArr addObject:data.IndustryNatureName];
//    [_industryIdArr addObject:data.IndustryNatureID];
//    
//    NSLog(@"%d",_industryIdArr.count);
//    
//}
//
////取消选择了某个cell
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    IndustryNatureData * data = _data[indexPath.row];
//    NSLog(@"%d",_industryIdArr.count);
//    
//    for (NSString * str in _industryArr) {
//        if ([data.IndustryNatureName isEqualToString:str]) {
//            [_industryArr removeObject:data.IndustryNatureName];
//            [_industryIdArr removeObject:data.IndustryNatureID];
//            NSLog(@"xiangtong=%@",data.IndustryNatureName);
//            break;
//            
//        }
//    }
//    NSLog(@"%d",_industryIdArr.count);
//}
//
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (_seleCollectionView == collectionView) {
        CGSize size={serverW,3};
        return size;
    }
    
    CGSize size={serverW,10};
    return size;
}
//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size={serverW,0.1};
    return size;
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = collectionLayColor.CGColor;
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
}



//返回这个UICollectionViewCell是否可以被选择
-( BOOL )collectionView:( UICollectionView *)collectionView shouldSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    if (_industryArr.count >= 3) {
        [MBProgressHUD showError:@"行业最多选3个"];
        return NO;
    }
    return YES ;
}


- (void)but:(UIButton *)butt
{
    switch (butt.tag) {
        case 1:
            [self queqing];
            break;
//        case 2:
//            NSLog(@"清空");
//            [self emptyData];
//            break;
        case 2:
            [self cleanAction];
            break;
        default:
            break;
    }
}

- (void)queqing
{
    for (NSNumber *strId in _industryIdArr) {
        switch (_industryIdArr.count) {
            case 1:
                _selectData.PURPOSE_INDUSTRY_ID1 = strId;
                break;
            case 2:

                if (!_selectData.PURPOSE_INDUSTRY_ID1) {
                    _selectData.PURPOSE_INDUSTRY_ID1 = strId;
                }else{
                    _selectData.PURPOSE_INDUSTRY_ID2 = strId;}
                break;
            case 3:
                if (!_selectData.PURPOSE_INDUSTRY_ID1) {
                    _selectData.PURPOSE_INDUSTRY_ID1 = strId;
                }else if(!_selectData.PURPOSE_INDUSTRY_ID2){
                    _selectData.PURPOSE_INDUSTRY_ID2 = strId;}
                else{
                    _selectData.PURPOSE_INDUSTRY_ID3 =strId;
                }
                break;
                
            default:
                break;
        }
        
    }
    for (NSString *strId in _industryArr) {
        switch (_industryArr.count) {
            case 1:
                _selectData.URPOSE_INDUSTRY_NAME1 = strId;
                break;
            case 2:
                
                if (!_selectData.URPOSE_INDUSTRY_NAME1) {
                    _selectData.URPOSE_INDUSTRY_NAME1 = strId;
                }else{
                    _selectData.URPOSE_INDUSTRY_NAME2 = strId;}
                break;
            case 3:
                if (!_selectData.URPOSE_INDUSTRY_NAME1) {
                    _selectData.URPOSE_INDUSTRY_NAME1 = strId;
                }else if(!_selectData.URPOSE_INDUSTRY_NAME2){
                    _selectData.URPOSE_INDUSTRY_NAME2 = strId;}
                else{
                    _selectData.URPOSE_INDUSTRY_NAME3 =strId;
                }
                break;
                
            default:
                break;
        }
        
    }

    _complete(_selectData);
}

- (void)emptyData
{

    [_industryArr removeAllObjects];
    [_industryIdArr removeAllObjects];
      _deleAll = YES;
    _URPOSE_INDUSTRY_NAME1 = nil;
    _URPOSE_INDUSTRY_NAME2 = nil;
    _URPOSE_INDUSTRY_NAME3 = nil;
    [_collectionView reloadData];
    
}

-(void)cleanAction
{
    _selectData.IndustryNatureID=nil;
    _complete(_selectData);
}

- (void)seleButt:(UIButton *)but
{
    
    if (!firstSeleBool) {
        firstSeleBool = !firstSeleBool;
    }
    
    NSString * str = _industryArr[but.tag - 1];
    NSString *strID ;
    
    if ([_URPOSE_INDUSTRY_NAME1 isEqualToString:str]) {
        _URPOSE_INDUSTRY_NAME1 = nil;
    }
    if ([_URPOSE_INDUSTRY_NAME2 isEqualToString:str]) {
        _URPOSE_INDUSTRY_NAME2 = nil;
    }
    if ([_URPOSE_INDUSTRY_NAME3 isEqualToString:str]) {
        _URPOSE_INDUSTRY_NAME3 = nil;
    }
    
    for (IndustryNatureData * data in _data) {
        if ([data.IndustryNatureName isEqualToString:str]) {
            strID = [NSString stringWithFormat:@"%@",data.IndustryNatureID];
        }
    }
    
    for (NSString * str1 in _industryArr)
    {
        if ([str1 isEqualToString:str]) {
            [_industryArr removeObject:str1];
            break;
        }
    }
    for (NSString *str2 in _industryIdArr) {
        if ([strID isEqualToString:[NSString stringWithFormat:@"%@",str2]]) {
            [_industryIdArr removeObject:str2];
            [_collectionView reloadData];
            [_seleCollectionView reloadData];
            break;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
