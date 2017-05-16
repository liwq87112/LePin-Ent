//
//  EntMoreFilterController.m
//  LePin-Ent
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntMoreFilterController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "LPInputView.h"
#import "NSString+Extension.h"
#define collectionBGColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]
#define collectionLayColor [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]
#define collectionLabelColor [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0]
typedef void (^CompleteBlock)();
@interface EntMoreFilterController ()<UIScrollViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) LPInputView * sexView;
@property (weak, nonatomic) LPInputView * ageView;
@property (weak, nonatomic) LPInputView * moneyView;
@property (weak, nonatomic) LPInputView * stdView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (weak, nonatomic) UIButton * menBtn;
@property (weak, nonatomic) UIButton * womenBtn;
@property (weak, nonatomic) UIButton * stdBtn;
@property (weak, nonatomic) UITextField * ageTextField1;
@property (weak, nonatomic) UITextField * ageTextField2;
@property (weak, nonatomic) UITextField * moneyTextField1;
@property (weak, nonatomic) UITextField * moneyTextField2;
@property (assign, nonatomic) NSInteger sex;
@property (weak, nonatomic) UIView * toolView;
@property (weak, nonatomic) UIButton * okBtn;
@property (weak, nonatomic) UIButton * cancelBtn;
@property (weak, nonatomic) UIButton *  talkBtn;
@property (strong, nonatomic) CompleteBlock  completeBlock;
@property (strong, nonatomic)NSMutableDictionary * params;
@property (nonatomic,retain) NSMutableArray *nameArray;//存储姓名的数组
@property (nonatomic,retain) NSMutableArray *iconArray;//存储表情的数组
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *formLabel;
@property (nonatomic, strong) UILabel *toLabel;
@property (nonatomic,assign)BOOL ageOrMoney;

@end

@implementation EntMoreFilterController

