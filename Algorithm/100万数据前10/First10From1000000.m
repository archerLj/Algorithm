//
//  First10From1000000.m
//  Algorithm
//
//  Created by ArcherLj on 2019/9/5.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "First10From1000000.h"
#import "BubbleSort.h"

@implementation First10From1000000

//+(NSArray *)frist10FromArr:(NSArray *)arr {
//    
//    NSMutableArray *result = [NSMutableArray array];
//    
//    NSInteger allNum = 0; // allNum的每一位表示一个数字，第几位有值就代表数字几
//    for (NSNumber *value in arr) {
//        NSInteger number = [value integerValue];
//        NSInteger temp = 1 << (number - 1); // 将1左到第number位，第几位就代表了数字几
//        allNum = allNum | temp; // 将新的数字合并进去
//    }
//    
//    NSInteger count = 0;
//    while (result.count < 10) {
//        NSInteger temp = 1 << count;
//        if ((allNum & temp) > 0) { // allNum和temp按位与，只要count位上allNum是1,那么结果就大于0，如果不为1，则结果为0
//            [result addObject:@(count + 1)];
//        }
//        count++;
//    }
//    return [result copy];
//}

/**
 这里取前10个最小数的话，先用前10个数建一个大顶堆。
 
 然后，遍历后面的数，只要比堆顶的元素小，就加入堆中，并调整堆；如果比堆顶元素大，则直接舍弃
 */
+(NSArray *)first10FromArrUseHeapInArr:(NSArray *)arr {
    // 1. 取前十个元素建大顶堆
    NSMutableArray *first10 = [[arr subarrayWithRange:NSMakeRange(0, 10)] mutableCopy];
    
    for (NSInteger i=0; i<first10.count; i++) {
        [First10From1000000 fixUpCurrentItemWithIndex:i inHeap:first10];
    }
    
    for (NSInteger j=10; j<arr.count; j++) {
        NSNumber *current = arr[j];
        if ([current integerValue] < [first10[0] integerValue]) { //如果元素比大顶堆的根节点小，就将其加入堆，并调整堆
            first10[0] = current;
            [First10From1000000 downFixUpWithCurrentIndex:0 inHeap:first10];
        }
    }
    
    [BubbleSort sortWithArr:first10];
    return [first10 copy];
}

// 从当前节点开始向下重新调整堆为大顶堆
+(void)downFixUpWithCurrentIndex:(NSInteger)currentIndex inHeap:(NSMutableArray *)arr {
    
    NSInteger leafChild = (currentIndex + 1) * 2 - 1;
    NSInteger rightChild = (currentIndex + 1) * 2;
    
    if (leafChild >= arr.count) { // 没有左孩子，说明没有子节点
        return;
    }
    
    if (rightChild >= arr.count) { // 没有右孩子
        if ([arr[currentIndex] integerValue] < [arr[leafChild] integerValue]) { // 比左孩子小，则交换他们，把左孩子作为当前节点重新调整
            [First10From1000000 swapItemAtIndex:currentIndex withIndexb:leafChild inArr:arr];
            [First10From1000000 downFixUpWithCurrentIndex:leafChild inHeap:arr];
        }
        
    } else {
        NSInteger maxInLeafARight = MAX([arr[leafChild] integerValue], [arr[rightChild] integerValue]);
        if ([arr[currentIndex] integerValue] < maxInLeafARight) { // 比左右孩子中最大的值小，则跟最大的那个交换，然后再从之前最大的孩子索引重新调整
            if ([arr[leafChild] integerValue] > [arr[rightChild] integerValue]) { // 左孩子大于右孩子，
                [First10From1000000 swapItemAtIndex:leafChild withIndexb:currentIndex inArr:arr];
                [First10From1000000 downFixUpWithCurrentIndex:leafChild inHeap:arr];
            } else {
                [First10From1000000 swapItemAtIndex:rightChild withIndexb:currentIndex inArr:arr];
                [First10From1000000 downFixUpWithCurrentIndex:rightChild inHeap:arr];
            }
        }
    }
}

// 从当前元素向上调整堆为大顶堆
+(void)fixUpCurrentItemWithIndex:(NSInteger)currentIndex inHeap:(NSMutableArray *)arr {
    if (currentIndex == 0) {
        return;
    }
    
    NSInteger parentIndex = (currentIndex + 1)/2 - 1; // 获取父节点索引
    
    if ([arr[currentIndex] integerValue] > [arr[parentIndex] integerValue]) { // 比父节点大，则交换它和父节点的值，并把父几点作为当前索引继续调整
        [First10From1000000 swapItemAtIndex:currentIndex withIndexb:parentIndex inArr:arr];
        [First10From1000000 fixUpCurrentItemWithIndex:parentIndex inHeap:arr];
    }
}

+(void)swapItemAtIndex:(NSInteger)indexa withIndexb:(NSInteger)indexb inArr:(NSMutableArray *)arr {
    NSNumber *temp = arr[indexa];
    arr[indexa] = arr[indexb];
    arr[indexb] = temp;
}

@end
