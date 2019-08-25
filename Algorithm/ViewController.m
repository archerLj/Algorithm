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
#import "TreeManager.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *unSortedArr;
@property (nonatomic, strong) NSMutableArray *majorityElementArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
    
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
#pragma mark - 二叉树
/******************************************************************/
-(void)tree {
    /**
     1
     \
     3
     /  \
     2    10
     /  \
     8   300
     /
     20
     
     // 前： 1 3 2 10 8 300 20
     // 中： 1 2 3 8 10 20 300
     // 后:  2 8 20 300 10 3 1
     */
    
    TreeNode *rootNode = [TreeManager createTreeWithArr:@[@(1), @(3), @(2), @(10), @(8), @(300), @(20)]];
    
    [TreeManager addValue:7 toTreeWithRootNode:rootNode];
    NSLog(@"");
    
    //    NSMutableArray *result = [NSMutableArray array];
    //    [TreeManager afterOrderSortWithRootNode:rootNode withResultArr:result];
    //    NSLog(@"%@", result);
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