//创建数据源
- (void)createDataSource
{
    self.nameArray = [[NSMutableArray alloc]init];
    self.iconArray = [[NSMutableArray alloc]init];
    for (int i = 16; i < 51; i++) {
        [_nameArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i = 20; i < 51; i ++) {
        [_iconArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    [_pickerView reloadAllComponents];
}

- (void)createDataSource2
{
    self.nameArray = [[NSMutableArray alloc]init];
    self.iconArray = [[NSMutableArray alloc]init];
    for (int i = 3; i < 19; i++) {
        [_nameArray addObject:[NSString stringWithFormat:@"%d000",i]];
    }
    for (int i = 4; i < 19; i ++) {
        [_iconArray addObject:[NSString stringWithFormat:@"%d000",i]];
    }
    
    [_pickerView reloadAllComponents];
}


-(instancetype)initWithParams:(NSMutableDictionary *)params CompleteBlock:completeBlock
{
    self=[super init];
    if (self) {
        _completeBlock=completeBlock;
        _params=params;
        
    }
    return self;
}

//通过颜色来生成一个纯色图片
- (UIImage *)buttonImageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 100, 100);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    [self createDataSource];
    
    UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-44)];
    scrollView.delegate=self;
    scrollView.scrollEnabled=YES;
    [self.view addSubview: scrollView];
    scrollView.backgroundColor=[UIColor whiteColor];
    
    LPInputView *sexView=[[LPInputView alloc]init];
    _sexView=sexView;
    [scrollView addSubview:sexView];
    sexView.Title.text=@"性别:";
    [sexView.Content removeFromSuperview];
    
    UIView * view=[UIView new];
    //    [sexView addSubview:view];
    UIView *sexxView = [UIView new];
    
    
    LPInputView *stdView=[[LPInputView alloc]init];
    _stdView=stdView;
    [scrollView addSubview:stdView];
    stdView.Title.text=@"是否应届生:";
    [stdView.Content removeFromSuperview];
    
    
    UIView * nnview=[UIView new];
    //    [stdView addSubview:nnview];
    //    stdView.Content=(UITextField *)nnview;
    
    [scrollView addSubview:nnview];
    [scrollView addSubview: view];
    [scrollView addSubview:sexxView];
    
    UIImage * btnBgSelectdColor=[self buttonImageFromColor:LPUIMainColor];
    UIImage * btnBgColor=[self buttonImageFromColor:[UIColor whiteColor]];
    
    UIButton * menBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _menBtn=menBtn;
    [menBtn setTitle:@"男" forState:UIControlStateNormal];
    [menBtn setTitleColor:LPFrontMainColor forState:UIControlStateNormal];
    //[menBtn setTitleColor:LPUIMainColor forState:UIControlStateSelected];
    [menBtn setBackgroundImage:btnBgColor forState:UIControlStateNormal];
    [menBtn setBackgroundImage:btnBgSelectdColor forState:UIControlStateSelected];
    menBtn.titleLabel.font=LPContentFont;
    menBtn.layer.borderWidth = 0.1;
    menBtn.layer.backgroundColor = [[UIColor lightGrayColor]CGColor];
    menBtn.layer.cornerRadius = 5;
    menBtn.tag=1;
    [menBtn addTarget:self action:@selector(sexAction:) forControlEvents:UIControlEventTouchUpInside];
    [sexxView addSubview:menBtn];
    
    UIButton * womenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _womenBtn=womenBtn;
    [womenBtn setTitle:@"女" forState:UIControlStateNormal];
    [womenBtn setTitleColor:LPFrontMainColor forState:UIControlStateNormal];
    //[womenBtn setTitleColor:LPUIMainColor forState:UIControlStateSelected];
    [womenBtn setBackgroundImage:btnBgColor forState:UIControlStateNormal];
    [womenBtn setBackgroundImage:btnBgSelectdColor forState:UIControlStateSelected];
    womenBtn.layer.borderWidth = 0.1;
    womenBtn.layer.backgroundColor = [[UIColor lightGrayColor]CGColor];
    womenBtn.layer.cornerRadius = 5;
    womenBtn.titleLabel.font=LPContentFont;
    womenBtn.tag=2;
    [womenBtn addTarget:self action:@selector(sexAction:) forControlEvents:UIControlEventTouchUpInside];
    [sexxView addSubview:womenBtn];
    
    UIButton * stdBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _stdBtn=stdBtn;
    [stdBtn setTitle:@"否" forState:UIControlStateNormal];
    [stdBtn setTitle:@"是" forState:UIControlStateSelected];
    [stdBtn setTitleColor:LPFrontMainColor forState:UIControlStateNormal];
    //[menBtn setTitleColor:LPUIMainColor forState:UIControlStateSelected];
    [stdBtn setBackgroundImage:btnBgColor forState:UIControlStateNormal];
    [stdBtn setBackgroundImage:btnBgSelectdColor forState:UIControlStateSelected];
    stdBtn.titleLabel.font=LPContentFont;
    stdBtn.layer.borderWidth = 0.1;
    stdBtn.layer.backgroundColor = [[UIColor lightGrayColor]CGColor];
    stdBtn.layer.cornerRadius = 5;
    stdBtn.tag=0;
    [stdBtn addTarget:self action:@selector(stdAction:) forControlEvents:UIControlEventTouchUpInside];
    [nnview addSubview:stdBtn];
    
    UIView *line1=[UIView new];
    line1.backgroundColor=[UIColor grayColor];
    [sexView addSubview:line1];
    
    UIView *line4=[UIView new];
    line4.backgroundColor=[UIColor grayColor];
    [stdView addSubview:line4];
    
    LPInputView *ageView=[[LPInputView alloc]init];
    _ageView=ageView;
    [scrollView addSubview:ageView];
    ageView.Title.text=@"年龄:";
    [ageView.Content removeFromSuperview];
    
    //    [ageView addSubview:view];
    //    ageView.Content=(UITextField *)view;
    UIView *ageeView=[UIView new];
    [scrollView addSubview:ageeView];
    
    UITextField * ageTextField1=[UITextField new];
    _ageTextField1=ageTextField1;
    ageTextField1.delegate = self;
    ageTextField1.placeholder=@"如 21";
    ageTextField1.keyboardType = UIKeyboardTypeNumberPad;
    ageTextField1.borderStyle=UITextBorderStyleRoundedRect;
    [ageeView addSubview:ageTextField1];
    
    UITextField * ageTextField2=[UITextField new];
    _ageTextField2=ageTextField2;
    ageTextField2.delegate = self;
    ageTextField2.placeholder=@"如 35";
    ageTextField2.keyboardType = UIKeyboardTypeNumberPad;
    ageTextField2.borderStyle=UITextBorderStyleRoundedRect;
    [ageeView addSubview:ageTextField2];
    
    
    UILabel *tip1=[UILabel new];
    tip1.font=LPContentFont;
    tip1.textAlignment=NSTextAlignmentCenter;
    tip1.text=@"-";
    
    [ageeView addSubview:tip1];
    
    UILabel *tip2=[UILabel new];
    tip2.font=LPContentFont;
    tip2.text=@"岁";
    [ageeView addSubview:tip2];
    
    
    LPInputView *moneyView=[[LPInputView alloc]init];
    _moneyView=moneyView;
    [scrollView addSubview:moneyView];
    moneyView.Title.text=@"薪资:";
    [moneyView.Content removeFromSuperview];
    
    UIView *moneyyView=[UIView new];
    [scrollView addSubview:moneyyView];
    //    [moneyView addSubview:view];
    //    moneyView.Content=(UITextField *)view;
    
    UITextField * moneyTextField1=[UITextField new];
    _moneyTextField1=moneyTextField1;
    moneyTextField1.placeholder=@"如 3";
    moneyTextField1.delegate = self;
    moneyTextField1.keyboardType = UIKeyboardTypeNumberPad;
    moneyTextField1.borderStyle=UITextBorderStyleRoundedRect;
    [moneyyView addSubview:moneyTextField1];
    
    UITextField * moneyTextField2=[UITextField new];
    _moneyTextField2=moneyTextField2;
    moneyTextField2.placeholder=@"如 5";
    moneyTextField2.delegate = self;
    moneyTextField2.keyboardType = UIKeyboardTypeNumberPad;
    moneyTextField2.borderStyle=UITextBorderStyleRoundedRect;
    [moneyyView addSubview:moneyTextField2];
    
    UILabel *moneyTip1=[UILabel new];
    moneyTip1.font=LPContentFont;
    moneyTip1.text=@"-";
    moneyTip1.textAlignment=NSTextAlignmentCenter;
    [moneyyView addSubview:moneyTip1];
    
    UILabel *moneyTip2=[UILabel new];
    moneyTip2.font=LPContentFont;
    moneyTip2.text=@"K";
    [moneyyView addSubview:moneyTip2];
    moneyTip2.hidden = YES;
    
    UIButton * talkBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _talkBtn= talkBtn;
    [talkBtn setTitle:@"面议" forState:UIControlStateNormal];
    [talkBtn setTitleColor:LPFrontMainColor forState:UIControlStateNormal];
    //[talkBtn setTitleColor:LPUIMainColor forState:UIControlStateSelected];
    [talkBtn setBackgroundImage:btnBgColor forState:UIControlStateNormal];
    [talkBtn setBackgroundImage:btnBgSelectdColor forState:UIControlStateSelected];
    talkBtn.titleLabel.font=LPContentFont;
    talkBtn.tag=0;
    [talkBtn addTarget:self action:@selector(talkAction:) forControlEvents:UIControlEventTouchUpInside];
    [moneyyView addSubview:talkBtn];
    
    UIView *line3=[UIView new];
    line3.backgroundColor=[UIColor grayColor];
    [moneyView addSubview:line3];
    
    UIView * toolView=[UIView new];
    _toolView=toolView;
    [self.view addSubview:toolView];
    
    UIButton * okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    okBtn.backgroundColor=LPUIMainColor;
    
    [okBtn addTarget:self  action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    _okBtn=okBtn;
    [toolView addSubview:okBtn];
    
    UIButton * cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor=[UIColor whiteColor];
    [cancelBtn setTitle:@"清空" forState:UIControlStateNormal];
    [cancelBtn addTarget:self  action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn=cancelBtn;
    [toolView addSubview:cancelBtn];
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    CGFloat w=width-20;
    sexView.frame=CGRectMake(10, 0, w, height);
    sexxView.frame=CGRectMake(10, CGRectGetMaxY(sexView.frame)-5, w, height);
    menBtn.frame=CGRectMake(5, 0, 50, 34);
    womenBtn.frame=CGRectMake(5+menBtn.frame.size.width+5, 0, 50, 34);
    
    stdView.frame=CGRectMake(10, 20 +height*1, w, height);
    nnview.frame = CGRectMake(10, 20 +height*2-5, w, height);
    
    
    ageView.frame=CGRectMake(10, 20 +height*3-15, w, height);
    ageeView.frame = CGRectMake(10, 20 +height*4-20, w, height);
    
    
    //    view.frame = CGRectMake(10, CGRectGetMaxY(sexView.frame),w,height);
    //    view.backgroundColor = [UIColor orangeColor];
    
    
    //    ageView.frame=CGRectMake(10, 20 +height*3, w, height);
    moneyView.frame=CGRectMake(10, 20+height*5-25, w, height);
    moneyyView.frame=CGRectMake(10, 20+height*6-30, w, height);
    
    
    stdBtn.frame=CGRectMake(5, 0, 50, 34);
    ageTextField1.frame=CGRectMake(5, 0, 65, 34);
    tip1.frame=CGRectMake(5+60+5, 0, 30, 34);
    ageTextField2.frame=CGRectMake(CGRectGetMaxX(tip1.frame), 0, 65, 34);
    tip2.frame=CGRectMake(CGRectGetMaxX(ageTextField2.frame)+5, 0, 30, 34);
    
    
    moneyTextField1.frame=ageTextField1.frame;
    moneyTip1.frame=tip1.frame;
    moneyTextField2.frame=ageTextField2.frame;
    moneyTip2.frame=tip2.frame;
    talkBtn.frame=CGRectMake(CGRectGetMaxX(ageTextField2.frame)+20, 0, 50, 34);
    
    //    line1.frame=CGRectMake(5, 43.5, width, 0.5);
    //    line4.frame=line3.frame=line2.frame=line1.frame;
    _toolView.frame=CGRectMake(0,CGRectGetMaxY(moneyyView.frame)+10, w, 60);
    _okBtn.frame=CGRectMake(10,10, w*0.5-15, 40);
    _cancelBtn.frame=CGRectMake(w*0.5+5,10, w*0.5-15, 40);
    CGFloat x=CGRectGetMaxY(_toolView.frame);
    if(x<=self.view.frame.size.height-64)
    {
        x=self.view.frame.size.height-63;
    }
    scrollView.contentSize=CGSizeMake(0,x);
    [self initSelectData];
    
    
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.btn];
    
    
    [self creadLabel];
    
    [self Show:YES];
    
}

