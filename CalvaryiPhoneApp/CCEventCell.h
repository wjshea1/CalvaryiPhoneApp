//
//  CCEventCell.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/5/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCEventCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;


@end
