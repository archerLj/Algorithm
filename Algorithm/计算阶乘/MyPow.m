//
//  MyPow.m
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "MyPow.h"

@implementation MyPow

+(double)pow1WithX:(int)x n:(int)n {
    
    double res = 1;
    
    if (n < 0) { // 如果阶乘是负数，就直接将x变成分数，求分数的正的阶乘
        x = 1/x;
        n = -n;
    }
    
    if (x == 1) return 1;
    if (x == -1) return n%2 == 0 ? 1 : -1;
    
    for (int i=0; i<n; i++) {
        res *= x;
    }
    
    return res;
}

+(double)pow2WithX:(int)x n:(int)n {
    
    if (n == 0 || x == 1) return 1;
    
    if (n < 0) return 1/ [MyPow pow2WithX:x n:-n];
    
    if (n % 2 == 0) {
        return [MyPow pow2WithX:x * x n:n/2]; // floor函数是想下取整
    } else {
         return x * [MyPow pow2WithX:x * x n:(n-1)/2];
    }
}

+(double)pow3WithX:(int)x n:(int)n {
    
    if (n < 0) {
        x = 1/x;
        n = -n;
    }
    
    double res = 1;
    while (n) {
        
        if (n % 2) {
            res *= x;
        }
        
        x *= x;
        
        // 这里因为用floor向下取整了，所以会落下一个x，所以一开始我们判断如果n不能被2整除，我们就
        // 先将res * x，这样拉下的x也被乘进去了。这样，我们就将n每次都一分为二，而每次一分为二之前
        // 我们都将x 变成了x * x； 相当于之前说的
        // [x]的10次方 = [x * x]的5次方
        // [x]的11次方 = x * [x * x]的5次方
        // 一直到最后，n变成1，这时候res里累乘了所有由于n向下取整落下的x，而x则是其他所有x的累乘
        n = floor(n/2);
    }
    
    return res;
}
@end
