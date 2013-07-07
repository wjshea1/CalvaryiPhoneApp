//
//  CCMoreViewController.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/26/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCMenuItemManager.h"

@interface CCMoreViewController : UITableViewController
{
    CCMenuItemManager *myManager;
}
- (IBAction)feedbackAction:(id)sender;


@end
