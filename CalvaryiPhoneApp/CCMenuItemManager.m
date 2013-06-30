		//
//  CCMenuItemManager.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/29/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCMenuItemManager.h"
#import "jsonmodellib.h"

@implementation CCMenuItemManager

- (id)init
{
    self = [super init];
    if (self) {
        _dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+(CCMenuItemManager *)sharedManager
{
    // I use the pattern too much
    
         static CCMenuItemManager *manager = nil;
        @synchronized(self) {
            if (!manager) {
                manager = [[CCMenuItemManager alloc] init];
            }
        }
        return manager;
}


-(MenuItemsModel *)getMenuItemsWithMenuName: (NSString *) menuName  completion: (void (^)(void) )complete 
{
    MenuItemsModel *items = [_dict objectForKey:menuName];
    if ( !items ) {
        items = [[MenuItemsModel alloc] initFromURLWithString:@"http://calvary.cfapps.io/feeds/menu/1"
                                               completion:^(JSONModel *model, JSONModelError *err){
                                                   
                                                   //NSLog(@"number items returned %d",model._menus.count);
                                                   [_dict setObject:model forKey:@"more"];
                                                   // Dont forget to do the completion thing otherwise
                                                    complete();
                                                   
                                               }];
    }
    return items;
        
}

-(MenuItemsModel *)getMenuItemsWithMenuName:(NSString *)menuName
{
    MenuItemsModel *items = [_dict objectForKey:menuName];
    return items;
}

@end
