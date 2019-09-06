//
//  QuickSort.h
//  Algorithm
//
//  Created by ArcherLj on 2019/8/30.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 快速排序
 
 通过一趟遍历，将数组分成两部分，一部分的值均比另一部分的值小。然后再对每个部分重新遍历分成大小不同的两部分。直到最后序列有序
 */
@interface QuickSort : NSObject

+(void)sortWithArr:(NSMutableArray *)unSortArr;

@end
