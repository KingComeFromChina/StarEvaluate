//
//  EvaluateViewController.m
//  StarEvaluateDamo
//
//  Created by 王垒 on 2017/2/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import "EvaluateViewController.h"
#import "StarEvaluateView.h"

#define WLWindowWidth ([[UIScreen mainScreen] bounds].size.width)
@interface EvaluateViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (nonatomic, assign) NSUInteger starCount;

@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"评价";
    [self initStarView];
}

- (void)initStarView{

    // 注意weakSelf
    __weak __typeof(self)weakSelf = self;
    
    // 初始化
    StarEvaluateView *starEvaluateView = [StarEvaluateView evaluationViewWithChooseStarBlock:^(NSInteger count) {
        weakSelf.starCount = count;
        NSLog(@"星星数量=====%lu",(unsigned long)_starCount);
    }];
                                          
    
    
    starEvaluateView.frame = CGRectMake(0, 0, WLWindowWidth-130, 100);
    [self.starView addSubview:starEvaluateView];
    
    // 设置展示的星星数量
    // starEvaluateView.starCount = 3;
    
    // 星星之间的间距，默认0.5
    // starEvaluateView.space = 0.5;
    
    // 星星的点击事件使能,默认YES
    // starEvaluateView.tapEnabled = NO;

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    _rightLabel.text = [NSString stringWithFormat:@"%lu/140    ",(unsigned long)_contentTV.text.length];
    if (_contentTV.text.length > 0) {
        self.placeLabel.hidden = YES;
    }else{
        
        self.placeLabel.hidden = NO;
    }
    if (_contentTV.text.length > 140) {
        _rightLabel.textColor = [UIColor redColor];
    }
    else{
        _rightLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    
    
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    _rightLabel.text = [NSString stringWithFormat:@"%lu/140    ",(unsigned long)_contentTV.text.length];
    if (_contentTV.text.length > 0) {
        self.placeLabel.hidden = YES;
    }else{
        
        self.placeLabel.hidden = NO;
    }
    
    if (_contentTV.text.length > 140) {
        _rightLabel.textColor = [UIColor redColor];
    }
    else{
        _rightLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    
}


- (IBAction)sendEvaluation:(id)sender {
     [self.contentTV resignFirstResponder];
    // 注意weakSelf
    __weak __typeof(self)weakSelf = self;
    NSLog(@"%lu星好评 评价内容是：%@",(unsigned long)weakSelf.starCount,weakSelf.contentTV.text);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
