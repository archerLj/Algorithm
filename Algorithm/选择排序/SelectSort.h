//
//  SelectSort.h
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 虽然选择排序也是两层循环，但是内循环只是遍历后记录最小值的下标，并不是每次比较成功后都交换元素；而是在内层交换结束后
 才交换元素。所以交换元素的复杂的是O(N)，整体算法的复杂度是O(N²)，这就比冒泡排序效率高一点，必定冒泡排序是内层循环
 每次比较成功都交换元素，交换元素也是一定的开销
 */
@interface SelectSort : NSObject

+(void)sortWithArr:(NSMutableArray *)unSortedArr;

@end
