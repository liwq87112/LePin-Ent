//
//  LPEOpenPositionsViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/1/4.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPEOpenPositionsViewController.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "Global.h"
#import "MLTableAlert.h"
#import "postModel.h"
#import "BasicData.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "BRPlaceholderTextView.h"
#define postPlace @"请勿输入公司邮箱、联系电话、薪资面议及其它外链接，否则将自动删除，不可恢复"
#define hangyeFont [UIFont systemFontOfSize:13]
#define serverW [UIScreen mainScreen].bounds.size.width
#define collectionBGColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]
#define collectionLayColor [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]
#define collectionLabelColor [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0]
@interface LPEOpenPositionsViewController ()<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *moneySalaryBut;
@property (weak, nonatomic) IBOutlet UIButton *ageSalaryBut;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UITextField *positionTextfield;
@property (weak, nonatomic) IBOutlet UITextField *departmentTextfield;
@property (weak, nonatomic) IBOutlet UITextField *numTextfield;
@property (weak, nonatomic) IBOutlet UITextField *fronMoneyTextField;
@property (weak, nonatomic) IBOutlet UITextField *toMoneyTextField;
@property (weak, nonatomic) IBOutlet UITextField *fromAgeTextField;
@property (weak, nonatomic) IBOutlet UITextField *toAgeTextField;
@property (weak, nonatomic) IBOutlet UIView *PositionWelfareView;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *workAgeTextField;
@property (weak, nonatomic) IBOutlet UITextField *eduTextField;
@property (weak, nonatomic) IBOutlet UITextField *workAddTextField;
@property (strong, nonatomic) IBOutlet UITextView *positionTextView;
@property (weak, nonatomic) IBOutlet UITextField *human;
@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (nonatomic, strong) MLTableAlert *alert;
@property (nonatomic, strong) postModel *data;
@property (nonatomic, strong) NSMutableArray *eduBaseArray;
@property (nonatomic, strong) NSMutableArray *delpArray;
@property (nonatomic, strong) NSMutableArray *delpIdArray;
@property (nonatomic, strong) NSMutableArray *welfareArray;
@property (nonatomic, strong) NSString *welStr;
@property (nonatomic, strong) NSString *welStrName;
@property (nonatomic, strong) NSString *CONTACT;
@property (nonatomic, strong) NSString *PHONE;
@end

@implementation LPEOpenPositionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_positionTextView.frame)+50);
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = collectionBGColor;
    _PositionWelfareView.backgroundColor = collectionBGColor;
    _navView.backgroundColor = LPUIMainColor;

    [self allTextFiled];
    
    [self postPostion];
    
    [self selePostFare];
    
    [self deparPost];
    
    [self getBoolData];
    

}


- (postModel *)data
{
    if (!_data) {
        _data = [[postModel alloc]init];
    }
    return _data;
}

- (NSMutableArray *)eduBaseArray
{
    if (!_eduBaseArray) {
        _eduBaseArray = [NSMutableArray array];
    }
    return _eduBaseArray;
}

- (NSMutableArray *)delpArray
{
    if (!_delpArray) {
        _delpArray = [NSMutableArray array];
    }
    return _delpArray;
}

- (NSMutableArray *)welfareArray
{
    if (!_welfareArray) {
        _welfareArray = [NSMutableArray array];
    }
    return _welfareArray;
}

- (NSMutableArray *)delpIdArray
{
    if (!_delpIdArray) {
        _delpIdArray = [NSMutableArray array];
    }
    return _delpIdArray;
}

- (void)postPostion{

    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 0, 100, 30);
    but.center = CGPointMake(serverW/2, CGRectGetMaxY(_positionTextView.frame)+20);

    if (_boolPostOrRe) {
        [but setTitle:@"修改" forState:UIControlStateNormal];
    }else{
        [but setTitle:@"发布职位" forState:UIControlStateNormal];}
    [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    [but addTarget:self action:@selector(reSend) forControlEvents:UIControlEventTouchUpInside];
    but.layer.borderWidth = 0.5;
    but.layer.cornerRadius = 5;
    but.layer.borderColor = [[UIColor orangeColor]CGColor];
    [_scrollView addSubview:but];
    
}

