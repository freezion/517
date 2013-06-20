//
//  ActivityIntroViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-4-23.
//
//

#import "ActivityIntroViewController.h"

@implementation ActivityIntroViewController
@synthesize activityEntity;
@synthesize evenIntroTextView;
@synthesize evenTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"活动介绍";
	
    evenTitle.text=activityEntity.eventName;
    evenIntroTextView.text=activityEntity.eventIntro;
    self.evenIntroTextView.scrollEnabled = YES;//是否可以拖动
    self.evenIntroTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
   // self.evenIntroTextView.font = [UIFont fontWithName:@"Kailasa" size:15.0];//设置字体名字和字体大小
    
    self.evenIntroTextView.editable = NO;//设置文字内容不可编辑
    
    
}
@end
