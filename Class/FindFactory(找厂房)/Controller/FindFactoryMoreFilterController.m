//
//  FindFactoryMoreFilterController.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "FindFactoryMoreFilterController.h"
#import "Global.h"
#import "BasicData.h"
#import "NSString+Extension.h"
#import "MoreFilterCell.h"
#import "LPAgeView.h"
#import "LPMoneyView.h"
typedef void (^CompleteBlock)();
@interface FindFactoryMoreFilterController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    CGFloat _heightArray[100];
}
@property (strong, nonatomic) NSArray * data;
@property (strong, nonatomic) NSArray * titleData;
@property (strong, nonatomic) NSArray * nameData;
@property (weak, nonatomic) UITableView * tableView;
@property (weak, nonatomic) UIView * toolView;
@property (weak, nonatomic) UIButton * okBtn;
@property (weak, nonatomic) UIButton * cancelBtn;
@property (weak, nonatomic) UIButton * closeBtn;
@property (strong, nonatomic) CompleteBlock  completeBlock;
@property (strong, nonatomic) CompleteBlock  closeBlock;
@property (strong, nonatomic)NSMutableDictionary * params;

@end

@implementation FindFactoryMoreFilterController

-(instancetype)initWithParams:(NSMutableDictionary *)params array:(NSArray *)array CompleteBlock:completeBlock CloseBlock:closeBlock
{
    self=[super init];
    if (self) {
        _completeBlock=completeBlock;
        _closeBlock=closeBlock;
        _params=params;
        _titleData=array[0];
        _nameData=@[@"property",@"new_old",@"factory_architecture",@"dining_room",@"unit_price",@"power_distribution",@"blank_acreage"];
        _data=array[2];
        [self calculateFrame];
        [self initSelectData];
    }
    return self;
}
-(void)initSelectData
{
    NSInteger x=0;
    for (NSString * name in _nameData)
    {
        NSNumber *num= [_params objectForKey:name];
        if (num!=nil)
        {
            NSArray * array=_data[x];
            for (BasicData *data in array)
            {
                if ([num isEqualToNumber:data.ZD_ID])
                {
                    data.isSelect=YES;
                    break;
                }
            }
        }
        x++;
    }
}
- (void )calculateFrame
{
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    w=w*0.7;
    CGFloat space=5;
    CGFloat height=30;
    CGFloat x1;
    CGFloat x2;
    CGFloat y1;
    NSInteger row;
    NSInteger index=0;
    for (NSArray * array in _data)
    {
        x1=space;
        y1=space;
        row=0;
        for (int a=0; a<array.count; a++)
        {
            BasicData * data=array[a];
            x2=x1+data.w+space;
            if (w>x2)
            {
                data.frame=CGRectMake(x1, y1, data.w, height);
                x1= x2+space;
            }
            else
            {
                y1+=height+space;
                x1= space;
                data.frame=CGRectMake(x1, y1, data.w, height);
                x1+= space+data.w;
            }
            
        }
        y1+=height+space;
        _heightArray[index]=y1;
        index++;
    }
   // _heightArray[5]=_heightArray[4]=44;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=LPUIBgColor;
    
    
    UITableView * tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    // self.tableView.scrollEnabled =NO;
    [self.view addSubview:tableView];
    
    
    UIView * toolView=[UIView new];
    _toolView=toolView;
    [self.view addSubview:toolView];
    
    UIButton * okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    okBtn.backgroundColor=[UIColor whiteColor];
    [okBtn addTarget:self  action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    _okBtn=okBtn;
    okBtn.layer.cornerRadius=3;
    [toolView addSubview:okBtn];
    
    UIButton * cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor=[UIColor whiteColor];
    [cancelBtn setTitle:@"清空" forState:UIControlStateNormal];
    [cancelBtn addTarget:self  action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn=cancelBtn;
    cancelBtn.layer.cornerRadius=3;
    [toolView addSubview:cancelBtn];
    
    UIButton * closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    closeBtn.backgroundColor=[UIColor whiteColor];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self  action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    _closeBtn=closeBtn;
    closeBtn.layer.cornerRadius=3;
    [toolView addSubview:closeBtn];
    
    [self setViewFrame];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_tableView];
}
-(void)setViewFrame
{
    CGFloat w=self.view.frame.size.width;
    _tableView.frame=CGRectMake(0, 0, w, self.view.frame.size.height-60);
    _toolView.frame=CGRectMake(0,self.view.frame.size.height-60, w, 60);
    w=(w-40)/3;
    _okBtn.frame=CGRectMake(10,10, w, 40);
    _cancelBtn.frame=CGRectMake(w+20,10, w, 40);
    _closeBtn.frame=CGRectMake(2*w+30,10, w, 40);
}
-(void)okAction
{
    [self.view endEditing:YES];
    NSInteger x=0;
    NSInteger y=0;
    for (NSArray *array in _data)
    {
        for (BasicData * data in array)
        {
            if (data.isSelect)
            {
                if(data.ZD_ID!=nil)
                {
                    _params[_nameData[x]]=data.ZD_ID;
                    y=1;
                }
                continue;
            }
        }
        if (!y)
        {
            [_params removeObjectForKey:_nameData[x]];
            y=0;
        }
        x++;
        
    }
    _completeBlock();
}

-(void)cancelAction
{
    for (NSArray *array in _data)
    {
        for (BasicData *data in array)
        {
            data.isSelect=NO;
        }
    }
    [_tableView reloadData];
}
-(void)closeAction
{
    _closeBlock();
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreFilterCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil)
    {
        cell = [[MoreFilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        for (UIButton *btn in cell.btnViews) {
            [btn addTarget:self  action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    cell.Title.text=_titleData[indexPath.row];
    cell.data=_data[indexPath.row];
    cell.ContentView.tag=indexPath.row;
    [cell hiddenAgeAndMoneyView];
    return cell;
}
#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _heightArray[indexPath.row];
}
-(void)selectBtnAction:(UIButton *)btn
{
    NSInteger row=btn.superview.tag;
    NSInteger num=btn.tag;
    NSArray *array=_data[row];
    NSInteger index=0;
    for (BasicData *data in array)
    {
        if (num==index)
        {
            data.isSelect= !data.isSelect;
        }
        else
        {data.isSelect=NO;}
        index++;
    }
    [_tableView reloadData];
    
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [self.view endEditing:YES];
//    return YES;
//}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self.view endEditing:YES];
//}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}

@end
