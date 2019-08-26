//
//  RBTree.m
//  Algorithm
//
//  Created by ArcherLj on 2019/8/26.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "RBTree.h"

/******************************************************************/
#pragma mark - 红黑树节点
/******************************************************************/
@implementation RBNode

-(instancetype)initWithColor:(RBColor)color
                         key:(NSInteger)key
                        left:(RBNode *)left
                       right:(RBNode *)right
                      parent:(RBNode *)parent {
    
    self = [super init];
    
    if (self) {
        _color = color;
        _key = key;
        _left = left;
        _right = right;
        _parent = parent;
    }
    
    return self;
}

-(BOOL)hasNoChild {
    return self.left == nil && self.right == nil;
}

-(BOOL)hasOneChild {
    return (self.left == nil && self.right != nil) || (self.left != nil && self.right == nil);
}

-(BOOL)hasTwoChild {
    return self.left != nil && self.right != nil;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%ld: %@", self.key, self.color == RBRed ? @"read" : @"black"];
}

@end


/******************************************************************/
#pragma mark - 红黑树
/******************************************************************/
@interface RBTree()

@property (nonatomic, strong) RBNode *rootNode; // 树的根节点

@end

@implementation RBTree


/******************************************************************/
#pragma mark - 插入
/******************************************************************/
// 由于红-黑树是二叉搜索树的改进模型，所以，插入的前半段是一样的
-(void)insert:(NSInteger)value {
    RBNode *node = [[RBNode alloc] initWithColor:RBRed key:value left:nil right:nil parent:nil];
    [self insertNode:node];
}

-(void)insertNode:(RBNode *)node {
    
    if (self.rootNode == nil) {
        self.rootNode = node;
        return;
    }
    
    // 1. 找到合适插入的位置
    RBNode *parent;
    RBNode *root = self.rootNode;
    
    // 一直遍历，直到遍历到叶子节点，这个叶子节点就是需要插入的节点的父节点，这里用parent来保存这个叶子节点
    while (root != nil) {
        parent = root;
        if (node.key < root.key) {
            root = root.left;
        } else {
            root = root.right;
        }
    }
    
    // parent节点即是需要插入节点的父节点
    node.parent = parent;
    
    // 2. 将新节点插入到父节点的左/右节点中
    if (node.key < parent.key) {
        parent.left = node;
    } else {
        parent.right = node;
    }
    
    // 3. 将其重新修正为一颗标准的红-黑树
    [self insertFixUp:node];
}

/**
 二叉树修正
 
 如果是第一次插入，由于原树为空，所以只会违背原则（2），只要变成黑色就行了；如果插入节点的父节点是黑色的，那就
 不会违背红-黑树的原则，就什么都不用做。但是，遇到下面三种情况时，我们就要开始变色和旋转了：
 
 1. 插入节点的父节点和叔叔节点（和父节点平级的另一个节点）均为红色
 2. 插入节点的父节点是红色，叔叔节点是黑色，且插入节点是父节点的右子节点
 3. 插入节点的父节点是红色，叔叔节点是黑色，且插入节点是父节点的左子节点
 
 */
-(void)insertFixUp:(RBNode *)node {
    RBNode *parent; // 父节点
    RBNode *gParent; // 祖父节点
    
    // 需要修正的条件：父节点存在，且父节点的颜色是红色
    while ((parent = node.parent) != nil && parent.color == RBRed) {
        
        gParent = parent.parent; // 获取祖父节点
        
        // 父节点是祖父节点的左子节点
        if (parent == gParent.left) {
            RBNode *uncle = gParent.right; // 获取叔叔节点
            
            // 情况1: 叔叔节点也是红色
            if (uncle != nil && uncle.color == RBRed) {
                // 把父节点和叔叔节点变成黑色节点
                parent.color = RBBlack;
                uncle.color = RBBlack;
                // 把祖父节点变成红色节点
                gParent.color = RBRed;
                // 将祖父节点变成当前节点，然后继续while下次循环
                node = gParent;
                continue;
            }
            
            // 情况2：叔叔节点是黑色，且当前节点是右子节点
            if (node == parent.right) {
                // 以父节点为支点左旋
                [self leftRotateNode:parent];
                // 将父节点和自己调换
                //                RBNode *tmp = parent;
                //                parent = node;
                //                node = tmp;
                
                // 将父节点设为当前节点，并继续下次循环
                node = parent;
                continue;
            }
            
            // 情况3: 叔叔节点是黑色，且当前节点是左子节点
            parent.color = RBBlack;
            gParent.color = RBRed;
            [self rightRotateNode:gParent];
            
            // 父节点是祖父节点的右子节点
        } else {
            RBNode *uncle = gParent.left; // 获取叔叔节点
            
            // 情况1: 叔叔节点也是红色
            if (uncle != nil && uncle.color == RBRed) {
                // 把父节点和叔叔节点变黑
                parent.color = RBBlack;
                uncle.color = RBBlack;
                // 把祖父节点变红
                gParent.color = RBRed;
                // 把祖父节点设为当前节点，然后重新开始处理
                node = gParent;
                continue;
            }
            
            // 情况2: 叔叔节点是黑色，且当前节点是左子节点
            if (node == parent.left) {
                // 以父节点为支点右旋
                [self rightRotateNode:parent];
                // 将父节点设为当前节点，继续下次循环
                node = parent;
                continue;
            }
            
            // 情况3：叔叔节点是黑色的，并且当前节点是右子节点
            parent.color = RBBlack;
            gParent.color = RBRed;
            [self leftRotateNode:gParent];
        }
    }
    
    // 最后确保根节点是黑色（这里其实while中调整树结构的时候已经将根节点设置为黑色了，这里主要确保空树的情况）
    self.rootNode.color = RBBlack;
}

