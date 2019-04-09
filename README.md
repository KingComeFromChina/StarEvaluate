# StarEvaluate
## 电商类五星好评实现Demo
### 效果图
![没有评价](http://upload-images.jianshu.io/upload_images/3873966-5fb3c73b8eb04582.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![五星好评](http://upload-images.jianshu.io/upload_images/3873966-b26e74a734e0bdda.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![最少评价至少为1](http://upload-images.jianshu.io/upload_images/3873966-fc06824010ee01b5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果需要的话，请移步我的[仓库](https://github.com/KingComeFromChina/StarEvaluate.git)clone下来后直接把<code>StarEvaluateView</code>拖入工程里就可以使用了

### Clone
`
git clone https://github.com/KingComeFromChina/StarEvaluate.git
`
### Use

首先把<code>StarEvaluateView</code>拖入工程，在你要使用的那个类的<code>controller</code>里导入头文件

`#import "StarEvaluateView.h"`

调用方法为
```
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

```
已经提供了接口，可以满足你的常规的自定义，如果帮到你了请点击右上角<code>
star</code>或左下角<code>喜欢</code>

