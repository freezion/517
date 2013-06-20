//
//  SearchViewController.h
//  OrderAssistant
//
//  Created by flybird on 12-10-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PopoverView.h"

@interface SearchViewController : ViewController<UINavigationBarDelegate,UINavigationControllerDelegate,UIApplicationDelegate,PopoverViewDelegate>{
    UIButton *totalBtn;
    UIButton *topButton;
        
    UIButton *bottomButton;
    
    UIButton *arrowButton;
    BOOL expanding;

}

@property(nonatomic,retain) IBOutlet  UIButton *totalBtn;
@property(nonatomic,retain) IBOutlet  UIButton *topButton;

@property (nonatomic, retain) IBOutlet UIButton *bottomButton;
@property (nonatomic, retain) IBOutlet UIButton *arrowButton;
@property (nonatomic) BOOL expanding;

- (IBAction)menuButton:(id)sender;

@end
