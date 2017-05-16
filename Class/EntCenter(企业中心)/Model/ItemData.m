//
//  ItemData.m
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "ItemData.h"

@implementation ItemData
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    ItemData *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}
@end
