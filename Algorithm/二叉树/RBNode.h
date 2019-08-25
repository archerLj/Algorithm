//
//  RBNode.h
//  Algorithm
//
//  Created by archerLj on 2019/8/25.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 7. 红黑树
 二叉搜索树是一个很好的数据结构，可以很快速的查找，删除或者添加数据项，但是它有一个很麻烦的问题。如果树中插入的是随机的
 数据项，它可能还可以很好的工作，但是，如果插入的是有序的数据项，二叉树就是非平衡的了，所有节点全部排在一条线上，实际
 上就变成了一个链表结构，它的优势就没有了。
 
 为了能以较快的时间来搜索一颗树，需要保证树总是平衡的（或者大致是平衡的），这就是说对树中的每个节点，在他左边的后代数目
 和它右边的后代数目大致相同。红-黑树就是这样一颗平衡二叉树，对于每一个要插入的数据项，插入程序都会检查会不会破坏树的特征
 结构，如果破坏了，程序会进行修正，根据需要改变树的结构，从而保证树的平衡。
 
 红-黑树的特质:
 1. 首先红-黑树每个节点不是红色就是黑色(这里只要用一个值来表示就可以了)
 2. 根节点总是黑色的
 3. 如果节点是红色的，那么它的子节点必须是黑色的（反之不一定）
 4. 从根节点到叶子节点或者空子节点的每条路径上，必须包含相同数目的黑色节点（即相同的黑色高度）
 
 注意⚠️：
 在红-黑树中新插入的节点是红色的，这不是随便决定的。因为插入红色节点比插入黑色节点违背红-黑树特质的可能性要小。原因是：
 插入黑色节点总会违背规则（4），但是插入红色节点只有一半的机会会违背规则 (3); 另外，违背规则（3）比违背规则（4）更
 容易修正
 -------------------------------------------------------
 7.1 红-黑树的平衡性修正
 红-黑树主要通过三种途径来进行修正：变色、左旋和右旋
 7.1.1 变色
 变色很容易理解，如果新插入的红色节点违背了规则（3），那么就要通过改变父节点的颜色来修正
 7.1.2 左旋和右旋
 左旋和右旋也很好理解，如果树向右倾斜，也就是右子树比较深，就需要左旋：如下:
          A                                A
        /   \                             / \
       B     C      B节点左旋             E    C
      / \           -------->          /  \
     D   E                            B    G
    / \              E节点右旋         / \
   F   G            <--------        D   F
 
 这里在B节点左旋，将B的右子树的根节点E旋转到B的位置，将B作为E的左子树，同时，将E原来的左子树改成B的右子树
 右旋正好是相反的
 
 */

typedef NS_ENUM(NSUInteger, RBColor) {
    RBRed = 0,
    RBBlack
};

@interface RBNode : NSObject

@property (nonatomic, assign) RBColor color; // 颜色
@property (nonatomic, assign) NSInteger key; // 键值
@property (nonatomic, strong) RBNode *left; // 左节点
@property (nonatomic, strong) RBNode *right; // 右节点
@property (nonatomic, strong) RBNode *parent; // 父节点

-(instancetype)initWithColor:(RBColor)color
                         key:(NSInteger)key
                        left:(RBNode *)left
                       right:(RBNode *)right
                      parent:(RBNode *)parent;
@end



/******************************************************************/
#pragma mark - 红-黑树操作
/******************************************************************/
@interface RBTree : NSObject

// 向红-黑树中插入项目
-(void)insert:(NSInteger)value;

// 将node节点左旋
-(void)leftRotateNode:(RBNode *)node;

// 将node节点右旋
-(void)rightRotateNode:(RBNode *)node;
@end
