//
//  EventsModel.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/5/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "JSONModel.h"
#import "EventModel.h"

@interface EventsModel : JSONModel

@property (strong, nonatomic) NSArray<EventModel> *events;

@end
