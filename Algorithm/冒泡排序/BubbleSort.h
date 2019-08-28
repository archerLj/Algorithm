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
 
 最坏时间复杂度O(N²)，最好时间复杂度是O(N)，这里的最好时间复杂度是需要借助一个标志位，当序列本身就是排好序的，只需要遍历一次即结束
 */
@interface BubbleSort : NSObject

+(void)sortWithArr:(NSMutableArray *)unSortedArr;

@end
