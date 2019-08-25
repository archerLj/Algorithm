//
//  MyPow.h
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 // 求x的n次方
 */

@interface MyPow : NSObject

// 1. 直接累乘
+(double)pow1WithX:(int)x n:(int)n;

// 2. 分治 + 递归
// 利用分治和递归将
// [x]的10次方 = [x * x] 的5次方
// [x]的11次方 = [x] * [x * x]的10次方
// 最终通过递归和分治，将 x的4次方变成 (10 * 10)的两次方，再变成 (100 * 100)的1次方
+(double)pow2WithX:(int)x n:(int)n;

// 3. 只用分治
+(double)pow3WithX:(int)x n:(int)n;

@end
