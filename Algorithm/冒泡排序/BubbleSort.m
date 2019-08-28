//
//  BubbleSort.m
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "BubbleSort.h"

@implementation BubbleSort

+(void)sortWithArr:(NSMutableArray *)unSortedArr {
    NSLog(@"排序前: %@", unSortedArr);
    
    BOOL didSwap;
    for (NSInteger i=unSortedArr.count-1; i>0; i--) {
        
        didSwap = NO;
        
        for (NSInteger j=0; j<i; j++) {
            if ([unSortedArr[j] intValue] > [unSortedArr[j + 1] intValue]) {
                NSNumber *temp = unSortedArr[j];
                unSortedArr[j] = unSortedArr[j + 1];
                unSortedArr[j + 1] = temp;
                didSwap = YES;
            }
        }
        
        if (!didSwap) {
            break;
        }
    }
    
    NSLog(@"排序后: %@", unSortedArr);
}

@end
