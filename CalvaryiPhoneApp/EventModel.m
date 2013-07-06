//
//  EventModel.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/5/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "EventModel.h"

@implementation EventModel


-(NSString *)formatDateString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd"];
    NSString *dateString = [format stringFromDate:_eventDate];
    return dateString;
}



@end
