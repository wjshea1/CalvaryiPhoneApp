//
//  CCBibleBookViewController.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/1/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCMenuItem.h"

@interface CCBibleBookViewController : UITableViewController
@property(weak, nonatomic) CCMenuItem *item;
@end

NSArray *bookArray;