- (IBAction)navPop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)allTextFiled
{
   // [self textFieldLayB:_positionTextfield];
    [self textBut:_departmentTextfield];
    [self textFieldLayB:_human];
    [self textFieldLayB:_phone];
    [self textFieldLayB:_numTextfield];
    [self textBut:_fronMoneyTextField];
    [self textBut:_toMoneyTextField];
    [self textBut:_fromAgeTextField];
    [self textBut:_toAgeTextField];
    [self textBut:_sexTextField];
    [self textBut:_workAgeTextField];
    [self textBut:_eduTextField];
    [self textBut:_workAddTextField];

    _positionTextView.layer.borderWidth = 0.5;
    _positionTextView.layer.cornerRadius = 5;
    _positionTextView.layer.borderColor = collectionLayColor.CGColor;
    
    [self But_but:_moneySalaryBut];
    [self But_but:_ageSalaryBut];

    
}

- (void)textBut:(UITextField *)textField
{
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"下拉更多"]];
    textField.rightView = imageView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    imageView.contentMode = UIViewContentModeCenter;
  //  [self textFieldLayB:textField];
}

- (void)textFieldLayB:(UITextField *)textField
{
   // textField.layer.borderWidth = 0.5;
   // textField.layer.cornerRadius = 5;
   // textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}

- (void)But_but:(UIButton *)but
{
    but.layer.borderWidth = 0.5;
    but.layer.borderColor = collectionLayColor.CGColor;
    [but setBackgroundImage:[self saImageWithSingleColor:collectionBGColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[self saImageWithSingleColor:[UIColor greenColor]] forState:UIControlStateSelected];
    [but addTarget:self action:@selector(moneyAndAge:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)moneyAndAge:(UIButton *)but
{
    but.selected = !but.selected;
    if (_moneySalaryBut.selected) {
        _fronMoneyTextField.text = @"";
        _toMoneyTextField.text = @"" ;
    }
    if (_ageSalaryBut.selected) {
        _fromAgeTextField.text = @"";
        _toAgeTextField.text = @"" ;
    }
}

-(void)SelectSEX
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择性别" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return 3;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      switch (indexPath.row) {
                          case 0:
                              cell.textLabel.text=@"不限";
                              break;
                          case 1:
                              cell.textLabel.text=@"男";
                              break;
                          case 2:
                              cell.textLabel.text=@"女";
                              break;
                          default:
                              break;
                      }
                      return cell;
                  }];
    self.alert.height = 200;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         switch (selectedIndex.row) {
             case 0:
                 self.data.sexId =[NSNumber numberWithInt:0];
                 self.data.sexName=@"不限";
                 _sexTextField.text = @"不限";
                 break;
             case 1:
                 self.data.sexId=[NSNumber numberWithInt:1];
                 self.data.sexName=@"男";
                 _sexTextField.text = @"男";
                 break;
             case 2:
                 self.data.sexId=[NSNumber numberWithInt:2];
                 self.data.sexName=@"女";
                 _sexTextField.text = @"女";
                 break;
             default:
                 break;
         }
         
     } andCompletionBlock:^{}];
    [self.alert show];
}


-(void)SelectEDU_BG
{
    [self GetBasicDataWith:@"edu" andTitle:@"请选择学历要求"];
}

-(void)SelectWORKEXPERIENCE
{
    [self GetBasicDataWith:@"WORKEXPERIENCE" andTitle:@"请选择经验要求"];
}
//福利
- (void)selePostFare{
    [self GetBasicDataWith:@"POSITION_WELFARE" andTitle:@""];

}

