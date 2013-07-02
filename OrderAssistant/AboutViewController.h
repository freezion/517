//
//  AboutViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-6-19.
//
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AboutViewController : UITableViewController<UIActionSheetDelegate>{
    UILabel *versionLbl;
    UIButton *exitButton;
}

@property (nonatomic, retain) IBOutlet UILabel *versionLbl;
@property (nonatomic, retain) IBOutlet UIButton *exitButton;
@property (nonatomic, retain) IBOutlet UITableViewCell *exitCell;

- (IBAction)exitPress:(id)sender;

@end
