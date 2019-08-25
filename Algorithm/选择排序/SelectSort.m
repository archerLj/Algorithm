//
//  SelectSort.m
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "SelectSort.h"

@implementation SelectSort

+(void)sortWithArr:(NSMutableArray *)unSortedArr {
    
    NSLog(@"排序前: %@", unSortedArr);
    
    for (int i=0; i<unSortedArr.count; i++) {
        int minIndex = i;
        for (int j=i+1; j<unSortedArr.count; j++) {
            if ([unSortedArr[j] intValue] < [unSortedArr[minIndex] intValue]) {
                minIndex = j;
            }
        }
        
        if (minIndex != i) {
            NSNumber *temp = unSortedArr[minIndex];
            unSortedArr[minIndex] = unSortedArr[i];
            unSortedArr[i] = temp;
        }
    }
    
    NSLog(@"排序后: %@", unSortedArr);
}

@end
