//
//  RBTree.h
//  Algorithm
//
//  Created by ArcherLj on 2019/8/26.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RBColor) {
    RBRed = 100,
    RBBlack
};


/******************************************************************/
#pragma mark - 红黑树节点
/******************************************************************/
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

-(BOOL)hasNoChild; // 该节点没有孩子
-(BOOL)hasOneChild; // 该节点只有一个孩子
-(BOOL)hasTwoChild; // 该节点有两个孩子
-(BOOL)hasTwoBlackChild; // 有两个黑孩子

-(BOOL)isLeftNode; // 该节点是否是父节点的左孩子
-(BOOL)isRightNode; // 该节点是否是父节点的右孩子

-(RBNode *)nf; // 获取远侄子节点
-(RBNode *)nn; // 获取近侄子节点
-(RBNode *)brother; // 获取兄弟节点
-(RBNode *)uncle; // 获取叔叔节点

-(BOOL)isBlack;   // 该节点是否是黑色
-(BOOL)isRed;     // 该节点是否是红色
-(BOOL)nfIsBlack; // 远侄子节点是否是黑色
-(BOOL)nfIsRed;   // 远侄子节点是否是红色
-(BOOL)nnIsBlack; // 近侄子节点是否是黑色
-(BOOL)nnIsRed;   // 近侄子节点是否是红色

-(void)changeColorWithNode:(RBNode *)node; // 和node节点交换颜色

@end


/******************************************************************/
#pragma mark - 红黑树
/******************************************************************/
@interface RBTree : NSObject

-(instancetype)initWithArr:(NSArray *)arr;

// 向红-黑树中插入项目
-(void)insert:(NSInteger)value;

// 删除红-黑树中的项目
-(void)remove:(NSInteger)value;

// 将node节点左旋
-(void)leftRotateNode:(RBNode *)node;

// 将node节点右旋
-(void)rightRotateNode:(RBNode *)node;

@end
