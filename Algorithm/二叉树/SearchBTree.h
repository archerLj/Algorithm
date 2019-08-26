//
//  SearchBTree.h
//  Algorithm
//
//  Created by ArcherLj on 2019/8/26.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 1. 满二叉树
 
 除了叶子节点外，每个节点都有左右子叶，并且叶子节点处在二叉树的最底层，比如下面：
 A
 /    \
 B      C
 / \    / \
 D   E  F   G
 
 2. 完全二叉树
 
 如果二叉树的深度为h，除了第h层外，其他各层的节点数都达到最大值，第h层的节点都连续几种在最左边，比如下面:
 A
 /   \
 B     C
 / \   /
 D   E  F
 
 3. 二叉排序树/二叉搜索树
 
 二叉排序树要么是一颗空树，要么是具有下列特质的树：
 1. 若左子树不为空，则左子树上所有节点的值均小于根节点的值
 2. 若右子树不为空，则右子树上所有节点的值均大于根节点的值
 3. 左右子树也都是二叉排序树
 4. 没有键值相等的节点
 比如下面:
 
 5
 /   \
 3     8
 / \     \
 2   4    10
 
 4. 堆 （大顶堆、小顶堆）
 堆和二叉排序树是有区别的，堆首先是一个完全二叉树，其次满足下面的特质:
 4.1: 大顶堆 -- 每个节点的值都大于或者等于其左右孩子节点的值
 4.2: 小顶堆 -- 每个节点的值都小于或等于其左右孩子节点的值
 
 5. 平衡二叉搜索树(AVL树)：
 平衡二叉搜索树要么为空树，要么具有一下特质：
 1. 左右子树深度之差的绝对值不超过1
 2. 左右子树仍然为平衡二叉树
 
 6. 哈夫曼树/霍夫曼树
 哈夫曼树是最优二叉树，他的定义是：给定n个权值作为n个叶子节点，构造一颗二叉树，若树的带权路径长度达到最小，则这棵树
 被称为哈夫曼树.
 180
 /   \
 100    80
 /  \
 50   30
 /  \
 20   10
 
 这里有几个概念：
 6.1 路径和长度
 在一棵树中，从根节点到达儿子或者孙子节点之间的通路称为路径，通路中分支的数目称为路径长度。从根节点到L层节点的
 路径长度为L-1.
 如上：100和80的路径长度是1，50和30的路径长度是2，20和10的路径长度是3.
 
 6.2 节点的权和带权路径长度
 如果给树中节点赋予一个有着某种含义的值，则这个值称为这个节点的权；某个节点的带权路径长度是指从根节点到该节点的
 路径长度与该节点的权的乘积。
 如上：节点20的权值是20，路径长度是3，带权路径长度为: 20 * 3 = 60
 
 6.3 树的带权路径长度
 树的带权路径长度规定为所有叶子节点的带权路径长度之和。
 如上：树的WPL=100*1 + 50*2 + 20*3 + 10*3 = 290
 --------------------------------
 构建哈夫曼树：
 假设n个权值w1,w2,w3...wn，构建一颗有n个叶子的哈夫曼树的过程如下:
 1. 将w1,w2,w3...wn看作是有n颗树的森林（每棵树只有一个节点）；
 2. 在森林中选出根节点的权值最小的两棵树进行合并，作为一颗新树的左右子树，且新树的根节点权值等于左右子树根节点
 权值之和；
 3. 从森林中删除上面选取的两颗子树，并将新树加入森林；
 4. 重复（2）（3），直到森林中只剩下一棵树为止，这棵树就是哈夫曼树
 
 -------------------------------------------------------
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
 容易修正。
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
 / \         E节点右旋          / \
 F   G        <--------        D   F
 
 这里在B节点左旋，将B的右子树的根节点E旋转到B的位置，将B作为E的左子树，同时，将E原来的左子树改成B的右子树
 右旋正好是相反的
 */


/******************************************************************/
#pragma mark - 搜索二叉树节点
/******************************************************************/
@interface TreeNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TreeNode *leftLeaf;
@property (nonatomic, strong) TreeNode *rightLeaf;

-(instancetype)initWithValue:(NSInteger)value;

@end


/******************************************************************/
#pragma mark - 搜索二叉树
/******************************************************************/
@interface SearchBTree : NSObject


// 从数组创建一颗二叉排序树
-(void)createTreeWithArr:(NSArray *)arr;


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
-(void)preOrderSortWithResultArr:(NSMutableArray *)resultArr;

// 2. 中序遍历
-(void)inOrderSortWithResultArr:(NSMutableArray *)resultArr;

// 3. 后序遍历
-(void)postOrderSortWithResultArr:(NSMutableArray *)resultArr;



// 反转二叉树
-(void)reverseTree;

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

// 删除指定节点
-(void)removeValue:(NSInteger)value;

// 增加节点
-(void)addValue:(NSInteger)value;

@end
