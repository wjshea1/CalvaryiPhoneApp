//
//  CCStudiesStore.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 5/26/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCStudies.h"

@interface CCStudiesStore : NSObject
{
    NSMutableArray *list;
}


+ (CCStudiesStore *) sharedStore;
- (CCStudies  *) getMenuItemAtIndex: (int) index;
- (int) getNumberOfItems;




@end
