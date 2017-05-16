//
//  BasicInfoTableViewController.m
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "BasicInfoTableViewController.h"
#import "BasicInfoDataFrame.h"
#import "BasicInfoData.h"
#import "CompanyImageTableViewCell.h"
#import "BasicInfoTitleCell.h"
#import "MultilineTextInputViewController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "HeadFront.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "HeadFront.h"
@interface BasicInfoTableViewController ()
@property (nonatomic, strong)BasicInfoDataFrame *data;
@end

@implementation BasicInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector (Save)];
    [[self navigationItem] setTitle:@"企业基本资料"];
    [self GetCompanyData];
}
-(void)Save
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (ENT_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
    params[@"ENT_ID"] = ENT_ID;
    if (_data.data.ENT_ABOUT==nil){params[@"ENT_ABOUT"] = @"";}
    else{params[@"ENT_ABOUT"] = _data.data.ENT_ABOUT;}
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"E_ENT_INFO"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editEntInfo.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [MBProgressHUD showSuccess:@"保存成功"];
         }
     } failure:^(NSError *error)
     {
       //  [MBProgressHUD showError:@"网络连接失败"];
     }];

}
- (void)GetCompanyData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (ENT_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
    params[@"ENT_ID"] = ENT_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_INFO"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getEnt.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
            _data = [BasicInfoDataFrame CreateWithDict:json];
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
         //[MBProgressHUD showError:@"网络连接失败"];
     }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=0;
    switch (indexPath.section)
    {
        case 0:
            height=_data.ENT_NAME.size.height;
            break;
        case 1:
            height=_data.INDUSTRYCATEGORY_NAME.size.height;
            break;
        case 2:
            height=_data.INDUSTRYNATURE_NAME.size.height;
            break;
        case 3:
            height=_data.ENT_ABOUT.size.height;
            break;
        case 4:
            height=_data.LICENSE_PHOTO.size.height;
            break;
        default:
            break;
    }
    return height+10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * Cell;
    CompanyImageTableViewCell * ImageCell;
    BasicInfoTitleCell * TitleCell;
    switch (indexPath.section) {
        case 0:
           TitleCell= [[BasicInfoTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BasicInfoTitleCell"];
           TitleCell.Title.font=LPTitleFont;
          TitleCell.Title.text=_data.data.ENT_NAME;
            Cell=TitleCell;
            break;
        case 1:
            TitleCell= [[BasicInfoTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BasicInfoTitleCell"];
            TitleCell.Title.font=LPTitleFont;
            TitleCell.Title.text=_data.data.INDUSTRYCATEGORY_NAME;
            Cell=TitleCell;
            break;
        case 2:
            TitleCell= [[BasicInfoTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BasicInfoTitleCell"];
            TitleCell.Title.font=LPTitleFont;
            TitleCell.Title.text=_data.data.INDUSTRYNATURE_NAME;
            Cell=TitleCell;
            break;
        case 3:
            TitleCell= [[BasicInfoTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BasicInfoTitleCell"];
            TitleCell.Title.font=LPContentFont;
            TitleCell.Title.text=_data.data.ENT_ABOUT;
            Cell=TitleCell;
            break;
        case 4:
            ImageCell= [[CompanyImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CompanyImageTableViewCell"];
            [ImageCell.Image setImageWithURL:[NSURL URLWithString:_data.data.LICENSE_PHOTO] placeholderImage:[UIImage imageNamed:@"企业logo默认图"]];
            Cell=ImageCell;
            break;
            
        default:
            break;
    }
    return Cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect bounds= self.view.bounds;
    UIView *HeaderView;
    UILabel * title;
    HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 40)];
    HeaderView.backgroundColor = [UIColor clearColor];
    title  = [[UILabel alloc]init];
    title.font=LPTitleFont;
    title.backgroundColor = [UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1.0];
    title.layer.cornerRadius = 5;
    title.layer.masksToBounds = YES;
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentLeft;
    [HeaderView addSubview:title];
    switch (section)
    {
        case 0:
            title.text=@"企业名称:";
            break;
        case 1:
            title.text=@"行业类别:";
            break;
        case 2:
            title.text=@"行业性质:";
            break;
        case 3:
            title.text=@"企业简介:";
            break;
        case 4:
            title.text=@"营业执照图片:";
            break;
        default:
            break;
    }
    title.frame=CGRectMake(10, 0, [title.text sizeWithFont:LPTitleFont].width+10, 30);
    return HeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3)
    {
        MultilineTextInputViewController* vc=[[MultilineTextInputViewController alloc]initWithPlaceholder:@"请输入公司简介" andTitle:@"公司简介" andContent:_data.data.ENT_ABOUT CompleteBlock:^(NSString *backText)
                                              {
                                                  _data.data.ENT_ABOUT=backText;
                                                  [_data setDataFrame];
                                                  [self.tableView reloadData];
                                              }];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