- (void)creadLabel
{
    CGFloat w = self.view.frame.size.width;
    _formLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 250, w/2, 30)];
    _formLabel.text = @"始";
    _formLabel.textAlignment = NSTextAlignmentCenter;
    _formLabel.backgroundColor = collectionBGColor;
    [self.view addSubview:_formLabel];
    
    _toLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/2, 250, w/2, 30)];
    _toLabel.text = @"末";
    _toLabel.textAlignment = NSTextAlignmentCenter;
    _toLabel.backgroundColor = collectionBGColor;
    [self.view addSubview:_toLabel];
}

-(void)stdAction:(UIButton *)btn
{
    _stdBtn.selected=!_stdBtn.selected;
}
-(void)sexAction:(UIButton *)btn
{
    
    _sex=btn.tag;
    if (_sex==1) {
        _menBtn.selected=YES;
        _womenBtn.selected=NO;
    }
    else if (_sex==2)
    {
        _menBtn.selected=NO;
        _womenBtn.selected=YES;
    }
}
-(void)talkAction:(UIButton *)btn
{
    _talkBtn.selected=!_talkBtn.selected;
    if(_talkBtn.selected)
    {
        _moneyTextField1.text=@"";
        _moneyTextField2.text=@"";
        _moneyTextField1.userInteractionEnabled=NO;
        _moneyTextField2.userInteractionEnabled=NO;
        _params[@"MONTHLYPAY_S"]=@"0";
        _params[@"MONTHLYPAY_E"]=@"0";
    }
    else
    {
        _moneyTextField1.userInteractionEnabled=YES;
        _moneyTextField2.userInteractionEnabled=YES;
    }
    
}
-(void)initSelectData
{
    NSString *SEX= [_params objectForKey:@"SEX"];
    if (SEX)
    {
        _sex=SEX.integerValue;
        if (_sex==1) {
            _menBtn.selected=YES;
            _womenBtn.selected=NO;
        }
        else if (_sex==2)
        {
            _menBtn.selected=NO;
            _womenBtn.selected=YES;
        }
        
    }
    NSString *std= [_params objectForKey:@"ISSTUDENT"];
    if (std) {
        _stdBtn.selected=YES;
    }
    
    _ageTextField1.text=_params[@"AGE_S"];
    _ageTextField2.text=_params[@"AGE_E"];
    NSString *MONEY_S=_params[@"MONTHLYPAY_S"];
    NSString *MONEY_E=_params[@"MONTHLYPAY_E"];
    if (MONEY_S!=nil && MONEY_E !=nil) {
        if (MONEY_S.integerValue==0 && MONEY_E.integerValue==0) {
            _moneyTextField1.userInteractionEnabled=NO;
            _moneyTextField2.userInteractionEnabled=NO;
            _talkBtn.selected=YES;
        }
        else
        {
            _moneyTextField1.text=_params[@"MONTHLYPAY_S"];
            _moneyTextField2.text=_params[@"MONTHLYPAY_E"];
            _moneyTextField1.userInteractionEnabled=YES;
            _moneyTextField2.userInteractionEnabled=YES;
            _talkBtn.selected=NO;
        }
    }
    
}
-(void)okAction
{
    [self.view endEditing:YES];
    if (_sex) {_params[@"SEX"]=[NSNumber numberWithInteger:_sex];}
    if (_stdBtn.selected) {
        _params[@"ISSTUDENT"]=[NSNumber numberWithInteger:1];
    }
    else
    {
        [_params removeObjectForKey:@"ISSTUDENT"];
    }
    if (_ageTextField1.text.length>0 &&_ageTextField2.text.length>0)
    {
        if (_ageTextField1.text.integerValue>_ageTextField2.text.integerValue)
        {
            NSString *Error=@"最小值大于最大值";
            [MBProgressHUD showError:Error];
            return;
        }
        else
        {
            _params[@"AGE_S"]=_ageTextField1.text;
            _params[@"AGE_E"]=_ageTextField2.text;
        }
        
    }
    if (_talkBtn.selected) {
        _params[@"MONTHLYPAY_S"]=@"0";
        _params[@"MONTHLYPAY_E"]=@"0";
    }
    else
    {
        if (_moneyTextField1.text.length>0 &&_moneyTextField2.text.length>0)
        {
            if (_moneyTextField1.text.integerValue>_moneyTextField2.text.integerValue)
            {
                NSString *Error=@"最小值大于最大值";
                [MBProgressHUD showError:Error];
                return;
            }
            else
            {
                _params[@"MONTHLYPAY_S"]=_moneyTextField1.text;
                _params[@"MONTHLYPAY_E"]=_moneyTextField2.text;
            }
            
        }
    }
    _completeBlock();
}

