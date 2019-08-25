//
//  BinaryInsertSort.h
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinaryInsertSort : NSObject

/**
 二分插入排序
 
 插入排序需要逐个的比较左侧有序队列来寻找合适位置
 二分查找的原理是
 现将left设为0, right设为i, 先获取left到right中间的一个索引 (right - left)/2 + left, 如果该索引位置元素比指定元素大，那么再将right设为当前索引，在找left和right中间的元素比较，一直到找到合适位置为止
 
 二分插入排序的查找范围是1/2, 1/4, 1/8，能够快速的找到插入的位置
 但是最终，还是要将适当位置之后的元素全部后移，这和插入排序是一样的，只是查找适当位置的速度比较快
 */

+(void)sortWithArr:(NSMutableArray *)arr;

@end
