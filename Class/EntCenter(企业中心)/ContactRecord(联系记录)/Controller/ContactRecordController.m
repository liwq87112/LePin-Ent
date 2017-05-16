//
//  ContactRecordController.m
//  LePin-Ent
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "ContactRecordController.h"
#import "ContactRecordCell.h"
#import "ContactRecordData.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
@interface ContactRecordController ()
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, assign)NSInteger PAGE;
@property (nonatomic, assign)NSInteger QUANTITY;
@property (nonatomic, assign)NSInteger model;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, strong)NSMutableDictionary *params;
@end

@implementation ContactRecordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _PAGE=1;
    _QUANTITY=10;
    self.navigationItem.title=@"联系记录";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self ContactRecordData];
     [self setupFooter];
}

-(void)GetMoreData
{
    NSInteger num=_data.count;
    if(num%_QUANTITY){_PAGE=num/_QUANTITY+2;}else{_PAGE=num/_QUANTITY+1;}
    _params[@"PAGE"] = [NSNumber numberWithInteger:_PAGE];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/contactRecordList.do?"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray *array=[json objectForKey:@"CONTACT_RECORD_LIST"];
         if(1==[result intValue])
         {
             if (array.count)
             {
                 NSMutableArray *datas=[[NSMutableArray alloc]init];
                 for (NSDictionary * dict in array)
                 {
                     ContactRecordData *data= [ContactRecordData CreateWithDict:dict];
                     [datas addObject:data];
                 }
                 [_data addObjectsFromArray:datas];
                 [self.tableView reloadData];
             }
             else
             {
                 [MBProgressHUD showError:@"没数据了"];
             }
         }
         [_refreshFooter endRefreshing];
     } failure:^(NSError *error)
     {
         [_refreshFooter endRefreshing];
     }];
}
- (void)ContactRecordData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (ENT_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
    params[@"ENT_ID"] = ENT_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_CONTACT_RECORD_LIST"];
    _params=params;
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/contactRecordList.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray *array=[json objectForKey:@"CONTACT_RECORD_LIST"];
         NSMutableArray *datas=[[NSMutableArray alloc]init];
         if(1==[result intValue])
         {
             for (NSDictionary *dict in array) {
                 ContactRecordData *data= [ContactRecordData CreateWithDict:dict];
                 [datas addObject:data];
             }
             _data =datas;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
        // [MBProgressHUD showError:@"网络连接失败"];
     }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactRecordCell * cell= [tableView dequeueReusableCellWithIdentifier:@"ContactRecordCell"];
    if (cell==nil) {
        cell=[[ContactRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ContactRecordCell"];
        [cell.PHONE addTarget:self action:@selector(OpenContactPHONE:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.PHONE.tag=indexPath.row;
    cell.data= _data[indexPath.row];
    return cell;
}

-(void)OpenContactPHONE:(UIButton *)btn
{
    ContactRecordData *data=_data[btn.tag];
    if (data.PHONE==nil)
    {
        [MBProgressHUD showError:@"企业号码为空"];
        return;
    }
    NSString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",data.PHONE];
    UIWebView * callWebview = [[UIWebView alloc] init];
    //_callWebview=callWebview;
    [self.view addSubview:callWebview];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
}
- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    [refreshFooter addToScrollView:self.tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}

- (void)footerRefresh
{
    [self GetMoreData];
}
-(void)dealloc
{
    [_refreshFooter free];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
