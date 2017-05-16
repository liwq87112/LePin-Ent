//
//  BusinessSearchView.m
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "BusinessSearchView.h"
#import "Global.h"
#import <QuartzCore/QuartzCore.h>
@interface BusinessSearchView ()
@property (weak, nonatomic) UITextField *searchField;
@end
@implementation BusinessSearchView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        UISearchBar  * SearchBar =[[UISearchBar  alloc]init];
        //SearchBar.placeholder=@"搜索职位,公司";
        _SearchBar=SearchBar;
        SearchBar.barStyle=UIBarStyleDefault;
        SearchBar.searchBarStyle=UISearchBarStyleDefault;
        SearchBar.layer.cornerRadius = 34/2.0;
        SearchBar.layer.masksToBounds = YES;
        
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
        
        
        UIButton *areaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _areaBtn=areaBtn;
        [areaBtn setTitle:@"地区"  forState:UIControlStateNormal];
        [areaBtn setTitleColor:LPFrontGrayColor forState:UIControlStateNormal];
        [areaBtn setTitleColor:LPUIMainColor forState:UIControlStateSelected];
        areaBtn.titleLabel.font=LPContentFont;
        //        [self addSubview:areaBtn];
        
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
    //    _areaBtn.frame=CGRectMake(10, 5,50, frame.size.height-10);
    _SearchBar.frame=CGRectMake(10, 5, frame.size.width-20, frame.size.height-10);
    
    [super setFrame:frame];
}

@end
