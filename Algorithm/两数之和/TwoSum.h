//
//  TwoSum.h
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TwoSum : NSObject

// 给定一个数组，和一个目标值target，找出数组中两个和为target的元素，以及他们的下标
+(void)twoSumWithArr:(NSArray *)arr target:(int)target;

@end

NS_ASSUME_NONNULL_END
