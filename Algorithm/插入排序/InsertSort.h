//
//  InsertSort.h
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsertSort : NSObject

/**
 插入排序
 
 插入排序的思想是：给定一个队列，假定把这个队列分成了两个队列，左边是排好序的队列，右边是未排序的队列
 每次从未排序的队列中拿出一个元素插入到排好序的队列中，并且是按照大小顺序插入到适当位置。
 比如: 1, 4, 2, 5, 3
 
 第一步： 1 | 4 2 5 3 //先把第一个元素当作已经排好序的队列
 第二步： 1 4 | 2 5 3 // 拿出4， 遍历左边队列，将4插入到适当位置
 第三步： 1 2 4 | 5 3 // 拿出2， 遍历左边队列，将2 插入到适当位置
 第四步： 1 2 3 4 | 5
 最后： 1 2 3 4 5
 */

+(void)sortArr:(NSMutableArray *)arr;

@end
