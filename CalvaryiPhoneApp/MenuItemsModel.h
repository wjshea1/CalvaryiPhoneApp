//
//  MenuItemsModel.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/29/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "jsonmodel.h"
#import "menuItemModel.h"

@interface MenuItemsModel : JSONModel
//@property (strong, nonatomic) NSString* success;
@property (strong, nonatomic) NSArray <MenuItemModel> *menus;

@end
