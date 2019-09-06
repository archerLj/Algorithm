//
//  List.m
//  Algorithm
//
//  Created by ArcherLj on 2019/9/3.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "List.h"

@implementation ListNode
@end

@implementation List

-(instancetype)initFromArr:(NSArray *)arr {
    
    self = [super init];
    
    if (self) {
        
        ListNode *preNode;
        
        for (NSNumber *value in arr) {
            if (_head == nil) {
                _head = [[ListNode alloc] init];
                _head.key = [value integerValue];
                preNode = _head;
            } else {
                ListNode *newNode = [[ListNode alloc] init];
                newNode.key = [value integerValue];
                preNode.next = newNode;
                preNode = newNode;
            }
        }
    }
    return self;
}

-(void)reverse {
    
    ListNode *pre = nil;
    ListNode *cur = self.head;
    ListNode *next;
    
    while (cur != nil) {
        next = cur.next;
        cur.next = pre;
        pre = cur;
        cur = next;
    }
    
    self.head = pre;
}

/**
 如果两个链表有交点的话，那他们交点后面的点一定是重合，也就是下面这种情况：
 
 1 -> 2 -> 3
            \
             5 -> 6 -> 7
            /
 1 -> 2 -> 4
 
 可以通过遍历两个链表，判断他们是否有相同的节点，这种时间复杂度O(n²);
 
 还有一种是将两个链表从头节点开始依次入栈。这样，两个链表的尾节点就都在栈顶了，只要他们的尾节点相同，则相交，因为相交的话两个链表后面的节点相同
 否则不相交；同样如果相交的话，依次出栈，最后一个相同的节点就是他们的交点
 */

-(ListNode *)crossWithList:(List *)list {
    
    // 1. 将两个链表入栈，这里用数组表示栈
    NSMutableArray *queue1 = [NSMutableArray array];
    NSMutableArray *queue2 = [NSMutableArray array];
    
    ListNode *currentNodeOfSelf = self.head;
    while (currentNodeOfSelf != nil) {
        [queue1 insertObject:currentNodeOfSelf atIndex:0];
        currentNodeOfSelf = currentNodeOfSelf.next;
    }
    
    ListNode *currentNodeOfList = list.head;
    while (currentNodeOfList != nil) {
        [queue2 insertObject:currentNodeOfList atIndex:0];
        currentNodeOfList = currentNodeOfList.next;
    }
    
    // 栈顶节点相同则相交，否则不相交
    if (queue1[0] == queue2[0]) {
        
        ListNode *lastCommonNode = queue1[0]; // 用来保存最后一个相同的节点，就是他们的交点
        NSInteger minCount = MIN(queue1.count, queue2.count);
        NSInteger i=0;
        
        for (; i<minCount; i++) {
            if (queue1[i] == queue2[i]) {
                lastCommonNode = queue1[i];
            } else {
                return lastCommonNode;
            }
        }
        return queue1[i];
        
    } else {
        return nil;
    }
}

-(NSString *)description {
    NSMutableString *result = [NSMutableString string];
    ListNode *currentNode = self.head;
    while (currentNode != nil) {
        [result appendString:[NSString stringWithFormat:@"%lu -> ", currentNode.key]];
        currentNode = currentNode.next;
    }
    [result appendString:@"null"];
    return [result copy];
}

@end
