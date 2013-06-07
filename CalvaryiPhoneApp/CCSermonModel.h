//
//  CCSermonModel.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/5/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@protocol CCSermonModel @end

@interface CCSermonModel : JSONModel
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *summary;
@property(strong, nonatomic) NSString *audioFileLocation;
@property(strong, nonatomic) NSString *imageFileLocation;


@end
