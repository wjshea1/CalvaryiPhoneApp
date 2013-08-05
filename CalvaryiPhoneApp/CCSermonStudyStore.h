//
//  CCSermonStudyStore.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/5/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCSermonModel.h"
#import "CCRecentFeed.h"

@interface CCSermonStudyStore : NSObject

{
    // This will eventually be a NSMutableArray
    CCRecentFeed * _list;
    NSMutableDictionary *_dict;
    
}

@property(nonatomic) bool loaded;

// Need to figure out the best way to handle this i should probably use a block pased in by the parent on completion
+ (CCSermonStudyStore *) sharedStoreWithView:(UIView *)parent;
- (SermonModel  *) getMenuItemAtIndex: (int) index;
- (int) getNumberOfItems;



-(NSString *)getJSONResponse;

@end
