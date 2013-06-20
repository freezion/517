//
//  IntroViewController.h
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-9.
//
//

#import <UIKit/UIKit.h>

@protocol IntroViewDelegate <NSObject> 
- (void) agreeMentPress:(int) type;
@end

@interface IntroViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIButton *btnAgree;
@property (nonatomic, retain) IBOutlet UIButton *btnDisagree;
@property (nonatomic, retain) id<IntroViewDelegate> delegate;

- (void)buttonPressd:(id)sender;

@end