-(void)GetBasicDataWith:(NSString *)BIANMA andTitle:(NSString * )Title;
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BIANMA"] = BIANMA;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBaseDataByCode.do?"] params:params success:^(id json)
     {

         NSNumber * result= [json objectForKey:@"result"];
         NSArray * list =[json objectForKey:@"baseDataList"];
         if(1==[result intValue])
         {
             NSMutableArray * datas=[[NSMutableArray alloc]init];
               for (NSDictionary *dict in list)
                 {
                     BasicData * data = [BasicData BasicWithlist:dict];
                         [datas addObject: data];
                 }
             self.eduBaseArray=datas;
             if ([BIANMA isEqualToString:@"POSITION_WELFARE"]) {
                 self.welfareArray = datas;
                 for (int i = 0; i < self.eduBaseArray.count; i++) {
                     UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
                     BasicData * data = self.eduBaseArray[i];
                     int j = 0;
                     if (i >= 4) {
                         j = 1;
                         i = i-4;
                     }
                     but.frame = CGRectMake(5+((serverW - 30)/4+6)*i, 20+(20+2)*j, (serverW - 30)/4, 20);
                     but.titleLabel.font = hangyeFont;
                     [but setTitle:data.NAME forState:UIControlStateNormal];
                     if (j == 1 ) {
                         i = i+4;
                     }
                     [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                     if (_boolPostOrRe) {
                         if ([_model.POSITIONWELFARE_NAMES containsString:data.NAME]) {
                             but.selected = YES;
                             [self seleFlPost:data];
                         }else{
                             but.selected = NO;
                         }
                     }
                     but.tag = i+166;
                     [but setBackgroundImage:[self saImageWithSingleColor:[UIColor whiteColor]] forState:UIControlStateNormal];
                     [but setBackgroundImage:[self saImageWithSingleColor:[UIColor greenColor]] forState:UIControlStateSelected];
                     [but addTarget:self action:@selector(but:) forControlEvents:UIControlEventTouchUpInside];
                     [_PositionWelfareView addSubview:but];
                 }
                 return ;
             }
             [self SelectBasicDataWith:BIANMA andTitle:Title];
         }
     } failure:^(NSError *error)
     {
     }];
}

#pragma mark -- fuli

- (void)seleFlPost:(BasicData *)data
{
    if (_welStr.length > 0) {
        _welStr = [NSString stringWithFormat:@"%@,%@",_welStr,data.ZD_ID];
        _welStrName = [NSString stringWithFormat:@"%@,%@",_welStrName,data.NAME];
    }else{
        _welStr = [NSString stringWithFormat:@"%@",data.ZD_ID];
        _welStrName = [NSString stringWithFormat:@"%@",data.NAME];
    }
    
}

- (void)but:(UIButton *)btn
{
    BasicData * data = self.welfareArray[btn.tag - 166];
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self seleFlPost:data];
    }else{
        if ( [_welStr containsString:@","]) {
            _welStr = [_welStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@",%@",data.ZD_ID] withString:@""];
            _welStrName = [_welStrName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@",%@",data.NAME] withString:@""];
        }else{
            _welStr = [_welStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",data.ZD_ID] withString:@""];
            _welStrName = [_welStrName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",data.NAME] withString:@""];
        }
    }
}

-(void)SelectBasicDataWith:(NSString *)BIANMA andTitle:(NSString * )Title
{
    self.alert = [MLTableAlert tableAlertWithTitle:Title cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return self.eduBaseArray.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      BasicData *data=self.eduBaseArray[indexPath.row];
                      cell.textLabel.text=data.NAME;
                      
                      return cell;
                  }];
    self.alert.height = self.eduBaseArray.count*44;
 
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         BasicData *data= self.eduBaseArray[selectedIndex.row];
         if ([BIANMA isEqualToString:@"WORKEXPERIENCE"])
         {
             self.data.WORKEXPERIENCE_ID = data.ZD_ID;
             _workAgeTextField.text = data.NAME;
         }
         else if([BIANMA isEqualToString:@"edu"])
         {
             self.data.EDU_BG_ID = data.ZD_ID;
             _eduTextField.text = data.NAME;

         }

     } andCompletionBlock:^{}];
    [self.alert show];
}

- (void)getComAddr
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_WORKADDRESSLIST"];
    params[@"ENT_ID"] = ENT_ID;
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getWorkAddressList.do"] params:params view:nil success:^(id json) {
        NSNumber *result = json[@"result"];
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:json[@"workAddressList"]];
        if ([result intValue] == 1) {
            self.alert = [MLTableAlert tableAlertWithTitle:@"选择工作地址" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                          {
                              return array.count;
                          }
                                                  andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                          {
                              static NSString *CellIdentifier = @"CellIdentifier";
                              UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                              if (cell == nil)
                                  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

                              cell.textLabel.text=array[indexPath.row][@"WORK_ADDRESS"];
                              
                              return cell;
                          }];
            self.alert.height = array.count*44;
            
            [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
             {

                     self.data.workAddID = array[selectedIndex.row][@"ID"];
                     _workAddTextField.text = array[selectedIndex.row][@"WORK_ADDRESS"];
              
                 
             } andCompletionBlock:^{}];
            [self.alert show];

        }
        
    } failure:^(NSError * error) {
        
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
            _CONTACT = json[@"CONTACT"];
            _PHONE = json[@"PHONE"];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)deparPostShow
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择所属部门" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return self.delpArray.count+1;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      if (indexPath.row < self.delpArray.count) {
                          cell.textLabel.text=self.delpArray[indexPath.row][@"DEPT_NAME"];
                      }if (indexPath.row == self.delpArray.count) {
                          cell.textLabel.text = @"新增部门";
                      }
                      
                      
                      return cell;
                  }];
    self.alert.height = self.view.frame.size.height*0.7;
    
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         if (selectedIndex.row < self.delpArray.count) {
         self.data.departmentID = self.delpArray[selectedIndex.row][@"DEPT_ID"];
             _departmentTextfield.text = self.delpArray[selectedIndex.row][@"DEPT_NAME"];}
         if (selectedIndex.row == self.delpArray.count) {
             [self addnewdept];
         }
         _human.text = _CONTACT;
         _phone.text = _PHONE;
         
         
     } andCompletionBlock:^{}];
    [self.alert show];
}

