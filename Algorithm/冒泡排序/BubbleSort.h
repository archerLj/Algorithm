//
//  BubbleSort.h
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 冒泡排序：
 
 两层循环便利，内层做比较，每次比较相邻的两个元素，如果比较成功就交换两个元素。直到外层遍历结束
 
 冒泡排序最差的时间复杂度是O(N²), 最好的时间复杂度是O(N)即一开始就是排好序的，当然算时间复杂度的话肯定是
 算最糟糕情况下的复杂度，所以冒泡排序的时间复杂度还是O(N²)
 */
@interface BubbleSort : NSObject

+(void)sortWithArr:(NSMutableArray *)unSortedArr;

@end
