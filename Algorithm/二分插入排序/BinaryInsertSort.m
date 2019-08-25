//
//  BinaryInsertSort.m
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "BinaryInsertSort.h"

@implementation BinaryInsertSort

+(void)sortWithArr:(NSMutableArray *)arr {
    NSLog(@"排序前: %@", arr);
    
    int i, j;
    for (i=1; i<arr.count; i++) {
        
        if ([arr[i] intValue] < [arr[i - 1] intValue]) {
            
            NSNumber *temp = arr[i];
            
            int left = 0;
            int right = i;
            
            // 因为最后我们是要把left对应的位置插入
            // left和right相等的时候，也就是剩下最后一个元素和temp比较的时候，需要这种情况下来确定
            // left是+1还是不变；如果最后一个元素(下标即使left，也是right)大，那么当前left就是要插入的位置
            // 如果这个元素比temp小，插入的位置就在left的下一个，Left就得+1
            while (left <= right) {
                int mid = (left + right) / 2;
                if ([arr[mid] intValue] > [temp intValue]) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            
            // 最后将left以及后面的元素全部后移
            for (j=i; j > left; j--) {
                arr[j] = arr[j - 1];
            }
            arr[left] = temp;
        }
    }
    
    NSLog(@"排序后: %@", arr);
}

@end
