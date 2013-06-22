//
//  CCNewsFeedManager.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/13/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCNewsFeed.h"

@interface CCNewsFeedManager : NSObject
{
    CCNewsFeed *_feed;
}

+(CCNewsFeedManager *)sharedManager;

-(void) getNewsWithUrl:(NSString *)requestString completion: (void (^)(void) )complete;
-(int) getCurrentListCount;
-(NewsModel*) objectInCurrentAtIndex:(NSUInteger)index;


@end
