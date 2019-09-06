//
//  ShellSort.h
//  Algorithm
//
//  Created by ArcherLj on 2019/8/30.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 希尔排序
 
 希尔排序是插入排序的改进版。插入排序在小规模数据或者基本有序时十分高效；在数据规模较大且无序时效率低下。
 
 而希尔排序就是为此而生的
 */
@interface ShellSort : NSObject

+(void)sortWithArr:(NSMutableArray *)unSortedArr;

@end
