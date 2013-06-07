//
//  CCRecentFeed.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/5/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "JSONModel.h"
#import "SermonModel.h"

@interface CCRecentFeed : JSONModel

@property (strong, nonatomic) NSArray<SermonModel> *sermons;

@end
