//
//  CCMenuItem.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/1/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCMenuItem.h"

@implementation CCMenuItem
-(id) initWithName: (NSString *) name
   WithDescription: (NSString *) description
         WithImage: (NSString *)image
WithRequiresBookOfTheBible: (BOOL) reqbb
    WithRequestUrl:(NSString *) requestUrl

{
    self = [super init];
    if ( self){
        
        [self setName:name];
        [self setDescription:description];
        [self setRequiresBooksOfTheBible:reqbb];
        [self setRequestUrl:requestUrl];
        
        
    }

    
    // Dont set Image for now because we need to load the image we save that for later
    return self;
}


@end
