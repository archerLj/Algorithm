//
//  SearchBTree.m
//  Algorithm
//
//  Created by ArcherLj on 2019/8/26.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "SearchBTree.h"

/******************************************************************/
#pragma mark - 二叉树节点
/******************************************************************/
@implementation TreeNode

-(instancetype)initWithValue:(NSInteger)value {
    self = [super init];
    
    if (self) {
        _value = value;
        _leftLeaf = nil;
        _rightLeaf = nil;
    }
    
    return self;
}

@end


/******************************************************************/
#pragma mark - 二叉搜索树
/******************************************************************/
@interface SearchBTree()

@property (nonatomic, strong) TreeNode *rootNode;

@end

@implementation SearchBTree

/******************************************************************/
#pragma mark - 创建二叉树
/******************************************************************/
-(void)createTreeWithArr:(NSArray *)arr {
    
    if (!arr || arr.count <= 0) {
        return;
    }
    
    for (NSNumber *item in arr) {
        NSInteger value = [item integerValue];
        [self addValue:value];
    }
}


/******************************************************************/
#pragma mark - 二叉树的三种遍历方式
/******************************************************************/
-(void)preOrderSortWithResultArr:(NSMutableArray *)resultArr {
    
    if (self.rootNode == nil) {
        return;
    }
    
    [self preOrderSortWithRootNode:self.rootNode withResultArr:resultArr];
}

-(void)preOrderSortWithRootNode:(TreeNode *)node withResultArr:(NSMutableArray *)resultArr {
    
    if (node == nil) {
        return;
    }
    
    [resultArr addObject:@(node.value)];
    [self preOrderSortWithRootNode:node.leftLeaf withResultArr:resultArr];
    [self preOrderSortWithRootNode:node.rightLeaf withResultArr:resultArr];
}

-(void)inOrderSortWithResultArr:(NSMutableArray *)resultArr {
    
    if (self.rootNode == nil) {
        return;
    }
    
    [self inOrderSortWithRootNode:self.rootNode withResultArr:resultArr];
}

-(void)inOrderSortWithRootNode:(TreeNode *)node withResultArr:(NSMutableArray *)resultArr {
    
    if (node == nil) {
        return;
    }
    
    [self inOrderSortWithRootNode:node.leftLeaf withResultArr:resultArr];
    [resultArr addObject:@(node.value)];
    [self inOrderSortWithRootNode:node.rightLeaf withResultArr:resultArr];
}

-(void)postOrderSortWithResultArr:(NSMutableArray *)resultArr {
    
    if (self.rootNode == nil) {
        return;
    }
    
    [self postOrderSortWithRootNode:self.rootNode withResultArr:resultArr];
}

-(void)postOrderSortWithRootNode:(TreeNode *)node withResultArr:(NSMutableArray *)resultArr {
    
    if (node == nil) {
        return;
    }
    
    [self postOrderSortWithRootNode:node.leftLeaf withResultArr:resultArr];
    [self postOrderSortWithRootNode:node.rightLeaf withResultArr:resultArr];
    [resultArr addObject:@(node.value)];
}

-(void)levelOrderSortWithResultArr:(NSMutableArray *)resultArr {
    
    NSMutableArray *levelNodes = [NSMutableArray array]; // 用来暂存出队的节点
    NSMutableArray *queue = [NSMutableArray array]; // 用来遍历节点用的队列
    
    
    TreeNode *lastNodeInCurrentLevel = self.rootNode; // 当前层的最后一个节点
    TreeNode *lastNodeInNextLevel; // 下一层的最后一个节点
    
    [queue addObject:self.rootNode]; // 头节点入队
    
    while (queue.count > 0) {
        
        // 1. 队列第一个元素出队，并加入到暂存数组
        TreeNode *first = [queue objectAtIndex:0];
        [queue removeObjectAtIndex:0];
        [levelNodes addObject:first];
        
        // 2. 把当前出队节点的左右孩子入队，并更新lastNodeInNextLevel
        if (first.leftLeaf != nil) {
            [queue addObject:first.leftLeaf];
            lastNodeInNextLevel = first.leftLeaf;
        }
        if (first.rightLeaf != nil) {
            [queue addObject:first.rightLeaf];
            lastNodeInNextLevel = first.rightLeaf;
        }
        
        // 3. 如果出队的元素是它所在层的最后一个元素，则需要把暂存数组中的数据提交到结果中，并重新初始化来装下一层的数据
        // 同时表示它所在层所有节点的孩子已经入队，下一层的最后一个节点也确定下来了
        // 这时候把下一层就变成当前层，之前的lastNodeInNextLevel就变成新的当前层的最后节点了
        if (first == lastNodeInCurrentLevel) {
            
            NSArray *resultOfThisLevel = [levelNodes copy];
            [resultArr addObject:resultOfThisLevel];
            [levelNodes removeAllObjects];
            
            lastNodeInCurrentLevel = lastNodeInNextLevel;
            lastNodeInNextLevel = nil;
        }
    }
}


