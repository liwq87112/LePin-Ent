//
//  QuickSearchHeadView.m
//  LePin
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntQuickSearchHeadView.h"
#import "Global.h"
#import <QuartzCore/QuartzCore.h>
@interface EntQuickSearchHeadView ()
@property (weak, nonatomic) UITextField *searchField;
@end
@implementation EntQuickSearchHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        UISearchBar  * SearchBar =[[UISearchBar  alloc]init];
        SearchBar.placeholder=@"搜索职位,公司";
        _SearchBar=SearchBar;
        SearchBar.barStyle=UIBarStyleDefault;
        SearchBar.searchBarStyle=UISearchBarStyleMinimal;
        //UIView *view=SearchBar.subviews[0];
        //view.backgroundColor=[UIColor whiteColor];
        //[view setImage:[UIImage imageNamed:@"我"]];

        
        SearchBar.layer.cornerRadius = 34/2.0;
        SearchBar.layer.masksToBounds = YES;
//        SearchBar.layer.borderWidth = 1;
//        SearchBar.layer.borderColor = [LPUIBorderColor CGColor];
        
        CGSize imageSize =CGSizeMake(50,50);
        UIGraphicsBeginImageContextWithOptions(imageSize,0, [UIScreen mainScreen].scale);
        [[UIColor colorWithRed:231/255.0 green:232/255.0 blue:234/255.0 alpha:1] set];
        UIRectFill(CGRectMake(0,0, imageSize.width, imageSize.height));
        UIImage *pressedColorImg =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
       // SearchBar.backgroundColor=[UIColor colorWithRed:231/255.0 green:232/255.0 blue:234/255.0 alpha:1];
        SearchBar.backgroundImage=pressedColorImg;
        [SearchBar setSearchFieldBackgroundImage:pressedColorImg forState:UIControlStateNormal];
        [SearchBar setImage:[UIImage imageNamed:@"搜索放大镜"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        UITextField *searchField = [SearchBar valueForKey:@"searchField"];
        if (searchField) {
            _searchField=searchField;
            searchField.font=LPContentFont;
            [searchField addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        }
        [self addSubview:SearchBar];
        
        

//        UIButton *SearchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [SearchBtn setTitleColor:LPFrontGrayColor forState:UIControlStateNormal];
//        [SearchBtn setTitle:@"搜索职位,公司" forState:UIControlStateNormal];
//        [SearchBtn setImage:[UIImage imageNamed:@"搜索放大镜"] forState:UIControlStateNormal];
//        SearchBtn.titleLabel.font=LPContentFont;
//        SearchBtn.layer.cornerRadius=34/2;
//        SearchBtn.layer.masksToBounds=YES;
//        SearchBtn.backgroundColor=[UIColor colorWithRed:231/255.0 green:232/255.0 blue:234/255.0 alpha:1];
//        //SearchBtn.backgroundColor=[UIColor whiteColor];
//        SearchBtn.contentMode=UIViewContentModeLeft;
//        _SearchBtn=SearchBtn;
//        [self addSubview:SearchBtn];
        

        
//        UIButton *areaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        _areaBtn=areaBtn;
//        [areaBtn setTitle:@"地区" forState:UIControlStateNormal];
//        [areaBtn setTitleColor:LPUIMainColor forState:UIControlStateNormal];
//        areaBtn.titleLabel.font=LPContentFont;
//        [self addSubview:areaBtn];
        
        UIButton *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn=closeBtn;
        [closeBtn setTitle:@"取消"  forState:UIControlStateNormal];
        [closeBtn setTitleColor:LPFrontGrayColor forState:UIControlStateNormal];
        closeBtn.titleLabel.font=LPContentFont;
        [self addSubview:closeBtn];
        
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
        if (_searchField.subviews.count>3) {
            UIImageView *imageView=_searchField.subviews[3];
            CGRect rect=imageView.frame;
            rect.origin.x=0;
            rect.origin.y=(_searchField.frame.size.height-21)/2;
            rect.size.height=21;
            rect.size.width=21;
            imageView.frame=rect;
            
        }
}
-(void)dealloc // ARC模式下
{
   [_searchField removeObserver:self forKeyPath:@"frame"];
}
-(void)setFrame:(CGRect)frame
{
    _SearchBar.frame=CGRectMake(10, 25, frame.size.width-60, frame.size.height-30);
    _closeBtn.frame=CGRectMake(CGRectGetMaxX(_SearchBar.frame), 20,50, frame.size.height-20);
    [super setFrame:frame];
}


@end
