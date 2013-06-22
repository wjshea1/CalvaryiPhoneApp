//
//  CCNewsFeed.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/12/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//
#import "JSONModel.h"
#import "NewsModel.h"


@interface CCNewsFeed : JSONModel

@property (strong, nonatomic) NSArray<NewsModel> *news;



@end
