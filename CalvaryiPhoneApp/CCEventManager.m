//
//  CCEventManager.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/5/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCEventManager.h"
#import "EventsModel.h"
#import "JSONModelLib.h"

@implementation CCEventManager
+(CCEventManager *)sharedManger
{
    static CCEventManager *manager = nil;
    @synchronized(self) {
        if (!manager) {
            manager = [[CCEventManager alloc] init];
        }
    }
    return manager;
   
}
-(int) count
{
    return list.events.count;
    
}
-(EventModel *)getObjectAtIndex:( NSUInteger )index
{
    return [list.events objectAtIndex:index];
}

-(void)getEventsWithURLString:(NSString *) URLString withCompletion:(void (^)(void) )complete
{
    
    list = [[EventsModel alloc] initFromURLWithString:URLString
                                             completion:^(JSONModel *model, JSONModelError *err){
                                                 
                                                 NSLog(@"number items returned %d",list.events.count);
                                                
                                                 complete();
                                                 
                                             }];
    
    

    
}
@end