-(void)cancelAction
{
    [self.view endEditing:YES];
    _menBtn.selected=NO;
    _womenBtn.selected=NO;
    _sex=0;
    _ageTextField1.text=@"";
    _moneyTextField1.text=@"";
    _ageTextField2.text=@"";
    _moneyTextField2.text=@"";
    _stdBtn.selected=NO;
    
    if(_talkBtn.selected)
    {
        [self talkAction:_talkBtn];
    };
    
    [_params  removeObjectForKey:@"SEX"];
    [_params  removeObjectForKey:@"AGE_S"];
    [_params  removeObjectForKey:@"AGE_E"];
    [_params  removeObjectForKey:@"MONTHLYPAY_S"];
    [_params  removeObjectForKey:@"MONTHLYPAY_E"];
    [_params removeObjectForKey:@"ISSTUDENT"];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    [_pickerView removeFromSuperview];
    [self Show:YES];
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    [_pickerView removeFromSuperview];
    [self Show:YES];
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_ageTextField1 == textField) {
        [self createDataSource];
        [self Show:NO];
        _ageOrMoney = NO;
        return NO;
    }
    if (_ageTextField2 == textField) {
        [self createDataSource];
        [self Show:NO];
        _ageOrMoney = NO;
        return NO;
    }
    if (_moneyTextField1 == textField) {
        [self createDataSource2];
        [self Show:NO];
        _ageOrMoney = YES;;
        return NO;
    }
    if (_moneyTextField2 == textField) {
        [self createDataSource2];
        [self Show:NO];
        _ageOrMoney = YES;
        return NO;
    }
    
    return YES;
}


