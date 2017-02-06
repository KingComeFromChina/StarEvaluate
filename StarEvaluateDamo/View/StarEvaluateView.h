//
//  StarEvaluateView.h
//  StarEvaluateDamo
//
//  Created by 王垒 on 2017/2/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarEvaluateView : UIView

#pragma mark - 点击评价之后回调的星星数量

+ (instancetype)evaluationViewWithChooseStarBlock:(void(^)(NSInteger count))evaluationViewChoosedStarBlock;

/*
 *       space 星星之间的间距
 *       大小为：0~1，超过1则置为1
 *       space = 0.1，则间隙为星星的宽度的0.1倍，默认为0.5
 */

@property (nonatomic, assign) CGFloat space;

/*
 *       starCount 星星之间的间距
 *       大小为：1~5，超过5则置为5
 *       默认为5，如果输入值，则设置成需要的星星数
 */
@property (nonatomic, assign) NSUInteger starCount;

/*
 *       tapEnabled  取消选中✨的点击手势，关闭就不能点击
 */

@property (nonatomic, assign) BOOL tapEnabled;

@end
