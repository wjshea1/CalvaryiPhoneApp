//
//  CCNewsDetailViewController.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/21/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface CCNewsDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *headline;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
- (IBAction)clickShareButton:(id)sender;
@property (weak, nonatomic) NewsModel *item;
- (IBAction)clickLearnMoreAction:(id)sender;

@end
