//
//  ShellSort.m
//  Algorithm
//
//  Created by ArcherLj on 2019/8/30.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "ShellSort.h"

@implementation ShellSort

+(void)sortWithArr:(NSMutableArray *)unSortedArr {
    
    NSLog(@"排序前: %@", unSortedArr);
    
    NSInteger len = unSortedArr.count;
    
    // 进行分组，最开始的增量(gap)为数组长度的一半
    for (NSInteger gap = len/2; gap > 0; gap /= 2) {
        
        // 对各个分组进行插入排序
        for (NSInteger i=gap; i<len; i+=gap) {
            
            // 将a[i]插入到所在分组正确的位置上
            [ShellSort insertItemAtIndex:i withGap:gap intoArr:unSortedArr];
        }
    }
    
    NSLog(@"排序后: %@", unSortedArr);
}

+(void)insertItemAtIndex:(NSInteger)i withGap:(NSInteger)gap intoArr:(NSMutableArray *)arr {
    
    NSInteger inserted = [arr[i] integerValue];
    NSInteger j;
    
    // 插入的时候按组进行插入（组内元素两两相隔gap）
    for (j = i-gap; j >= 0 && inserted < [arr[j] integerValue]; j -= gap) {
        arr[j + gap] = arr[j];
    }
    
    arr[j + gap] = @(inserted);
}

@end
