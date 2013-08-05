//
//  news.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/12/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "JSONModel.h"

@protocol NewsModel @end


@interface NewsModel : JSONModel
@property(strong, nonatomic) NSString *headline;
@property(strong, nonatomic) NSString *internetLink;
@property(strong, nonatomic) NSString *description;
@property(strong, nonatomic) NSDate   *publishDate;
@property(strong, nonatomic) NSString *imageLink;
@end