#pragma mark -- add new dept

- (void)addnewdept{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新增部门";
    }];
    
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"新增" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         UITextField *login = alert.textFields.firstObject;
        [self newaddweb:login.text];
        
    }];
    
    [alert addAction:act];
    [alert addAction:act1];
    
    [self presentViewController:alert animated:YES completion:nil];

    

}

- (void)newaddweb:(NSString *)str
{
    if (str.length < 1) {
        [MBProgressHUD showError:@"部门不能为空"];
        
        return;
    }
    
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"S_USER_DEPT"];
    parms[@"DEPT_NAME"] = str;
    parms[@"ENT_ID"] = ENT_ID;
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/setChildUserDept.do"] params:parms view:self.scrollView success:^(id json) {
        NSNumber *result = json[@"result"];
        if ([result intValue]== 1) {
            _departmentTextfield.text = str;
            self.data.departmentID = json[@"DEPT_ID"];
            [self deparPost];
            
        }
        if ([result intValue]== 11) {
            [MBProgressHUD showError:@"部门已存在"];
        }
        
    } failure:^(NSError *error) {
        
    }];

}



- (void)fromToMoney:(UITextField *)textField
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *title;
    if (_fronMoneyTextField == textField) {
        for (int i = 2; i < 18; i ++) {
            [array addObject:[NSString stringWithFormat:@"%d000",i+1]];
        }
        title = @"选择薪资";
    }
    if (_toMoneyTextField == textField) {
        for (int i = 3; i < 18; i ++) {
            [array addObject:[NSString stringWithFormat:@"%d000",i+1]];
        }
        title = @"选择薪资";
    }
    if (_fromAgeTextField == textField) {
        for (int i = 16; i < 51; i ++) {
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
        title = @"选择年龄";
    }
    if (_toAgeTextField == textField) {
        for (int i = 18; i < 51; i ++) {
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
        title = @"选择年龄";
    }
    
    self.alert = [MLTableAlert tableAlertWithTitle:title cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return array.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      
                      cell.textLabel.text=array[indexPath.row];
                      
                      return cell;
                  }];
    self.alert.height = self.view.frame.size.height*0.7;
    
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         
         if (_fronMoneyTextField == textField) {
             if (_toMoneyTextField.text.length > 0) {
                 if ([_toMoneyTextField.text intValue] <= [array[selectedIndex.row] intValue]) {
                     [MBProgressHUD showError:@"薪资区间不正确"];
                     return ;
                 }
             }
              _fronMoneyTextField.text = array[selectedIndex.row];
         }
         if (_toMoneyTextField == textField) {
             if (_fronMoneyTextField.text.length > 0) {
                 if ([array[selectedIndex.row] intValue] <= [_fronMoneyTextField.text intValue]) {
                     [MBProgressHUD showError:@"薪资区间不正确"];
                     return ;
                 }
             }
              _toMoneyTextField.text = array[selectedIndex.row];
         }
         if (_fromAgeTextField == textField) {
             if (_toAgeTextField.text.length > 0) {
                 if ([array[selectedIndex.row] intValue] >= [_toAgeTextField.text intValue]) {
                     [MBProgressHUD showError:@"年龄区间不正确"];
                     return ;
                 }
             }
              _fromAgeTextField.text = array[selectedIndex.row];
         }
         if (_toAgeTextField == textField) {
             if (_fromAgeTextField.text.length > 0) {
                 if ([array[selectedIndex.row] intValue] <= [_fromAgeTextField.text intValue]) {
                     [MBProgressHUD showError:@"年龄区间不正确"];
                     return ;
                 }
             }
              _toAgeTextField.text = array[selectedIndex.row];
         }
        
         
         
     } andCompletionBlock:^{}];
    [self.alert show];
}



