//
//  CCMenuItem.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/1/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCMenuItem : NSObject

@property (weak, nonatomic) NSString *name;
@property ( weak, nonatomic ) NSString *description;
@property (weak, nonatomic) UIImage *image;
@property (nonatomic) BOOL requiresBooksOfTheBible;
@property (weak,nonatomic) NSString *requestUrl;

-(id) initWithName: (NSString *) name
   WithDescription: (NSString *) description
         WithImage: (NSString *)image
WithRequiresBookOfTheBible: (BOOL) reqbb
WithRequestUrl:(NSString *) requestUrl;

@end
