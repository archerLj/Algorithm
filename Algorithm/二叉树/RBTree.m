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

-(BOOL)hasTwoBlackChild {
    return (self.left == nil || self.left.color == RBBlack) && (self.right == nil || self.right.color == RBBlack);
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%ld: %@", self.key, self.color == RBRed ? @"read" : @"black"];
}

-(RBNode *)nf {
    if (self.parent) {
        if (self == self.parent.left) {
            if (self.parent.right) {
                return self.parent.right.right;
            }
        } else {
            if (self.parent.left) {
                return self.parent.left.left;
            }
        }
    }
    return nil;
}

-(RBNode *)nn {
    if (self.parent) {
        if (self == self.parent.left) {
            if (self.parent.right) {
                return self.parent.right.left;
            }
        } else {
            if (self.parent.left) {
                return self.parent.left.right;
            }
        }
    }
    return nil;
}

-(RBNode *)brother {
    if (self.parent) {
        if (self == self.parent.left) {
            return self.parent.right;
        } else {
            return self.parent.left;
        }
    }
    
    return nil;
}

-(RBNode *)uncle {
    if (self.parent) {
        if (self.parent.parent) {
            if (self.parent == self.parent.parent.left) {
                return self.parent.parent.right;
            } else {
                return self.parent.parent.left;
            }
        }
    }
    return nil;
}

-(BOOL)isLeftNode {
    if (self.parent) {
        return self == self.parent.left;
    }
    return NO;
}

-(BOOL)isRightNode {
    if (self.parent) {
        return self == self.parent.right;
    }
    return NO;
}

-(BOOL)isBlack {
    return self.color == RBBlack;
}

-(BOOL)isRed {
    return self.color == RBRed;
}

-(BOOL)nfIsBlack {
    if ([self nf]) {
        return [[self nf] color] == RBBlack;
    }
    return YES; // 这里空节点也被认为是黑色节点
}

-(BOOL)nfIsRed {
    if ([self nf]) {
        return [[self nf] color] == RBRed;
    }
    return NO;
}

-(BOOL)nnIsRed {
    if ([self nn]) {
        return [[self nn] color] == RBRed;
    }
    return NO;
}

-(BOOL)nnIsBlack {
    if ([self nn]) {
        return [[self nn] color] == RBBlack;
    }
    return YES; // 这里空节点也被认为是黑色节点
}

-(void)changeColorWithNode:(RBNode *)node {
    if (node) {
        RBColor temp = self.color;
        self.color = node.color;
        node.color = temp;
    }
}

@end


/******************************************************************/
#pragma mark - 红黑树
/******************************************************************/
@interface RBTree()

@property (nonatomic, strong) RBNode *rootNode; // 树的根节点

@end

@implementation RBTree

-(instancetype)initWithArr:(NSArray *)arr {
    self = [super init];
    if (self) {
        for (NSNumber *value in arr) {
            [self insert:[value integerValue]];
        }
    }
    return self;
}


/******************************************************************/
#pragma mark - 插入
/******************************************************************/
// 由于红-黑树是二叉搜索树的改进模型，所以，插入的前半段是一样的
-(void)insert:(NSInteger)value {
    
    // 新插入的节点开始颜色一定是红色的，这样修正的代价比较小
    RBNode *node = [[RBNode alloc] initWithColor:RBRed key:value left:nil right:nil parent:nil];
    [self insertNode:node];
}

