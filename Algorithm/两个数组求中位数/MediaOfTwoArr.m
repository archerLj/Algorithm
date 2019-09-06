//
//  MediaOfTwoArr.m
//  Algorithm
//
//  Created by ArcherLj on 2019/9/4.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "MediaOfTwoArr.h"

@implementation MediaOfTwoArr

+(CGFloat)mediaInArr:(NSMutableArray *)arr1 andArr:(NSMutableArray *)arr2 {
    
    NSInteger count1 = arr1.count;
    NSInteger count2 = arr2.count;
    
    /**
     求中位数，只需要得到两个数组合并后中间的一个或者两个数字即可
     
     比如偶数情况下：一共14个数字，则中位数=（第7小数 + 第8小数）/2;
     奇数情况下：比如一共15个数字，则中位数 = 第8个小数；
     */
    
    // 根据两个数组的总个数，计算要得到的第k小数和第k+1小数
    NSInteger kMin = 0;
    if ((count1 + count2) % 2 == 0) {
        // 偶数情况下需要得到中间的两个数才能求的中位数，这里我们直接放到数组中
        kMin = (count1 + count2) / 2;
        NSMutableArray *result = [NSMutableArray array];
        [MediaOfTwoArr getKminAndK1minInArr:arr1
                                   withArr2:arr2
                        withLeftIndexOfArr1:0
                        withLeftIndexOfArr2:0
                                   withKmin:kMin
                                 withResult:result];
        return ([result[0] floatValue] + [result[1] floatValue]) / 2;
        
    } else {
        // 奇数情况下，只需要得到最中间的数就可以了
        kMin = (count1 + count2 + 1) / 2;
        return [MediaOfTwoArr getKminInArr:arr1
                           withArr2:arr2
                withLeftIndexOfArr1:0
                withLeftIndexOfArr2:0
                           withKmin:kMin];
    }
}

+(void)getKminAndK1minInArr:(NSMutableArray *)arr1
                withArr2:(NSMutableArray *)arr2
     withLeftIndexOfArr1:(NSInteger)arr1Left
     withLeftIndexOfArr2:(NSInteger)arr2Left
                withKmin:(NSInteger)kmin
                 withResult:(NSMutableArray *)result {
    
    if (arr1Left >= arr1.count) { // arr1已经遍历完，则直接从arr2当前索引开始取第kmin小数即可
        [result addObject:arr2[arr2Left + kmin - 1]]; // 第k小数
        [result addObject:arr2[arr2Left + kmin]]; // 第k + 1小数
        return;
    }
    
    if (arr2Left >= arr2.count) { // 同上
        [result addObject:arr1[arr1Left + kmin - 1]];
        [result addObject:arr1[arr1Left + kmin]];
        return;
    }
    
    if (kmin == 1) {
        // 当kin为1时，直接比较arr1和arr2当前索引的元素大小即可得到要求的小数
        if ([arr1[arr1Left] integerValue] <= [arr2[arr2Left] integerValue]) {
            [result addObject:arr1[arr1Left]]; // 第k小数
            
            // 如果arr1中只剩下第k小数了，那么k + 1小数一定在arr2中
            if (arr1Left == arr1.count - 1) {
                [result addObject:arr2[arr2Left]];
                
                // 否则继续比较arr1下一个元素和arr2的当前索引，得到第k + 1小数
            } else {
                if ([arr1[arr1Left + 1] integerValue] < [arr2[arr2Left] integerValue]) {
                    [result addObject:arr1[arr1Left + 1]];
                } else {
                    [result addObject:arr2[arr2Left]];
                }
            }
        } else {
            [result addObject:arr2[arr2Left]]; // 第k小数
            
            // 如果arr2中只剩下第k小数了，那么k + 1小数一定在arr1中
            if (arr2Left == arr2.count - 1) {
                [result addObject:arr1[arr1Left]];
                
                // 否则继续比较arr1下一个元素和arr2的当前索引，得到第k + 1小数
            } else {
                if ([arr2[arr2Left + 1] integerValue] < [arr1[arr1Left] integerValue]) {
                    [result addObject:arr2[arr2Left + 1]];
                } else {
                    [result addObject:arr1[arr1Left]];
                }
            }
        }
        
        return;
    }
    
    // 比较arr1和arr2 从当前索引开始的第kmin/2个元素大小，这里向下取整
    NSInteger removeCount = kmin / 2;
    
    // 第kmin/2个元素超出arr1的范围，则将removeCount直接设为arr1剩余元素的个数
    if (removeCount + arr1Left > arr1.count) {
        removeCount = arr1.count - arr1Left;
    } else if (removeCount + arr2Left > arr2.count) { // 同上
        removeCount = arr2.count - arr2Left;
    }
    
    if ([arr1[removeCount + arr1Left - 1] integerValue] <= [arr2[removeCount + arr2Left - 1] integerValue]) {
        // arr1比较小,将arr1Left右移继续递归
        arr1Left = arr1Left + removeCount;
    } else {
        // arr2比较小，将arr2Left右移继续递归
        arr2Left = arr2Left + removeCount;
    }
    
    return [MediaOfTwoArr getKminAndK1minInArr:arr1
                                      withArr2:arr2
                           withLeftIndexOfArr1:arr1Left
                           withLeftIndexOfArr2:arr2Left
                                      withKmin:kmin - removeCount
                                    withResult:result];
}

+(NSInteger)getKminInArr:(NSMutableArray *)arr1
           withArr2:(NSMutableArray *)arr2
withLeftIndexOfArr1:(NSInteger)arr1Left
withLeftIndexOfArr2:(NSInteger)arr2Left
           withKmin:(NSInteger)kmin {
    
    // arr1已经遍历完，则直接从arr2当前索引开始取第kmin小数即可
    if (arr1Left >= arr1.count) {
        return [arr2[arr2Left + kmin - 1] integerValue];
    }
    
    if (arr2Left >= arr2.count) { // 同上
        return [arr1[arr1Left + kmin - 1] integerValue];
    }
 
    // 当kin为1时，直接比较arr1和arr2当前索引的元素大小即可得到要求的小数
    if (kmin == 1) {
        if ([arr1[arr1Left] integerValue] <= [arr2[arr2Left] integerValue]) {
            return [arr1[arr1Left] integerValue];
        } else {
            return [arr2[arr2Left] integerValue];
        }
    }
        
    // 比较arr1和arr2 从当前索引开始的第kmin/2个元素大小
    NSInteger removeCount = kmin / 2;
    
    // 第kmin/2个元素超出arr1的范围，则将removeCount直接设为arr1剩余元素的个数
    if (removeCount + arr1Left > arr1.count) {
        removeCount = arr1.count - arr1Left;
    } else if (removeCount + arr2Left > arr2.count) { // 同上
        removeCount = arr2.count - arr2Left;
    }
    
    if ([arr1[removeCount + arr1Left - 1] integerValue] <= [arr2[removeCount + arr2Left - 1] integerValue]) {
        // arr1比较小,将arr1Left右移继续递归
        arr1Left = arr1Left + removeCount;
    } else {
        // arr2比较小，将arr2Left右移继续递归
        arr2Left = arr2Left + removeCount;
    }
    
    return [MediaOfTwoArr getKminInArr:arr1
                     withArr2:arr2
          withLeftIndexOfArr1:arr1Left
          withLeftIndexOfArr2:arr2Left
                     withKmin:kmin - removeCount];
}

@end
