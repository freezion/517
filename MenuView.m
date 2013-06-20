//
//  MenuView.m
//  OrderAssistant
//
//  Created by 潘 群 on 12-11-9.
//
//

#import "MenuView.h"

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // Since the buttons can be any width we use a thin image with a stretchable center point
    UIImage *buttonImage = [UIImage imageNamed:@"frame_func_1.png"];
    UIImage *buttonPressedImage = [UIImage imageNamed:@"frame_func_1_hl.png"];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    CGRect buttonFrame = [button frame];
    buttonFrame.origin.x = 70;
    buttonFrame.origin.y = 0;
    buttonFrame.size.width = buttonImage.size.width;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    [button addTarget:self action:@selector(showOrderRestaurant:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UIButton *buttonNear = [UIButton buttonWithType:UIButtonTypeCustom];
    // Since the buttons can be any width we use a thin image with a stretchable center point
    UIImage *buttonNearImage = [UIImage imageNamed:@"frame_func_5.png"];
    UIImage *buttonNearPressedImage = [UIImage imageNamed:@"frame_func_5_hl.png"];
    [buttonNear setBackgroundImage:buttonNearImage forState:UIControlStateNormal];
    [buttonNear setBackgroundImage:buttonNearPressedImage forState:UIControlStateHighlighted];
    CGRect buttonNearFrame = [buttonNear frame];
    buttonNearFrame.origin.x = 0;
    buttonNearFrame.origin.y = 40;
    buttonNearFrame.size.width = buttonNearImage.size.width;
    buttonNearFrame.size.height = buttonNearImage.size.height;
    [buttonNear setFrame:buttonNearFrame];
    [buttonNear addTarget:self action:@selector(showOrderRestaurant:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonNear];
    
    UIButton *buttonTakePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    // Since the buttons can be any width we use a thin image with a stretchable center point
    UIImage *buttonTakePhotoImage = [UIImage imageNamed:@"frame_func_4.png"];
    UIImage *buttonTakePhotoPressedImage = [UIImage imageNamed:@"frame_func_4_hl.png"];
    [buttonTakePhoto setBackgroundImage:buttonTakePhotoImage forState:UIControlStateNormal];
    [buttonTakePhoto setBackgroundImage:buttonTakePhotoPressedImage forState:UIControlStateHighlighted];
    CGRect buttonTakePhotoFrame = [buttonTakePhoto frame];
    buttonTakePhotoFrame.origin.x = 180;
    buttonTakePhotoFrame.origin.y = 40;
    buttonTakePhotoFrame.size.width = buttonTakePhotoImage.size.width;
    buttonTakePhotoFrame.size.height = buttonTakePhotoImage.size.height;
    [buttonTakePhoto setFrame:buttonTakePhotoFrame];
    [buttonTakePhoto addTarget:self action:@selector(showOrderRestaurant:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonTakePhoto];
    
    UIButton *buttonSMS = [UIButton buttonWithType:UIButtonTypeCustom];
    // Since the buttons can be any width we use a thin image with a stretchable center point
    UIImage *buttonSMSImage = [UIImage imageNamed:@"frame_func_3.png"];
    UIImage *buttonSMSPressedImage = [UIImage imageNamed:@"frame_func_3_hl.png"];
    [buttonSMS setBackgroundImage:buttonSMSImage forState:UIControlStateNormal];
    [buttonSMS setBackgroundImage:buttonSMSPressedImage forState:UIControlStateHighlighted];
    CGRect buttonSMSFrame = [buttonSMS frame];
    buttonSMSFrame.origin.x = 0;
    buttonSMSFrame.origin.y = 80;
    buttonSMSFrame.size.width = buttonSMSImage.size.width;
    buttonSMSFrame.size.height = buttonSMSImage.size.height;
    [buttonSMS setFrame:buttonSMSFrame];
    [buttonSMS addTarget:self action:@selector(showOrderRestaurant:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonSMS];
    
    UIButton *buttonUser = [UIButton buttonWithType:UIButtonTypeCustom];
    // Since the buttons can be any width we use a thin image with a stretchable center point
    UIImage *buttonUserImage = [UIImage imageNamed:@"frame_func_8.png"];
    UIImage *buttonUserPressedImage = [UIImage imageNamed:@"frame_func_8_hl.png"];
    [buttonUser setBackgroundImage:buttonUserImage forState:UIControlStateNormal];
    [buttonUser setBackgroundImage:buttonUserPressedImage forState:UIControlStateHighlighted];
    CGRect buttonUserFrame = [buttonUser frame];
    buttonUserFrame.origin.x = 170;
    buttonUserFrame.origin.y = 80;
    buttonUserFrame.size.width = buttonUserImage.size.width;
    buttonUserFrame.size.height = buttonUserImage.size.height;
    [buttonUser setFrame:buttonUserFrame];
    [buttonUser addTarget:self action:@selector(showOrderRestaurant:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonUser];
    
    
    UIButton *buttonVoice = [UIButton buttonWithType:UIButtonTypeCustom];
    // Since the buttons can be any width we use a thin image with a stretchable center point
    UIImage *buttonVoiceImage = [UIImage imageNamed:@"frame_func_9.png"];
    UIImage *buttonVoicePressedImage = [UIImage imageNamed:@"frame_func_9_hl.png"];
    [buttonVoice setBackgroundImage:buttonVoiceImage forState:UIControlStateNormal];
    [buttonVoice setBackgroundImage:buttonVoicePressedImage forState:UIControlStateHighlighted];
    CGRect buttonVoiceFrame = [buttonVoice frame];
    buttonVoiceFrame.origin.x = 110;
    buttonVoiceFrame.origin.y = 50;
    buttonVoiceFrame.size.width = buttonVoiceImage.size.width;
    buttonVoiceFrame.size.height = buttonVoiceImage.size.height;
    [buttonVoice setFrame:buttonVoiceFrame];
    [buttonVoice addTarget:self action:@selector(showOrderRestaurant:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonVoice];
}

- (void) showOrderRestaurant:(id) sender {
    
}

@end
