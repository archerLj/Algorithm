//
//  TreeManager.m
//  Algorithm
//
//  Created by archerLj on 2019/8/25.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "TreeManager.h"

@implementation TreeManager

/******************************************************************/
#pragma mark - 创建二叉树
/******************************************************************/
+(TreeNode *)createTreeWithArr:(NSArray *)arr {
    
    if (!arr || arr.count <= 0) {
        return nil;
    }
    
    TreeNode *rootNode;
    for (NSNumber *item in arr) {
        rootNode = [self addValue:[item integerValue] underRootNode:rootNode];
    }
    
    return rootNode;
}

+(TreeNode *)addValue:(NSInteger)value underRootNode:(TreeNode *)rootNode {
    
    if (!rootNode) {
        rootNode = [[TreeNode alloc] init];
        rootNode.value = value;
        
    } else {
        if (value < rootNode.value) {
            rootNode.leftLeaf = [TreeManager addValue:value underRootNode:rootNode.leftLeaf];
        } else {
            rootNode.rightLeaf = [TreeManager addValue:value underRootNode:rootNode.rightLeaf];
        }
    }
    
    return rootNode;
}


/******************************************************************/
#pragma mark - 二叉树的三种遍历方式
/******************************************************************/
+(void)preOrderSortWithRootNode:(TreeNode *)rootNode withResultArr:(NSMutableArray *)resultArr {
    
    if (!rootNode) {
        return;
    }
    
    [resultArr addObject:@(rootNode.value)];
    [TreeManager preOrderSortWithRootNode:rootNode.leftLeaf withResultArr:resultArr];
    [TreeManager preOrderSortWithRootNode:rootNode.rightLeaf withResultArr:resultArr];
}

+(void)middleOrderSortWithRootNode:(TreeNode *)rootNode withResultArr:(NSMutableArray *)resultArr {
    if (!rootNode) {
        return;
    }

    [TreeManager middleOrderSortWithRootNode:rootNode.leftLeaf withResultArr:resultArr];
    [resultArr addObject:@(rootNode.value)];
    [TreeManager middleOrderSortWithRootNode:rootNode.rightLeaf withResultArr:resultArr];
}

+(void)afterOrderSortWithRootNode:(TreeNode *)rootNode withResultArr:(NSMutableArray *)resultArr {
    if (!rootNode) {
        return;
    }
    
    [TreeManager afterOrderSortWithRootNode:rootNode.leftLeaf withResultArr:resultArr];
    [TreeManager afterOrderSortWithRootNode:rootNode.rightLeaf withResultArr:resultArr];
    [resultArr addObject:@(rootNode.value)];
}


/******************************************************************/
#pragma mark - 反转二叉树
/******************************************************************/
+(void)reverseTreeWithRootNode:(TreeNode *)rootNode {
    
    if (rootNode == nil) {
        return;
    }
    
    if (rootNode.leftLeaf == nil && rootNode.rightLeaf == nil) {
        return;
    }
    
    TreeNode *temp = rootNode.leftLeaf;
    rootNode.leftLeaf = rootNode.rightLeaf;
    rootNode.rightLeaf = temp;
    
    [TreeManager reverseTreeWithRootNode:rootNode.leftLeaf];
    [TreeManager reverseTreeWithRootNode:rootNode.rightLeaf];
}

/******************************************************************/
#pragma mark - 删除节点
/******************************************************************/
+(void)removeValue:(NSInteger)value inTreeWithRootNode:(TreeNode *)rootNode {
    
    if (rootNode == nil) {
        NSLog(@"error: 指定节点不存在");
        return;
    }
    
    if (value == rootNode.value) {
        // 1. 是叶子节点，则直接删除即可
        if (rootNode.leftLeaf == nil && rootNode.rightLeaf == nil) {
            rootNode = nil;
            return;
        }
        
        // 2. 只有一个儿子，则直接继承父业
        if (rootNode.leftLeaf != nil && rootNode.rightLeaf == nil) { // 只有左子树
            [TreeManager replaceNode:rootNode withNode:rootNode.leftLeaf];
            return;
            
        } else if (rootNode.rightLeaf != nil && rootNode.leftLeaf == nil) { // 只有右子树
            [TreeManager replaceNode:rootNode withNode:rootNode.rightLeaf];
            return;
        }
        
        // 3. 既有左子树，又有右子树
        TreeNode *leftNode = rootNode.leftLeaf;
        TreeNode *lastRightNode = leftNode;
        
        // 3.1 找到左子树下最最右边的节点
        while (lastRightNode.rightLeaf != nil) {
            lastRightNode = lastRightNode.rightLeaf;
        }
        
        // 3.2 将要删除节点的右子树嫁接到左子树中最最右边的节点下
        lastRightNode.rightLeaf = rootNode.rightLeaf;
        
        [TreeManager replaceNode:rootNode withNode:rootNode.leftLeaf];
        return;
        
    } else if (value < rootNode.value) {
        [TreeManager removeValue:value inTreeWithRootNode:rootNode.leftLeaf];
    } else {
        [TreeManager removeValue:value inTreeWithRootNode:rootNode.rightLeaf];
    }
}

+(void)replaceNode:(TreeNode *)rootNode withNode:(TreeNode *)replace {
    
    rootNode.value = replace.value;
    rootNode.leftLeaf = replace.leftLeaf;
    rootNode.rightLeaf = replace.rightLeaf;
}

/******************************************************************/
#pragma mark - 增加节点
/******************************************************************/
+(TreeNode *)addValue:(NSInteger)value toTreeWithRootNode:(TreeNode *)rootNode {
    
    if (rootNode == nil) {
        rootNode = [[TreeNode alloc] init];
        rootNode.value = value;
    } else {
        [TreeManager addValue:value withRootNode:rootNode];
    }
    
    return rootNode;
}

+(void)addValue:(NSInteger)value withRootNode:(TreeNode *)rootNode {
    
    // 1. 比该节点小，则遍历左子树，在适当位置添加新节点
    if (value < rootNode.value) {
        
        // 1.1 该节点左子树为空，就是这个坑，新建节点就可以了
        if (rootNode.leftLeaf == nil) {
            TreeNode *leftNode = [[TreeNode alloc] init];
            leftNode.value = value;
            rootNode.leftLeaf = leftNode;
        } else {
            [TreeManager addValue:value toTreeWithRootNode:rootNode.leftLeaf];
        }
        
    // 2. 比该节点大，则遍历右子树，在适当位置添加新节点
    } else {
        
        // 2.1 该节点右子树为空，就是这个坑，新建节点就可以了
        if (rootNode.rightLeaf == nil) {
            TreeNode *rightNode = [[TreeNode alloc] init];
            rightNode.value = value;
            rootNode.rightLeaf = rightNode;
        } else {
            [TreeManager addValue:value toTreeWithRootNode:rootNode.rightLeaf];
        }
    }
}
@end
