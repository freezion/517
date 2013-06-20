//
//  ActivityIntroViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-4-23.
//
//

#import <UIKit/UIKit.h>
#import "ActivityEntity.h"

@interface ActivityIntroViewController : UIViewController<UITextViewDelegate>{
    UITextView *evenIntroTextView;
    ActivityEntity *activityEntity;
    UILabel *evenTitle;
}

@property (nonatomic, retain) IBOutlet UITextView *evenIntroTextView;
@property (nonatomic, retain) ActivityEntity *activityEntity;
@property (nonatomic, retain) IBOutlet UILabel *evenTitle;

@end
