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

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *unSortedArr;
@property (nonatomic, strong) NSMutableArray *majorityElementArr;
@property (nonatomic, strong) RBTree *demoRBTree;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
 
    NSArray *valueArr = @[@(12), @(1), @(9), @(2), @(0), @(11), @(7), @(19), @(4),
                          @(15), @(18), @(5), @(14), @(13), @(10), @(16), @(6), @(3), @(8), @(17)];
    self.demoRBTree = [[RBTree alloc] initWithArr:valueArr];
    
    for (NSNumber *value in valueArr) {
        if ([value integerValue] == 17) {
            NSLog(@"");
        }
        [self.demoRBTree remove:[value integerValue]];
        NSLog(@"");
    }
}

/******************************************************************/
#pragma mark - 获取两个view的公共父视图
/******************************************************************/
-(void)getCommonView {
    UIView *commn1 = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:commn1];
    
    UIView *commn2 = [[UIView alloc] initWithFrame:self.view.bounds];
    [commn1 addSubview:commn2];
    
    UIView *commn3 = [[UIView alloc] initWithFrame:self.view.bounds]; // 这是要找的公共父试图
    [commn2 addSubview:commn3];
    
    UIView *sub1 = [[UIView alloc] initWithFrame:self.view.bounds];
    [commn3 addSubview:sub1];
    UIView *sub11 = [[UIView alloc] initWithFrame:self.view.bounds];
    [sub1 addSubview:sub11];
    UIView *sub111 = [[UIView alloc] initWithFrame:self.view.bounds]; // 视图1
    [sub11 addSubview:sub111];
    
    UIView *sub2 = [[UIView alloc] initWithFrame:self.view.bounds];
    [commn3 addSubview:sub2];
    UIView *sub22 = [[UIView alloc] initWithFrame:self.view.bounds];
    [sub2 addSubview:sub22];
    UIView *sub222 = [[UIView alloc] initWithFrame:self.view.bounds]; // 视图2
    [sub22 addSubview:sub222];
    
    UIView *common = [sub111 commonViewWith:sub222];
    NSLog(@"");
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