/******************************************************************/
#pragma mark - 反转二叉树
/******************************************************************/
-(void)reverseTree {
    
    if (self.rootNode == nil) {
        return;
    }
    
    [self reverseNode:self.rootNode];
}

-(void)reverseNode:(TreeNode *)node {
    if (node == nil) {
        return;
    }
    
    if (node.leftLeaf == nil && node.rightLeaf == nil) {
        return;
    }
    
    TreeNode *temp = node.leftLeaf;
    node.leftLeaf = node.rightLeaf;
    node.rightLeaf = temp;
    
    [self reverseNode:node.leftLeaf];
    [self reverseNode:node.rightLeaf];
}

/******************************************************************/
#pragma mark - 删除节点
/******************************************************************/
-(void)removeValue:(NSInteger)value {
    
    TreeNode *current = self.rootNode;
    
    while (true) {
        if (current == nil) {
            // 要删除的节点不存在
            break;
        }
        
        if (value == current.value) {
            // 1. 是叶子节点，则直接删除即可
            if (current.leftLeaf == nil && current.rightLeaf == nil) {
                current = nil;
                break;
            }
            
            // 2. 只有一个儿子，则直接继承父业
            if (current.leftLeaf != nil && current.rightLeaf == nil) { // 只有左子树
                [self replaceNode:current withNode:current.leftLeaf];
                break;
                
            } else if (current.rightLeaf != nil && current.leftLeaf == nil) { // 只有右子树
                [self replaceNode:current withNode:current.rightLeaf];
                break;
            }
            
            // 3. 既有左子树，又有右子树
            TreeNode *leftNode = current.leftLeaf;
            TreeNode *lastRightNode = leftNode;
            
            // 3.1 找到左子树下最最右边的节点
            while (lastRightNode.rightLeaf != nil) {
                lastRightNode = lastRightNode.rightLeaf;
            }
            
            // 3.2 将要删除节点的右子树嫁接到左子树中最最右边的节点下
            lastRightNode.rightLeaf = current.rightLeaf;
            
            [self replaceNode:current withNode:current.leftLeaf];
            break;
            
        } else if (value < current.value) {
            current = current.leftLeaf;
            continue;
        } else {
            current = current.rightLeaf;
            continue;
        }
    }
}

// 将node的值替换成replace的值，并将replace的左右孩子转给node，然后删除replace
-(void)replaceNode:(TreeNode *)node withNode:(TreeNode *)replace {
    
    node.value = replace.value;
    node.leftLeaf = replace.leftLeaf;
    node.rightLeaf = replace.rightLeaf;
    replace = nil;
}

/******************************************************************/
#pragma mark - 增加节点
/******************************************************************/
-(void)addValue:(NSInteger)value {

    if (self.rootNode == nil) {
        self.rootNode = [[TreeNode alloc] init];
        self.rootNode.value = value;
    } else {
        
        TreeNode *current = self.rootNode; // 遍历用
        
        while (true) {
            if (value < current.value) {
                if (current.leftLeaf == nil) {
                    current.leftLeaf = [[TreeNode alloc] initWithValue:value];
                    break;
                } else {
                    current = current.leftLeaf;
                    continue;
                }
                
            } else {
                if (current.rightLeaf == nil) {
                    current.rightLeaf = [[TreeNode alloc] initWithValue:value];
                    break;
                } else {
                    current = current.rightLeaf;
                    continue;
                }
            }
        }
    }
}

@end
