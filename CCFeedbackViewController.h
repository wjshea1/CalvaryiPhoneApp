//
//  CCFeedbackViewController.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/20/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCFeedbackViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *questionText;
@property (strong, nonatomic) IBOutlet UITextView *answerTextView;
- (IBAction)sendFeedback:(id)sender;
- (IBAction)cancelBtn:(id)sender;

@end
