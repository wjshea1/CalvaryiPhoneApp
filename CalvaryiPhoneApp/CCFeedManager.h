//
//  CCFeedManager.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/8/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCFeed.h"

@interface CCFeedManager : NSObject
{
    CCFeed *currentFeed;
    NSMutableDictionary *_dict;
    BOOL dataLoaded;
}
// The feed manager will maintain all the feed data for the application




+(CCFeedManager *)sharedManager;

-(void)getFeedWithURL:(NSString *)requestString;
-(void)getFeedWithURL:(NSString *)requestString
        completion:(void (^)(void) )completion;
-(int) getCurrentListCount;
-(SermonModel*) objectInCurrentAtIndex:(NSUInteger)index;
@end
