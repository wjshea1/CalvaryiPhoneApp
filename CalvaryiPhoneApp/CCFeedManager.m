//
//  CCFeedManager.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/8/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCFeedManager.h"
#import "ccfeed.h"
#import "CCRecentFeed.h"
#import "JSONModelLib.h"  // You must include

@implementation CCFeedManager

- (id)init
{
    self = [super init];
    if (self) {
        // Need to allocate the dictionary
        _dict = [[NSMutableDictionary alloc] init];
        NSLog(@"Creating CCFeedManager");
       
    }
    return self;
}



+(CCFeedManager *)sharedManager
{
    static CCFeedManager *manager = nil;
    @synchronized(self) {
        if (!manager) {
            manager = [[CCFeedManager alloc] init];
        }
    }
    return manager;
}

-(void)getFeedWithURL:(NSString *)requestString
{
    dataLoaded = false;
    currentFeed = [[CCFeed alloc] initFromURLWithString:requestString
                                             completion:^(JSONModel *model, JSONModelError *err){
                                                 
                                                 NSLog(@"number items returned %d",currentFeed.sermons.count);
                                                 //[dict setObject:current forKey:requestString];
                                                 // Dont forget to do the completion thing otherwise
                                                 dataLoaded = true;
                                                                                                 
                                             }];

    
}

-(void)getFeedWithURL:(NSString *)requestString
     completion:(void (^)(void) )complete
{
    // Check to see if feed in dictionary
    
     dataLoaded = false;
    currentFeed = [[CCFeed alloc] initFromURLWithString:requestString
                                          completion:^(JSONModel *model, JSONModelError *err){
                                              
                                              NSLog(@"number items returned %d",currentFeed.sermons.count);
                                              //[dict setObject:current forKey:requestString];
                                              // Dont forget to do the completion thing otherwise
                                               dataLoaded = true;
                                              complete();
                                                                                           
                                          }];

    
    
    
    
}


-(int) getCurrentListCount
{
           NSLog(@"Number elements returned %d",[[currentFeed sermons]count]);
        return [[currentFeed sermons]count];
        
}
-(SermonModel *) objectInCurrentAtIndex:(NSUInteger)index
{
    return [[currentFeed sermons]objectAtIndex:index];
}

-(BOOL)isDataloaded
{
    return dataLoaded;
}

@end
