//
//  MajorityElement.h
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 求众数
 
 众数是指在数组中出现次数大于 n/2 的元素，比如 [2, 2, 1, 3, 2] 众数是 2
 */
@interface MajorityElement : NSObject

// 1. 第一种方法是排序，排序后最中间的元素肯定是众数， 这种和两层嵌套暴力查找效果差不多
+(NSNumber *)getMajorityElement1WithArr:(NSMutableArray *)arr;

// 2. 第二种是借助hash表，将遍历过的元素作为hash表的key，key出现的次数作为value，当value > n/2的时候，该key就是众数
// 时间复杂的O(N), 因为引入了哈希表，空间复杂度也是O(N) -- 这里是不考虑常数的，实际空间复杂度比这小
+(NSNumber *)getMajorityElement2WithArr:(NSMutableArray *)arr;

// 3. 摩尔投票法
// 摩尔投票法的原则很简单，就是每次拿出两个元素投票，如果两个元素不同，就把他们丢弃，如果相同就继续拿另外两个元素继续投票，
// 如果到最后数组为空，则表示没有元素的出现次数超过数组长度的一半，如剩下了某个元素，那它很可能是目标元素。
// 时间复杂度O(N), 空间复杂度O(1)
+(NSNumber *)getMajorityElement3WithArr:(NSMutableArray *)arr;

@end
