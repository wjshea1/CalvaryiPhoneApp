//
//  CCMainMenu.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/1/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCMenuItem.h"



@interface CCMainMenuStore : NSObject

{
    NSMutableArray *list;
}


+ (CCMainMenuStore *) sharedStore;
- (CCMenuItem *) getMenuItemAtIndex: (int) index;
- (int) getNumberOfMenuItems;


@end
