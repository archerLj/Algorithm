//
//  TreeManager.h
//  Algorithm
//
//  Created by archerLj on 2019/8/25.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

@interface TreeManager : NSObject

/******************************************************************/
//
/******************************************************************/
// 1. 从数组创建一颗二叉排序树
+(TreeNode *)createTreeWithArr:(NSArray *)arr;


/******************************************************************/
//
/******************************************************************/
/**
 二叉树的三种基本遍历方式:
 1. 前序遍历： 先遍历根元素，再遍历左子树，最后遍历右子树， 根-左-右
 2. 中序遍历： 先遍历左子树，再遍历根元素，最后遍历右子树， 左-根-右
 3. 后序遍历： 先遍历左子树，再遍历右子树，最后遍历根元素， 左-右-根
 
 这三种遍历方式是根据遍历根元素的位置来划分的
 
 比如，有一颗这样的树:
 2
 / \
 1   3
 / \
 4   5
 前序遍历结果是: 2 1 3 4 5
 中序遍历结果是: 1 2 4 3 5
 后序遍历结果是: 1 4 5 3 2
 */
// 1. 前序遍历
+(void)preOrderSortWithRootNode:(TreeNode *)rootNode withResultArr:(NSMutableArray *)resultArr;

// 2. 中序遍历
+(void)middleOrderSortWithRootNode:(TreeNode *)rootNode withResultArr:(NSMutableArray *)resultArr;

// 3. 后序遍历
+(void)afterOrderSortWithRootNode:(TreeNode *)rootNode withResultArr:(NSMutableArray *)resultArr;


/******************************************************************/
//
/******************************************************************/
// 反转二叉树
+(void)reverseTreeWithRootNode:(TreeNode *)rootNode;

/**
 删除指定节点
 
 . 如果删除的是叶子节点，则直接删除即可
 . 如果删除的节点只有左子树或者右子树，则直接将左子树或者右子树的根节点转接到删除节点的位置即可。就像一个人挂了，
   如果他只有一个儿子，那么这个儿子可以直接继承他的遗产
 . 比较麻烦的是要删除的这个节点即有左子树，又有右子树，也就是挂了的这个人有两个儿子，那么怎么处理这个人挂了之后的
   事呢？让哪个儿子或者哪个孙子来做一家之主呢？
 
            A
           / \
          B   C
         / \
        D   E
       / \   \
      F   G   H
 删除指定节点的方法有很多，这里我们采用一种比较好理解的思路：
 比如这里要删除节点 B
 1. 让B的左子树直接继承B，也就是让D占用B原来的位置
 2. 找到B的左子树中最最右边的叶子节点，这里是G
 3. 将B的右子树直接转接到G节点即可
 结果如下:
 
        A
       / \
      D   C
     / \
    F   G
         \
          E
           \
            H
*/

+(void)removeValue:(NSInteger)value inTreeWithRootNode:(TreeNode *)rootNode;

// 增加节点
+(TreeNode *)addValue:(NSInteger)value toTreeWithRootNode:(TreeNode *)rootNode;
@end
