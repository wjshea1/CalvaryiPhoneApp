//
//  CCFirstViewController.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 5/24/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCFirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
