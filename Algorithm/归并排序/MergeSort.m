//
//  MergeSort.m
//  Algorithm
//
//  Created by ArcherLj on 2019/8/28.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "MergeSort.h"

@implementation MergeSort

+(void)sortWithArr:(NSMutableArray *)unSortedArr {
    if (unSortedArr == nil || unSortedArr.count < 2) {
        return;
    }
    
    NSLog(@"排序前： %@", unSortedArr);
    [MergeSort mergeSortWithArr:unSortedArr l:0 r:unSortedArr.count - 1];
    NSLog(@"排序后： %@", unSortedArr);
}

+(void)mergeSortWithArr:(NSMutableArray *)arr l:(NSInteger)l r:(NSInteger)r {
    // 直到分割到单个元素为止
    if (l == r) {
        return;
    }

    // 将数组一半一半的分割
    NSInteger mid = (l + r) / 2;
    [MergeSort mergeSortWithArr:arr l:l r:mid];
    [MergeSort mergeSortWithArr:arr l:mid + 1 r:r];
    
    // 分割完之后，合并两个数组（这里其实是通过左中右三个索引划分成了两个数组）
    [MergeSort mergeWithArr:arr l:l mid:mid r:r];
}

// 合并两个有序数组
+(void)mergeWithArr:(NSMutableArray *)arr l:(NSInteger)l mid:(NSInteger)mid r:(NSInteger)r {

    NSMutableArray *help = [NSMutableArray array];
    NSInteger p1 = l;
    NSInteger p2 = mid + 1;

    // 依次比较从最左侧索引和从中间索引开始的两个元素，并把最小的放入结果数组中
    while (p1 <= mid && p2 <= r) {
        NSNumber *minValue = [arr[p1] intValue] <= [arr[p2] intValue] ? arr[p1 ++] : arr[p2++];
        [help addObject:minValue];
    }

    // 将剩余的数加入到数组中
    while (p1 <= mid) {
        [help addObject:arr[p1 ++]];
    }

    while (p2 <= r) {
        [help addObject:arr[p2 ++]];
    }

    // 将临时数组中的内容覆盖掉原数组中内容
    for (int i=0; i<help.count; i++) {
        arr[l + i] = help[i];
    }
}

@end