-(void)insertNode:(RBNode *)node {
    
    // 😊情况1: 第一次插入，直接设为根节点，改成黑色即可
    if (self.rootNode == nil) {
        self.rootNode = node;
        self.rootNode.color = RBBlack;
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


// 二叉树插入修正
-(void)insertFixUp:(RBNode *)current {
    
    RBNode *parent; // 父节点
    RBNode *gParent; // 祖父节点
    RBNode *uncle; // 叔叔节点
    
    // 😊情况2: 父节点是黑色，则不用修正，已然是一颗红黑树
    // 只有父节点是红色的时候才需要修正，如果父节点是黑色，则仍然是标准的红黑树，不需要再修正
    while ((parent = current.parent) != nil && parent.color == RBRed) {
        
        gParent = parent.parent; // 获取祖父节点
        uncle = [current uncle];
        
        // 😊情况3: 叔叔节点是红色
        // 1. 将父节点和叔叔节点变黑 2.将祖父节点变红 3.将祖父节点设为当前节点，然后对当前节点进行修正
        if ([uncle color] == RBRed) {
            parent.color = RBBlack;
            uncle.color = RBBlack;
            gParent.color = RBRed;
            current = gParent;
            continue;
            
            // 😊情况4: 叔叔节点是黑色，又分下面几种情况
        } else {
            
            // 😊情况4.1: 当前节点是父节点的左孩子，父节点是祖父节点的左孩子
            // 1.将祖父节点右旋 2.交换父节点和祖父节点的颜色
            if ([current isLeftNode] && [parent isLeftNode]) {
                [self rightRotateNode:gParent];
                RBColor temp = parent.color;
                parent.color = gParent.color;
                gParent.color = temp;
                break;
                
                // 😊情况4.2: 当前节点是父节点的右孩子，父节点是祖父节点的左孩子
                // 1.将父节点左旋 2.将父节点设为当前节点继续修正
            } else if ([current isRightNode] && [parent isLeftNode]) {
                [self leftRotateNode:parent];
                current = parent;
                continue;
                
                // 😊情况4.3: 当前节点是父节点的右孩子，父节点是祖父节点的右孩子
                // 1.将祖父节点左旋 2.交换父节点和祖父节点的颜色
            } else if([current isRightNode] && [parent isRightNode]) {
                [self leftRotateNode:gParent];
                RBColor temp = parent.color;
                parent.color = gParent.color;
                gParent.color = temp;
                break;
                
                // 😊情况4.4: 当前节点是父节点的左孩子，父节点是祖父节点的右孩子
                // 1.将父节点右旋 2.将父节点设为当前节点继续修正
            } else if ([current isLeftNode] && [parent isRightNode]) {
                [self rightRotateNode:parent];
                current = parent;
                continue;
                
            } else {
                break;
            }
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

// 删除的逻辑是通过交换，将要删除的节点中的值交换到叶子节点，然后只需要删除叶子节点，并做旋转变色即可.
-(void)removeNode:(RBNode *)node {
    
    // 😊情况1: node没有孩子，是叶子节点
    if (node.left == nil && node.right == nil) {
        if (node.color == RBRed) { // 1.1 如果node是红色，则直接删除即可
            [self releaseNode:node];
            
        } else {  // 1.2 如果node是黑色，则删除它会破坏平衡，需要进行旋转变色，然后删除节点
            [self rotateAndChangeColorWithNode:node];
            [self releaseNode:node];
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

/**
 旋转变色
 
 下面是和currentNode相关的一些节点的简称：
 P: currentNode的父节点
 W: currentNode的兄弟节点
 Nf: currentNode的远侄子
 Nn: currentNode的近侄子
*/

-(void)rotateAndChangeColorWithNode:(RBNode *)currentNode {
    
    // 😊情况1: currentNode是根，或者currentNode是红色，则直接将其变成黑色即可
    if (currentNode == self.rootNode || currentNode.color == RBRed) {
        currentNode.color = RBBlack;
        return;
    }
    
    // 这里，如果currentNode时黑色，则它一定有一个兄弟节点，不然就违背了红黑树每条通路上黑子数量相同的特质
    RBNode *w = [currentNode brother];
    RBNode *p = currentNode.parent;
    
    // 😊情况2: W是红色
    // 则将W设为黑色，P设为红色，对P进行旋转(currentNode是P的左节点时，左旋，currentNode是P的右节点时右旋);
    if (w.color == RBRed) {
        
        w.color = RBBlack;
        p.color = RBRed;
        
        if ([currentNode isLeftNode]) {
            [self leftRotateNode:p]; // 以P为支点进行左旋
        } else {
            [self rightRotateNode:p];// 以P为支点进行右旋
        }
        
        [self rotateAndChangeColorWithNode:currentNode];
        
    } else {
        // 😊情况3: W是黑色，且W的两个孩子都是黑色
        // 则将w设为红色，将P设为当前节点，继续进行旋转变色
        if ([w hasTwoBlackChild]) {
            w.color = RBRed;
            [self rotateAndChangeColorWithNode:p];
            
            // 😊情况4: W是黑色，Nf是红色
            // 则将W设为P的颜色，P和Nf设为黑色，并对P进行旋转(currentNode是P的左孩子就左旋，是右孩子就右旋)
        } else if ([currentNode nfIsRed]) {
            
            w.color = p.color;
            [currentNode nf].color = RBBlack;
            p.color = RBBlack;
            
            if ([currentNode isLeftNode]) {
                [self leftRotateNode:p]; // 以P为支点进行左旋
            } else {
                [self rightRotateNode:p];// 以P为支点进行右旋
            }
         
            // 😊情况5: W是黑色，Nf是黑色
            // 则交换W和Nn的颜色，并对W进行旋转(currentNode是P的左孩子则右旋，是右孩子则左旋)，旋转之后，继续旋转变色
        } else  {
            
            [w changeColorWithNode:[currentNode nn]];
            if ([currentNode isLeftNode]) {
                [self rightRotateNode:w]; // 以W为支点进行右旋
            } else {
                [self leftRotateNode:w];// 以W为支点进行左旋
            }
            
            [self rotateAndChangeColorWithNode:currentNode];
        }
    }
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
    
    node.right = rightNode.left;
    if (rightNode.left) {
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
        self.rootNode.parent = nil;
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
    node.left = leftNode.right;
    if (leftNode.right) {
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
        self.rootNode.parent = nil;
    }
    
    // 3. 将y的父节点改成x，将x的右节点变成y
    node.parent = leftNode;
    leftNode.right = node;
}


/******************************************************************/
#pragma mark - 工具方法
/******************************************************************/
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

// 查找后继节点中的最小节点，即右子树中最左的节点
-(RBNode *)searchPostMinNodeInRootNode:(RBNode *)node {
    
    RBNode *leftMiniNode = node.right;
    while (leftMiniNode.left != nil) {
        leftMiniNode = leftMiniNode.left;
    }
    return leftMiniNode;
}

// 释放节点
-(void)releaseNode:(RBNode *)node {
    if (node.parent) {
        if (node == node.parent.left) {
            node.parent.left = nil;
        } else {
            node.parent.right = nil;
        }
    }
    
    if (node == self.rootNode) {
        self.rootNode = nil;
    }
    node = nil;
}

@end
