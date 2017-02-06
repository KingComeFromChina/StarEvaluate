//
//  StarEvaluateView.m
//  StarEvaluateDamo
//
//  Created by 王垒 on 2017/2/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import "StarEvaluateView.h"

typedef void(^EvaluationViewChoosedStarBlock)(NSUInteger count);

@interface StarEvaluateView ()

@property (nonatomic ,assign) NSUInteger index;
@property (nonatomic, copy)   EvaluationViewChoosedStarBlock evaluationViewChoosedStarBlock;

@end

@implementation StarEvaluateView

/**************首先初始化StarEvaluateView*************/

+ (instancetype)evaluationViewWithChooseStarBlock:(void (^)(NSInteger))evaluationViewChoosedStarBlock{

    StarEvaluateView *evaluationView = [[StarEvaluateView alloc] init];
    evaluationView.backgroundColor = [UIColor clearColor];
    evaluationView.evaluationViewChoosedStarBlock = ^(NSUInteger count) {
        if (evaluationViewChoosedStarBlock) {
            evaluationViewChoosedStarBlock(count);
        }
    };
    return evaluationView;
}

#pragma mark - 取值

- (void)setStarCount:(NSUInteger)starCount {
    if (starCount == 0) {
        return;
    }
    if (_starCount != starCount) {
        _starCount = starCount;
        if (starCount > 5) {
            starCount = 5;
        }
        self.index = starCount;
        [self setNeedsDisplay];
        if (self.evaluationViewChoosedStarBlock) {
            self.evaluationViewChoosedStarBlock(self.index);
        }
    }
}


- (void)setTapEnabled:(BOOL)tapEnabled {
    _tapEnabled = tapEnabled;
    self.userInteractionEnabled = tapEnabled;
}

- (void)setSpacing:(CGFloat)spacing {
    if (_space != spacing) {
        _space = spacing;
        [self setNeedsDisplay];
    }
}



#pragma mark - 画星星

/**************重写*************/
- (void)drawRect:(CGRect)rect {
    UIImage *norImage = [UIImage imageNamed:@"xing_w"];
    UIImage *selImage = [UIImage imageNamed:@"xing_x"];
    // 图片没间隙自己画
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 默认间隙为星星一半
    CGFloat spacing = self.frame.size.width / 20;
    CGFloat top = 0;
    CGFloat starWidth = spacing * 2;
    if (self.space != 0) {
        if (self.space > 1) {
            self.space = 1;
        }
        starWidth = self.frame.size.width / (self.space * 10 + 5);
        spacing = starWidth * self.space;
    }
    // 如果高度过高则居中
    if (self.frame.size.height > starWidth) {
        top = (self.frame.size.height - starWidth) / 2;
    }
    // 画图
    for (NSInteger i = 0; i < 5; i ++) {
        UIImage *drawImage = i < self.index ? selImage : norImage;
        [self drawImage:context CGImageRef:drawImage.CGImage CGRect:CGRectMake((i == 0) ? spacing : 2 * i * spacing + spacing + starWidth * i, top, starWidth, starWidth)];
    }
    // 瞬间画满,需要图片有间隙
    //CGContextDrawTiledImage(context, CGRectMake(0, 0, 30, 30), image.CGImage);
}

/**************将坐标翻转画图*************/
- (void)drawImage:(CGContextRef)context
       CGImageRef:(CGImageRef)image
           CGRect:(CGRect)rect {
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    CGContextDrawImage(context, rect, image);
    
    CGContextRestoreGState(context);
}


#pragma mark - TouchGestureMethod

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.index = point.x / (self.frame.size.width / 5) + 1;
    if (self.index == 6) {
        self.index --;
    }
    [self setNeedsDisplay];
    if (self.evaluationViewChoosedStarBlock) {
        self.evaluationViewChoosedStarBlock(self.index);
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}


@end
