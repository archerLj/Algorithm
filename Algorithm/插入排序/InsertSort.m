//
//  InsertSort.m
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "InsertSort.h"

@implementation InsertSort

+(void)sortArr:(NSMutableArray *)arr {
    
    NSLog(@"排序前： %@", arr);
    
    int i, j;
    
    // 先遍历右侧队列，依次拿出一个元素， 如果这个元素比左侧排好序的最后一个元素，也就是它的上一个元素
    // 小的话，就遍历左侧排好序的队列，将这个值插入到指定位置
    for (i=1; i<arr.count; i++) {
        
        if ([arr[i] intValue] < [arr[i - 1] intValue]) {
            
            int temp = [arr[i] intValue];
            
            /**
             
            1 2 4 5 | 3 7 // 把3拿出来插入到前面的有序队列， 先将3单独保存
            1 2 4 5 | 5 7 // 1. 5比3大，把5后移，这里把5后面一个元素设为5
            1 2 4 4 | 5 7 // 2. 4比3大，把4后移，这里把4后面一个元素设为4
            1 2 3 4 5 | 7 // 3. 2比3小，找到合适位置，将3放入第三个位置，也就是4原来的位置
             
             */
            for (j = i; j > 0; j--) { // 遍历左侧有序队列，将该值插入到适当位置
                if ([arr[j - 1] intValue] > temp) { // 如果元素比该数大，将该数向后移动
                    arr[j] = arr[j - 1];
                } else { // 找到合适的位置
                    break;
                }
            }
            
            arr[j] = @(temp);
        }
    }
    
    NSLog(@"排序后： %@", arr);
}

@end