#pragma  mark - sendPost
- (void)reSend
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"USER_ID"] = USER_ID;
    params[@"ENT_ID"] = ENT_ID;
    if (_positionTextfield.text.length < 1) {
        [MBProgressHUD showError:@"请输入职位名称"];
        return;
    }
    params[@"POSITIONNAME"] = _positionTextfield.text;
    
    if (!self.data.departmentID) {
        [MBProgressHUD showError:@"请选择所属部门"];
        return;
    }
    
    if (_human.text.length < 1) {
        [MBProgressHUD showError:@"请输入联系人"];
        return;
    }
    if (_phone.text.length < 1) {
        [MBProgressHUD showError:@"请输入联系人电话"];
        return;
    }
    if (![self isMobileNumber:_phone.text]) {
        [MBProgressHUD showError:@"请输入正确电话"];
        return;
    }
    params[@"CONTACT"] = _human.text;
    params[@"PHONE"] = _phone.text;
    
    params[@"DEPT_ID"] = self.data.departmentID;
    if (_numTextfield.text.length < 1) {
        [MBProgressHUD showError:@"请输入招聘人数"];
        return;
    }
    params[@"RECRUITING_NUM"] = _numTextfield.text;
    if (_moneySalaryBut.selected) {
        params[@"SALARYMIN"] = @"0";
        params[@"SALARYMAX"] = @"0";
    }else{
        if (_fronMoneyTextField.text.length < 1) {
            [MBProgressHUD showError:@"请选择薪资"];
            return;
        }
     ;
        params[@"SALARYMIN"] = [_fronMoneyTextField.text stringByReplacingOccurrencesOfString:@"000" withString:@""];
        params[@"SALARYMAX"] = [_toMoneyTextField.text stringByReplacingOccurrencesOfString:@"000" withString:@""];
    }
    if (_ageSalaryBut.selected) {
        params[@"AGEMIN"] = @"0";
        params[@"AGEMAX"] = @"0";
    }else{
        if (_fromAgeTextField.text.length < 1) {
            [MBProgressHUD showError:@"请选择年龄"];
            return;
        }
        params[@"AGEMIN"] = _fromAgeTextField.text;
        params[@"AGEMAX"] = _toAgeTextField.text;
    }
    
//    if (_welStr.length < 1) {
//        [MBProgressHUD showError:@"请选择职位福利"];
//        return;
//    }
    if (_welStr.length > 0) {
        params[@"POSITIONWELFARE_IDS"] = _welStr;
        params[@"POSITIONWELFARE_NAMES"] = _welStrName;
    }
    
    
    if (!self.data.sexId) {
        [MBProgressHUD showError:@"请选择性别"];
        return;
    }
    params[@"SEX"] = self.data.sexId;
    if (!self.data.WORKEXPERIENCE_ID) {
        [MBProgressHUD showError:@"请选择工作经验"];
        return;
    }
    params[@"WORKEXPERIENCE_ID"] = self.data.WORKEXPERIENCE_ID;
    if (!self.data.EDU_BG_ID) {
        [MBProgressHUD showError:@"请选择学历要求"];
        return;
    }
    params[@"EDU_BG_ID"] = self.data.EDU_BG_ID;
    if (!self.data.workAddID) {
         [MBProgressHUD showError:@"请选择工作地址"];
        return;
    }
    params[@"WORK_ADDRESS_ID"] = self.data.workAddID;
    if (_positionTextView.text.length < 1) {
        [MBProgressHUD showError:@"请输入职位描述"];
        return;
    }
    params[@"DUTY"] = _positionTextView.text;
    
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"A_POST_POSITION"];
    
    if (_boolPostOrRe) {
        params[@"POSITIONPOSTED_ID"] = _model.POSITIONPOSTED_ID;
        [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editPositionposted.do"] params:params view:self.scrollView success:^(id json) {
            NSNumber *result = json[@"result"];
            if ([result intValue]== 1) {
                [MBProgressHUD showSuccess:@"修改成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }else{
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/postPosition.do"] params:params view:self.scrollView success:^(id json) {
        NSNumber *result = json[@"result"];
        if ([result intValue]== 1) {
            [MBProgressHUD showSuccess:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];}
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];// 1
    self.navigationController.navigationBarHidden = YES;
   
}

#pragma mark - textField.delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_departmentTextfield == textField) {
        [self deparPostShow];
        return NO;
    }
    
    if (_fronMoneyTextField == textField ) {
        _moneySalaryBut.selected = NO;
        [self fromToMoney:_fronMoneyTextField];
        return NO;
    }
    
    if (_toMoneyTextField == textField ) {
        _moneySalaryBut.selected = NO;
        [self fromToMoney:_toMoneyTextField];
        return NO;
    }
    
    if (_fromAgeTextField == textField ) {
        _ageSalaryBut.selected = NO;
        [self fromToMoney:_fromAgeTextField];
        return NO;
    }
    
    if (_toAgeTextField == textField ) {
        _ageSalaryBut.selected = NO;
        [self fromToMoney:_toAgeTextField];
        return NO;
    }
    
    if (_sexTextField == textField) {
        [self SelectSEX];
        return NO;
    }
    
    if (_workAgeTextField == textField) {
        [self SelectWORKEXPERIENCE];
        return NO;
    }
    
    if (_eduTextField == textField) {
        [self SelectEDU_BG];
        return NO;
    }
    
    if (_workAddTextField == textField) {
        [self getComAddr];
        return NO;
    }
    
    
    
    return YES;
}

