//
//  NSString+Reverse.m
//  Algorithm
//
//  Created by ArcherLj on 2019/9/6.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "NSString+Reverse.h"

@implementation NSString (Reverse)

-(NSString *)reverse {
    
    NSMutableString *temp = [self mutableCopy];
    
    NSUInteger left = 0;
    NSUInteger right = temp.length - 1;
    
    while (left < right) {
        
        NSString *leftStr = [temp substringWithRange:NSMakeRange(left, 1)];
        NSString *rightStr = [temp substringWithRange:NSMakeRange(right, 1)];
        
        [temp replaceCharactersInRange:NSMakeRange(left, 1) withString:rightStr];
        [temp replaceCharactersInRange:NSMakeRange(right, 1) withString:leftStr];
        
        left ++;
        right --;
    }
    
    return [temp copy];
}

@end
