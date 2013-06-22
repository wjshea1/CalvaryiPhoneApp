//
//  CCNewsFeedManager.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/13/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCNewsFeedManager.h"
#import "jsonmodellib.h"

@implementation CCNewsFeedManager

- (id)init
{
    self = [super init];
    if (self) {
                
    }
    return self;
}

+(CCNewsFeedManager *) sharedManager
{
    static CCNewsFeedManager *manager = nil;
    @synchronized(self) {
        if (!manager) {
            manager = [[CCNewsFeedManager alloc] init];
        }
    }
    return manager;
}

-(void) getNewsWithUrl:(NSString *)requestString completion: (void (^)(void) )complete
{
    
    _feed = [[CCNewsFeed alloc] initFromURLWithString:requestString
                                             completion:^(JSONModel *model, JSONModelError *err){
                                                 
                                                 NSLog(@"number items returned %d",_feed.news.count);
                                                 //[dict setObject:current forKey:requestString];
                                                 // Dont forget to do the completion thing otherwise
                                                 complete();
                                                 
                                             }];

    
}
-(int) getCurrentListCount
{
    if ( _feed.news ) {
        return _feed.news.count;
    }
    return 0;
}
-(NewsModel*) objectInCurrentAtIndex:(NSUInteger)index
{
    // Wire this up later
    if ( _feed.news ) {
        return [_feed.news objectAtIndex:index];
    }
    return nil;
    
}

@end
