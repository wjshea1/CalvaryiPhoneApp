//
//  CCMenuItemManager.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/29/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItemsModel.h"

@interface CCMenuItemManager : NSObject
{
    NSMutableDictionary* _dict;
}

+(CCMenuItemManager *)sharedManager;

-(MenuItemsModel *)getMenuItemsWithMenuName: (NSString *) menuName completion: (void (^)(void) )complete;
-(MenuItemsModel *)getMenuItemsWithMenuName:(NSString *)menuName;

@end
