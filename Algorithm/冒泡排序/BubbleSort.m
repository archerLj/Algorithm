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
    
    // 1. 外层从最后开始遍历
    for (unsigned long i = unSortedArr.count-1; i>0; i--) {
        
        // 2. 内层从0开始一直遍历到i，因为里面比较的是 [j] 和 [j+1]的值，所以这里 j<i 是界限
        for (int j=0; j<i; j++) {
            
            // 3. 如果 [j] 的值比 [j+1]的值大，就交换他们的位置，经过内层交换，最大的值就会交换到 [i]的位置
            if ([unSortedArr[j] intValue] > [unSortedArr[j + 1] intValue]) {
                NSNumber *temp = unSortedArr[j + 1];
                unSortedArr[j + 1] = unSortedArr[j];
                unSortedArr[j] = temp;
            }
        }
    }
    
    NSLog(@"排序后: %@", unSortedArr);
}

@end