#pragma mark -- uitextView.delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
 
    CGRect frame = textView.frame;
    
    CGFloat heights = self.view.frame.size.height;
    
    int offset = frame.origin.y + 42 - ( heights - 216.0-35.0);//键盘高度216

    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.view.frame.size.width;
    
    float height = self.view.frame.size.height;
    
    if(offset > 0)
        
    {
        
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        
        self.view.frame = rect;
        
    }
    
    [UIView commitAnimations];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self keyBshou];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self keyBshou];
    return YES;
}

- (UIImage *)saImageWithSingleColor:(UIColor *)color
{
    UIGraphicsBeginImageContext(CGSizeMake(1.0f, 1.0f));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * strNum = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([checktest evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)keyBshou
{
    [self.view endEditing:YES];
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

#pragma mark --- reP

- (void)getBoolData
{
    if (_boolPostOrRe) {
        _positionTextfield.text = _model.POSITIONNAME;
        _departmentTextfield.text = _model.DEPT_NAME;
        _human.text = _model.CONTACT;
        _phone.text = _model.ENT_PHONE;
        _numTextfield.text = [self strWithNum:_model.RECRUITING_NUM];
        if ([_model.MONTHLYPAY isEqualToString:@"面议"]) {
            self.moneySalaryBut.selected = YES;
        }else{
        _fronMoneyTextField.text = [self moneyWithNum:_model.SALARYMIN];
            _toMoneyTextField.text = [self moneyWithNum:_model.SALARYMAX];}
        if ([_model.AGE isEqualToString:@"不限"]) {
            self.ageSalaryBut.selected = YES;
        }else{
        _fromAgeTextField.text = [self strWithNum:_model.AGEMIN];
            _toAgeTextField.text = [self strWithNum:_model.AGEMAX];}
        _sexTextField.text = [self sexStrWithNum:_model.SEX];
        _workAgeTextField.text = _model.WORKEXPERIENCE;
        _eduTextField.text = _model.EDU_BG;
        _workAddTextField.text = _model.WORKADDR_NAME;
        _positionTextView.text = _model.DUTY;
        
        self.data.departmentID = _model.DEPT_ID;
        self.data.sexId = _model.SEX;
        self.data.WORKEXPERIENCE_ID = _model.WORKEXPERIENCE_ID;
        self.data.EDU_BG_ID = _model.EDU_BG_ID;
        self.data.workAddID = _model.WORK_ADDRESS_ID;
        
      
    }
}

- (NSString *)strWithNum:(NSNumber *)number
{
    return [NSString stringWithFormat:@"%@",number];
}

- (NSString *)moneyWithNum:(NSNumber *)number
{
    return [NSString stringWithFormat:@"%@000",number];
}

- (NSString *)sexStrWithNum:(NSNumber *)number
{
    switch ([number intValue]) {
        case 0:
            return @"不限";
            break;
        case 1:
            return @"男";
            break;
        case 2:
            return @"女";
            break;
            
        default:
            break;
    }
    return nil;
}

@end
