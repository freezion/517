//
//  ResIntroViewController.h
//  OrderAssistant
//
//  Created by flybird on 12-11-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResEntity.h"

@interface ResIntroViewController : UIViewController<UITextViewDelegate>{
    UITextView *resIntroTextView;
    ResEntity *resEntity;
    UIImageView *nocontImageView;
    
    
}

@property (nonatomic, retain) IBOutlet UITextView *resIntroTextView;
@property (nonatomic, retain) ResEntity *resEntity;
@property (nonatomic, retain) IBOutlet UIImageView *nocontImageView;



@end
