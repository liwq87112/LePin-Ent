
#import "THScrollViewFollowTableView.h"
@interface THScrollViewFollowTableView ()
@property (nonatomic,assign)BOOL canScroll;
@property (nonatomic,assign)BOOL rootCanScroll;
@property (nonatomic,assign)BOOL isTopIsCanNotMoveTabView;
@property (nonatomic,assign)BOOL isTopIsCanNotMoveTabViewPre;
@property (nonatomic,strong)NSArray *tableArray;
@property (nonatomic,strong)UIScrollView *rootScrollView;
@property (nonatomic,assign)CGFloat scrollRange;
@end
@implementation THScrollViewFollowTableView
- (instancetype)initRootScrollView:(UIScrollView *)rootScrollView AndRootScrollViewScrollRange:(CGFloat)scrollRange AndTableArray:(NSArray *)tableArray{
    if (self = [super init]) {
        self.rootScrollView = rootScrollView;
        self.tableArray = tableArray;
        self.scrollRange = scrollRange;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"goTop" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsgRootScrollViewAction:) name:@"leaveTopRoot" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
        self.bounces = YES;
    }
    return self;
}
- (void)setBounces:(BOOL)bounces {
    _bounces = bounces;
    if (_bounces == NO) {
        self.rootScrollView.bounces = NO;
    }
}
-(void)acceptMsgRootScrollViewAction:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _rootCanScroll = YES;
    }
}
-(void)acceptMsg:(NSNotification *)notification{
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:@"goTop"]) {
        NSDictionary *userInfo = notification.userInfo;
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
        }
    }else if([notificationName isEqualToString:@"leaveTop"]){
        for (UIScrollView *table in self.tableArray) {
            table.contentOffset = CGPointZero;
        }
        self.canScroll = NO;
    }
}
- (void)followScrollViewScrollScrollViewScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rootScrollView]) {
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat tabOffsetY = self.scrollRange;
        _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
        if (offsetY == tabOffsetY) {
            scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            _isTopIsCanNotMoveTabView = YES;
        }else{
            _isTopIsCanNotMoveTabView = NO;
        }
        if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
            if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
                _rootCanScroll = NO;
            }
            if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
                if (!_rootCanScroll) {
                    scrollView.contentOffset = CGPointMake(0, tabOffsetY);
                }
            }
        }
    }
    BOOL isTable = NO;
    for (id table in self.tableArray) {
        if ([scrollView isEqual:table]) {
            isTable = YES;
        }
    }
    if (isTable) {
        if (!self.canScroll) {
            [scrollView setContentOffset:CGPointZero];
        }
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY < 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil userInfo:@{@"canScroll":@"1"}];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTopRoot" object:nil userInfo:@{@"canScroll":@"1"}];
        }
        if (self.bounces == NO) {
            if (scrollView.contentSize.height - scrollView.bounds.size.height > 0) {
                if (offsetY >= (scrollView.contentSize.height - scrollView.bounds.size.height)) {
                    CGPoint offset = scrollView.contentOffset;
                    offset.y = scrollView.contentSize.height - scrollView.bounds.size.height;
                    scrollView.contentOffset = offset;
                }
            }else {
                [scrollView setContentOffset:CGPointZero];
            }
        }
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