/******************************************************************/
#pragma mark - 删除
/******************************************************************/
-(void)remove:(NSInteger)value {
    RBNode *node = [self searchNodeWithValue:value inRootNode:self.rootNode];
    if (node != nil) {
        [self removeNode:node];
    }
}

/**
 删除的逻辑是通过交换，将要删除的节点中的值交换到叶子节点，然后只需要删除叶子节点，并做旋转变色即可.
 */
-(void)removeNode:(RBNode *)node {
    
    // 😊情况1: node没有孩子，是叶子节点
    if (node.left == nil && node.right == nil) {
        if (node.color == RBRed) { // 1.1 如果node是红色，则直接删除即可
            node = nil;
            
        } else {  // 1.2 如果node是黑色，则删除它会破坏平衡，需要进行旋转变色
            [self rotateAndChangeColorWithNode:node];
        }
        
        // 😊情况2: 如果node只有一个孩子C，根据红黑树原则，node一定不是红色，因为红色要么没有孩子，要么有两个黑孩子.
        // 交换node和孩子C的值，然后交换后的node从情况1开始重新走删除流程
    } else if ([node hasOneChild]) {
        
        if (node.left != nil) { // node唯一的孩子是左孩子
            
            NSInteger tempKey = node.key;
            node.key = node.left.key;
            node.left.key = tempKey;
            
            [self removeNode:node.left];
            
        } else { // node唯一的孩子是右孩子
            
            NSInteger tempKey = node.key;
            node.key = node.right.key;
            node.right.key = tempKey;
            
            [self removeNode:node.right];
        }
        
        // 😊情况3: node有两个孩子，则从后继中找到最小节点D，交换node和D的值，然后交换后的node从情况1开始重新走删除流程
    } else {
        
        RBNode *leftMiniNode = [self searchPostMinNodeInRootNode:node];
        NSInteger tempKey = leftMiniNode.key;
        leftMiniNode.key = node.key;
        node.key = tempKey;
        [self removeNode:leftMiniNode];
    }
}

// TODO: 旋转变色
-(void)rotateAndChangeColorWithNode:(RBNode *)node {
    
}

// 查找后继节点中的最小节点，即右子树中最左的节点
-(RBNode *)searchPostMinNodeInRootNode:(RBNode *)node {
    
    RBNode *leftMiniNode = node.right;
    while (leftMiniNode.left != nil) {
        leftMiniNode = leftMiniNode.left;
    }
    return leftMiniNode;
}


// 查找键值为value的节点
-(RBNode *)searchNodeWithValue:(NSInteger)value inRootNode:(RBNode *)node {
    while (node != nil) {
        if (value < node.key) {
            node = node.left;
        } else if (value > node.key) {
            node = node.right;
        } else {
            return node;
        }
    }
    return nil;
}



/******************************************************************/
#pragma mark - 左旋和右旋
/******************************************************************/
/**
 对x节点进行左旋
 p                           p
 /                           /
 x                           y
 / \          左旋            / \
 lx  y       ------->        x   ry
 / \                     / \
 ly  ry                  lx  ly
 
 左旋有三个步骤:
 1. [y]的左节点非空时，将[y]的左节点[ly]赋给[x]的右节点，并将[y]的左节点[ly]的父节点改为[x]
 2. 将[x]的父节点[p]赋给[y]，并更新[p]的子节点（左或者右）为[y]
 3. 将[y]的左节点设为[x]，并更新[x]的父节点为[y]
 */
-(void)leftRotateNode:(RBNode *)node {
    
    // 1. 将y的左节点赋给x的右节点
    RBNode *rightNode = node.right; // 这里rightNode即是y节点, node即是x节点
    if (rightNode.left) {
        node.right = rightNode.left;
        rightNode.left.parent = node;
    }
    
    // 2. 将x的父节点p赋给y，并更新p的子节点为y
    if (node.parent) {
        rightNode.parent = node.parent;
        if (node.parent.left == node) {
            node.parent.left = rightNode;
        } else {
            node.parent.right = rightNode;
        }
    } else {
        
        // x节点本来是树的根节点，现在y节点变成根节点了
        self.rootNode = rightNode;
    }
    
    // 3. 将y的左节点设为x，更新x的父节点为y
    rightNode.left = node;
    node.parent = rightNode;
}

/**
 对y节点进行右旋
 
 p                         p
 /                         /
 y                         x
 / \        右旋            / \
 x  ry     -------->       lx  y
 / \                           / \
 lx  rx                        rx  ry
 
 右旋也有三个步骤:
 1. 如果[x]的右节点非空，则将[x]的右节点赋给[y]的左节点，并将[y]设为[x]右节点的父亲
 2. 将[y]的父节点赋给[x]，并将[y]的父节点[p]的子节点(左或者右节点)改为x
 3. 将[y]的父节点改为[x]，并将[x]的右节点改为[y]
 */
-(void)rightRotateNode:(RBNode *)node {
    
    // 1. 将x的右节点赋给y
    RBNode *leftNode = node.left; // 这里leftNode即是x节点, node即是y节点
    if (leftNode.right) {
        node.left = leftNode.right;
        leftNode.right.parent = node;
    }
    
    // 2. 将y的父节点赋给x，并将y的父节点p的子节点改为x
    if (node.parent) {
        leftNode.parent = node.parent;
        if (node.parent.left == node) {
            node.parent.left = leftNode;
        } else {
            node.parent.right = leftNode;
        }
    } else {
        // y本来就是树的根节点，现在x变成根节点了
        self.rootNode = leftNode;
    }
    
    // 3. 将y的父节点改成x，将x的右节点变成y
    node.parent = leftNode;
    leftNode.right = node;
}

@end
