//
//  MajorityElement.m
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "MajorityElement.h"

@implementation MajorityElement

+(NSNumber *)getMajorityElement1WithArr:(NSMutableArray *)arr {
    
    [arr sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 intValue] - [obj2 intValue];
    }];
    
    return arr[arr.count/2];
}

+(NSNumber *)getMajorityElement2WithArr:(NSMutableArray *)arr {
    
    NSMutableDictionary *hashTable = [[NSMutableDictionary alloc] init];
    
    for (NSNumber *item in arr) {
        NSString *key = [NSString stringWithFormat:@"%@", item];
        if ([hashTable valueForKey:key] == nil) {
            [hashTable setValue:@(1) forKey:key];
            
        } else {
            NSNumber *newValue = @([[hashTable valueForKey:key] integerValue] + 1);
            if ([newValue intValue] > arr.count/2) {
                return item;
            }
            [hashTable setValue:newValue forKey:key];
        }
    }
    
    return nil;
}

+(NSNumber *)getMajorityElement3WithArr:(NSMutableArray *)arr {
    
    int count = 1; // 用count记录众数出现的次数
    NSNumber *res = arr[0]; // 这里，我们假设第一个元素就是众数
    
    for (unsigned long i = 1; i < arr.count; i++) {
        if (arr[i] == res) { // 如果该元素和众数一样，众数个数加一
            count ++;
            if (count > arr.count/2) {
                return res;
            }
        } else {
            count --; // 如果该元素和我们指定的众数不一样，众数个数-1
            if (count == 0) {
                // 如果众数的个数==0了， 这里就表示当前这个元素和前面一个元素（可能是众数，也可能不是）不一样，
                // 我们就丢弃它，同时丢弃我们之前假定的众数，然后重新指定众数和出现次数，重新投票
                res = arr[i];
                count = 1;
            }
        }
    }
    return res;
    
}

@end
