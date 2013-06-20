//
//  GuideViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-5-23.
//
//

#import "GuideViewController.h"
#import "MainViewController.h"

@implementation GuideViewController

@synthesize guideImageView;
@synthesize guidePageControl;
@synthesize guideScrollView;


- (void) viewDidLoad{
    [super viewDidLoad];
//    if (iphone5) {
//        guideViewController.guideImageView.frame = CGRectMake(0, 20, 320, 568);
//    }else{
//        guideViewController.guideImageView.frame = CGRectMake(0, 20, 320, 460);
//    }
    
    //设置ScrollView的整体触摸与显示区域
    //注意 宽 高不要超过 320X480
    //否则会出现无法滚动的情况
    //guideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320,480)];

    //设置ScrollView滚动内容的区域
    //它通常是需要大于ScrollerView的显示区域的
    //这样才有必要在ScrollerView中滚动它
    [guideScrollView setContentSize:CGSizeMake(320 * 4, 240)];

    //开启滚动分页功能，如果不需要这个功能关闭即可
    [guideScrollView setPagingEnabled:YES];
    
    //隐藏横向与纵向的滚动条
    [guideScrollView setShowsVerticalScrollIndicator:NO];
    [guideScrollView setShowsHorizontalScrollIndicator:NO];
    //在本类中代理scrollView的整体事件

    [guideScrollView setDelegate:self];
  
    for (int i =0; i<4; i++)
      
    {
        //在这里给每一个ScrollView添加一个图片 和一个按钮
        UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(i * 320,0,320,480)];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"guide%d",i+1]]];
        //[UIImage imageNamed:[NSString stringwithFormat:@"guide%d",i]]
        //把每页需要显示的VIEW添加进ScrollerView中
        [guideScrollView addSubview:imageView];
   
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
    [button setTitle:@"开始体验" forState:UIControlStateNormal];
    //button.titleLabel.font=[UIColor redColor];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setFrame:CGRectMake(1060, 380, 120, 37)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [guideScrollView addSubview:button];
    
    //整体再将ScrollerView显示在窗口中
    [self.view addSubview:guideScrollView];
    //页面控制小工具
    //它会在底部绘制小圆点标志当前显示页面
    guidePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 440,self.view.frame.size.width, 20)];   
    //设置页面的数量  
    [guidePageControl setNumberOfPages:4];
    //监听页面是否发生改变
    //[guidePageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:guidePageControl];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = fabs(scrollView.contentOffset.x) /scrollView.frame.size.width;
    guidePageControl.currentPage = index;
}

- (void) buttonClick{
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    MainViewController *mainViewController= [storyborad instantiateViewControllerWithIdentifier:@"MainViewController"];
    UINavigationController *navMainViewController=[[UINavigationController alloc] initWithRootViewController:mainViewController];
    
    [self presentModalViewController:navMainViewController animated:NO];
    
}
@end
