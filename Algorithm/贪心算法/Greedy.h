//
//  Greedy.h
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Greedy : NSObject

// 例子1: 这里假设有一队顾客排队买奶茶，奶茶的价格是5块，顾客手里有5块的，10块的，20块的三种币值的人民币
// 假如一开始你手中没有零钱，根据顾客手中币值的不同，求最后能不能正确找零.
// 比如: [5, 5, 10] 可以正确找零  [5, 10, 10, 5]不能正确找零
+(void)chageWithArr:(NSArray *)arr;


// 例子2: 老师给一队小朋友打分，然后分糖，要求是，相邻的两个小朋友，分数高的一定要比分数低的糖多。问：老师最少要准备多少糖
// 比如：小朋友分数是[1, 0, 2], 则最少要5颗糖 [2, 1, 2]
//      小朋友分数是[1, 2, 2], 则最少要4颗糖 [1, 2, 1], 因为最后一个孩子旁边的孩子和他分数一样，
//                                                 所以他不要求比他旁边的多，我们这里只计算相对最优解，
//                                                 不考虑全局最优解
+(void)candyWithRates:(NSArray *)rates;

@end
