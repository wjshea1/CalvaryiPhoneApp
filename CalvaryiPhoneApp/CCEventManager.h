//
//  CCEventManager.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/5/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventsModel.h"

@interface CCEventManager : NSObject
{
    EventsModel *list;
}

+(CCEventManager *)sharedManger;
-(int) count;
-(EventModel *)getObjectAtIndex:( NSUInteger )index;

-(void)getEventsWithURLString:(NSString *) URLString withCompletion:(void (^)(void) )complete;
@end
