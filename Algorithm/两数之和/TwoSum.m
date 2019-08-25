//
//  TwoSum.m
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "TwoSum.h"

@implementation TwoSum

+(void)twoSumWithArr:(NSArray *)arr target:(int)target {
    
    NSMutableDictionary *res = [[NSMutableDictionary alloc] init];
    
    for (int i=0; i < arr.count; i++) {
        
        int other = target - [arr[i] intValue];
        
        NSString *key = [NSString stringWithFormat:@"%d", other];
        
        if ([res valueForKey:key]) {
            
            NSLog(@"%@ + %@ = %d", arr[i], key, target);
            NSLog(@"下标是: [%d, %@]", i, [res valueForKey:key]);
            
        } else {
            [res setObject:@(i) forKey:[NSString stringWithFormat:@"%@", arr[i]]];
        }
    }
}

@end
