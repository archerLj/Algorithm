//
//  Greedy.m
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "Greedy.h"

@implementation Greedy

+(void)chageWithArr:(NSArray *)arr {
    
    int five = 0;
    int ten = 0;
    
    for (int i=0; i<arr.count; i++) {
        
        int value = [arr[i] intValue];
        
        if (value == 5) {
            five ++;
            
        } else if (value == 10) {
            five --;
            if (five >= 0) {
                ten ++;
            } else {
                NSLog(@"不能正确找零");
                return;
            }
            
        } else if (value == 20) {
            if (ten > 0) {
                
                // 找一个10块的和5块的
                ten --;
                five --;
                
                if (five < 0) {
                    NSLog(@"不能正确找零");
                    return;
                }
                
            } else {
                
                // 找3个5块的
                if (five >= 3) {
                    five -= 3;
                } else {
                    NSLog(@"不能正确找零");
                    return;
                }
            }
        }
    }
    
    NSLog(@"正确找零");
}

+(void)candyWithRates:(NSArray *)rates {
    
    NSMutableArray *left = [[NSMutableArray alloc] init];
    NSMutableArray *right = [[NSMutableArray alloc] init];
    
    // 先假设所有孩子一开始都分1颗糖
    NSInteger count = rates.count;
    while (count > 0) {
        [left addObject:@(1)];
        [right addObject:@(1)];
        count --;
    }
    
    int sum = 0;
    
    // 先从左边遍历，得到最优解，如果右边的孩子比左边的孩子分数高，就让他的糖比左边的孩子多一个
    for (int i=1; i<rates.count; i++) {
        if ([rates[i] intValue] > [rates[i - 1] intValue]) {
            left[i] = @([left[i - 1] intValue] + 1);
        }
    }

    // 再从右边遍历，得到最优解，如果左边的孩子比右边的孩子分数高，就让他的糖比右边的孩子多一个
    // 取left和right结果中相同索引对应的最大值作为最优解
    for (NSInteger i = rates.count - 1; i>=0; i--) {
        if (i < rates.count - 1 && [rates[i] intValue] > [rates[i + 1] intValue]) {
            right[i] = @([right[i + 1] intValue] + 1);
        }
        
        sum += MAX([left[i] intValue], [right[i] intValue]);
    }
    
    NSLog(@"最少需要 %d 颗糖", sum);
}
@end
