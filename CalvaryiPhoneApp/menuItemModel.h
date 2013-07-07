//
//  menuItemModel.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/29/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "JSONModel.h"

@protocol MenuItemModel
@end

@interface MenuItemModel : JSONModel
@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *url;
@property (strong, nonatomic)NSString *image;
@property (strong, nonatomic)NSString *itemType;
@property (strong, nonatomic)NSString *data;

@end
