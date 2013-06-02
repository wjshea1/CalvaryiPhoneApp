//
//  CCMainMenu.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/1/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCMainMenuStore.h"
#import "CCMenuItem.h"

@implementation CCMainMenuStore

- (id)init
{
    self = [super init];
    if (self) {
        // Load default Menus Here
        CCMenuItem *item = [[CCMenuItem alloc] initWithName:@"Recent Messages" WithDescription:@"The 5 must recent studies" WithImage:@"" WithRequiresBookOfTheBible:FALSE WithRequestUrl:@""];
        CCMenuItem *item2 = [[CCMenuItem alloc] initWithName:@"Verse by Verse" WithDescription:@"Verse by Verse Studies" WithImage:@"" WithRequiresBookOfTheBible:TRUE WithRequestUrl:@""];
        CCMenuItem *item3 = [[CCMenuItem alloc] initWithName:@"Featured Messages" WithDescription:@"Verse by Verse Studies" WithImage:@"" WithRequiresBookOfTheBible:FALSE WithRequestUrl:@""];
        CCMenuItem *item4 = [[CCMenuItem alloc] initWithName:@"Guest Speakers" WithDescription:@"Verse by Verse Studies" WithImage:@"" WithRequiresBookOfTheBible:FALSE WithRequestUrl:@""];
        
        
        list = [@[
            item,
            item2,
            item3,
            item4
        ] mutableCopy];
        
        
        
    }
    return self;
}


+ (CCMainMenuStore *) sharedStore
{
    static CCMainMenuStore *sharedMyManager = nil;
    @synchronized(self) {
        if(sharedMyManager == nil){
            sharedMyManager = [[self alloc] init];
        }
        return sharedMyManager;
    }

    
}
- (CCMenuItem *) getMenuItemAtIndex: (int) index
{
    return [list objectAtIndex:index] ;
    
}
- (int) getNumberOfMenuItems
{
    return [list count];
}
@end
