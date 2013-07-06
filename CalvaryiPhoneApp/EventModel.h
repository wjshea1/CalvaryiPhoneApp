//
//  EventModel.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/5/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "JSONModel.h"

@protocol EventModel @end

@interface EventModel : JSONModel
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *description;
@property(strong, nonatomic) NSDate *eventDate;
@property(strong, nonatomic) NSString *eventDuration;
@property(strong, nonatomic) NSString *eventTime;
@property(strong, nonatomic) NSString *imageURL;
@property(strong, nonatomic) NSString *internetLink;
@property(strong, nonatomic) NSString *location;


-(NSString *)formatDateString;
@end
