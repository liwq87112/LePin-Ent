
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface THScrollViewFollowTableView : NSObject
@property (nonatomic,assign)BOOL bounces; //反弹效果默认YES
//利用initRoot创建 给予底部上下滑动的ScrollView 要滑动的ScrollRange 大小和左右滑动的Table数组
- (instancetype)initRootScrollView:(UIScrollView *)rootScrollView AndRootScrollViewScrollRange:(CGFloat)scrollRange AndTableArray:(NSArray *)tableArray;
//在scrollViewDidScroll代理里调用此方法传入滑动的scrollView
- (void)followScrollViewScrollScrollViewScroll:(UIScrollView *)scrollView;
@end
