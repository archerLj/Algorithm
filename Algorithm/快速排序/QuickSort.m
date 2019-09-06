//
//  QuickSort.m
//  Algorithm
//
//  Created by ArcherLj on 2019/8/30.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "QuickSort.h"

@implementation QuickSort

+(void)sortWithArr:(NSMutableArray *)unSortArr {
    
    NSLog(@"排序前: %@", unSortArr);
    
    NSInteger right = unSortArr.count - 1;
    [QuickSort sortArr:unSortArr withLeft:0 right:right];
    
    NSLog(@"排序后: %@", unSortArr);
}

+(void)sortArr:(NSMutableArray *)arr withLeft:(NSInteger)left right:(NSInteger)right {
    
    // 如果左边索引大于等于右边的索引就代表已经整理完成一个组了
    if (left > right) {
        return;
    }
    
    NSInteger i = left;
    NSInteger j = right;
    NSInteger key = [arr[left] integerValue];
    
    // 在当前组中遍历一遍
    while (i < j) {
        // 先从小数组的右边往左边找，找到第一个比key小的值
        while (i < j && key <= [arr[j] integerValue]) {
            // 向前寻找
            j --;
        }
        
        // 把这个比key小的数和key交换，现在key的索引是i
        [QuickSort swapItemAtIndex:i withIndex:j inArr:arr];
        
        // 再从左往右找，找到第一个比key大的值
        while (i < j && key >= [arr[i] integerValue]) {
            i ++;
        }
        
        // 把这个比key大的值和key交换，现在key的索引是j;
        [QuickSort swapItemAtIndex:j withIndex:i inArr:arr];
    }
    
    // 递归： 遍历左边的小数组
    [QuickSort sortArr:arr withLeft:left right:i - 1];
    
    // 递归： 遍历右边的小数组
    [QuickSort sortArr:arr withLeft:i + 1 right:right];
}

+(void)swapItemAtIndex:(NSInteger)indexa withIndex:(NSInteger)indexB inArr:(NSMutableArray *)arr {
    NSNumber *temp = arr[indexa];
    arr[indexa] = arr[indexB];
    arr[indexB] = temp;
}

@end