//创建pickerView
- (UIPickerView *)pickerView
{
    //初始化一个PickerView
    CGFloat h = self.view.frame.size.height;
    CGFloat w = self.view.frame.size.width;

    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 280, w, 150)];
    _pickerView.backgroundColor = collectionBGColor;
    _pickerView.tag = 1000;
    //指定Picker的代理
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    //是否要显示选中的指示器(默认值是NO)
    _pickerView.showsSelectionIndicator = NO;
    
    return _pickerView;
}

#pragma mark --- 与DataSource有关的代理方法
//返回列数（必须实现）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//返回每列里边的行数（必须实现）
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //如果是第一列
    if (component == 0) {
        //返回姓名数组的个数
        return self.nameArray.count;
    }
    else
    {
        //返回表情数组的个数
        return self.iconArray.count;
    }
    
}

#pragma mark --- 与处理有关的代理方法
//设置组件的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return 80;
    }
    else
    {
        return 80;
    }
    
}
//设置组件中每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (component == 0) {
        return 30;
    }
    else
    {
        return 30;
    }
}
//设置组件中每行的标题row:行
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.nameArray[row];
    }
    else
    {
        return self.iconArray[row];
    }
}


//选中行的事件处理
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
              [pickerView selectedRowInComponent:0];
        //        //重新加载数据
        //        [pickerView reloadAllComponents];
        //        //重新加载指定列的数据
        //        [pickerView reloadComponent:1];
    }
    else
    {
       
    }
}

//创建btn
- (UIButton *)btn
{
    _btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(130, 430, 150, 30);
    [_btn setTitle:@"确定" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return _btn;
}

//btn的回调方法
- (void)btnAction: (UIButton *)sender
{
    //获取pickerView
    UIPickerView *pickerView = [self.view viewWithTag:1000];
    //选中的行
    NSInteger result = [pickerView selectedRowInComponent:0];
    NSInteger result1 = [pickerView selectedRowInComponent:1];
    //赋值
    
    if ([self.nameArray[result] intValue] > [self.iconArray[result1] intValue]) {
        [MBProgressHUD showError:@"起始不能大于末"];
        return;
    }
    
    if (_ageOrMoney) {
        _moneyTextField1.text =self.nameArray[result];
        _moneyTextField2.text = self.iconArray[result1];
    }else{
        self.ageTextField1.text = self.nameArray[result];
        self.ageTextField2.text = self.iconArray[result1];}
    
    
    
    [self Show:YES];
    
}

- (void)Show:(BOOL)show
{
    _formLabel.hidden = show;
    _toLabel.hidden = show;
    _pickerView.hidden = show;
    _btn.hidden = show;
}

@end
