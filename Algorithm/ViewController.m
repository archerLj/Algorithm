//
//  ViewController.m
//  Algorithm
//
//  Created by archerLj on 2019/8/18.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "ViewController.h"
#import "SelectSort.h"
#import "BubbleSort.h"
#import "MajorityElement.h"
#import "MyPow.h"
#import "TwoSum.h"
#import "Greedy.h"
#import "UIView+CommonView.h"
#import "InsertSort.h"
#import "BinaryInsertSort.h"
#import "RBTree.h"
#import "MergeSort.h"
#import "ShellSort.h"
#import "QuickSort.h"
#import "SearchBTree.h"
#import "List.h"
#import "First10From1000000.h"
#import "MediaOfTwoArr.h"
#import "NSString+Reverse.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *unSortedArr;
@property (nonatomic, strong) NSMutableArray *majorityElementArr;
@property (nonatomic, strong) RBTree *demoRBTree;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self dataInit];
//
//    NSMutableArray *numberOf1000000 = [NSMutableArray array];
//    for (NSInteger i=1; i<=100; i++) {
//        NSInteger num = 1 + arc4random() % 100;
//        [numberOf1000000 addObject:@(num)];
//    }
    
//    NSLog(@"%f", [[NSDate date] timeIntervalSinceReferenceDate]);
//    NSArray *result = [First10From1000000 frist10FromArr:[numberOf1000000 copy]];
//    NSLog(@"%@", result);
//    NSLog(@"%f", [[NSDate date] timeIntervalSinceReferenceDate]);
    
    
//    NSLog(@"%f", [[NSDate date] timeIntervalSinceReferenceDate]);
//    NSArray *result2 = [First10From1000000 first10FromArrUseHeapInArr:[numberOf1000000 copy]];
//    NSLog(@"%@", result2);
//    NSLog(@"%f", [[NSDate date] timeIntervalSinceReferenceDate]);
    
    NSString *normal = @"hello boy! welcome to iOS world!";
    NSString *reversed = [normal reverse];
    NSLog(@"%@", reversed);
}


// 插入排序
-(void)insertionSortWithArr:(NSMutableArray *)unSortedArr {
    NSLog(@"排序前: %@", unSortedArr);
    
    NSInteger len = unSortedArr.count;
    NSInteger preIndex;
    
    for (NSInteger i=1; i<len; i++) {
        
        NSInteger current = [unSortedArr[i] intValue];
        preIndex = i - 1;
        
        while (preIndex >= 0 && [unSortedArr[preIndex] intValue] > current) {
            unSortedArr[preIndex + 1] = unSortedArr[preIndex];
            preIndex --;
        }
        
        unSortedArr[preIndex + 1] = @(current);
    }
    
    NSLog(@"排序后: %@", unSortedArr);
}

// 选择排序
-(void)selectionSortWithArr:(NSMutableArray *)unSortedArr {
    NSLog(@"排序前: %@", unSortedArr);
    
    NSInteger len = unSortedArr.count;
    NSInteger minIndex;
    
    for (NSInteger i=0; i<len - 1; i++) {
        
        minIndex = i;
        
        for (NSInteger j=i+1; j<len; j++) {
            if ([unSortedArr[j] intValue] < [unSortedArr[minIndex] intValue]) {
                minIndex = j;
            }
        }
        
        if (minIndex != i) {
            NSNumber *temp = unSortedArr[i];
            unSortedArr[i] = unSortedArr[minIndex];
            unSortedArr[minIndex] = temp;
        }
    }
    
    NSLog(@"排序后: %@", unSortedArr);
}


/******************************************************************/
//             init
/******************************************************************/
-(void)dataInit {
    [self.unSortedArr addObject:@(4)];
    [self.unSortedArr addObject:@(1)];
    [self.unSortedArr addObject:@(3)];
    [self.unSortedArr addObject:@(9)];
    [self.unSortedArr addObject:@(6)];
    [self.unSortedArr addObject:@(2)];
    [self.unSortedArr addObject:@(40)];
    [self.unSortedArr addObject:@(5)];
    [self.unSortedArr addObject:@(99)];
    
    [self.majorityElementArr addObject:@(2)];
    [self.majorityElementArr addObject:@(1)];
    [self.majorityElementArr addObject:@(2)];
    [self.majorityElementArr addObject:@(3)];
    [self.majorityElementArr addObject:@(2)];
    [self.majorityElementArr addObject:@(2)];
}


/******************************************************************/
//             setter && getter
/******************************************************************/
-(NSMutableArray *)unSortedArr {
    if (_unSortedArr == nil) {
        _unSortedArr = [[NSMutableArray alloc] init];
    }
    return _unSortedArr;
}

-(NSMutableArray *)majorityElementArr {
    if (_majorityElementArr == nil) {
        _majorityElementArr = [[NSMutableArray alloc] init];
    }
    return _majorityElementArr;
}
@end
