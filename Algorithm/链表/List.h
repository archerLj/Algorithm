//
//  List.h
//  Algorithm
//
//  Created by ArcherLj on 2019/9/3.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListNode : NSObject

@property (nonatomic, assign) NSInteger key;
@property (nonatomic, strong) ListNode *next;

@end

@interface List : NSObject

@property (nonatomic, strong) ListNode *head;
-(instancetype)initFromArr:(NSArray *)arr;

// 反转链表
-(void)reverse;

// 判断链表相交，如果相交，则返回交点，否则返回nil
-(ListNode *)crossWithList:(List *)list;

@end
