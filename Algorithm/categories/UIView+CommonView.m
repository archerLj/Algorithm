//
//  UIView+CommonView.m
//  Algorithm
//
//  Created by archerLj on 2019/8/25.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "UIView+CommonView.h"

@implementation UIView (CommonView)

-(UIView *)commonViewWith:(UIView *)view {
    
    NSMutableSet *superViewSet = [NSMutableSet set];
    
    UIView *superView = [self superview];
    while (superView != nil) {
        [superViewSet addObject:superView];
        superView = superView.superview;
    }
    
    superView = view.superview;
    Boolean found = NO;
    while (!found) {
        if ([superViewSet containsObject:superView]) {
            found = YES;
        } else {
            superView = superView.superview;
        }
    }
    
    return superView;
}

@end
