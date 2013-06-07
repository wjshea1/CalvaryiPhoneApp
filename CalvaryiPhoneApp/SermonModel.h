//
//  SermonModel.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/6/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "JSONModel.h"

@protocol SermonModel @end

@interface SermonModel : JSONModel

@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *summary;
@property(strong, nonatomic) NSString *audioFileLocation;
@property(strong, nonatomic) NSString *imageFileLocation;



@end
