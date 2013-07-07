//
//  CCEventsDetailViewController.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/6/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"

@interface CCEventsDetailViewController : UIViewController
@property(strong, nonatomic) EventModel *item;
@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
- (IBAction)addToCalendarAction:(id)sender;
@end
