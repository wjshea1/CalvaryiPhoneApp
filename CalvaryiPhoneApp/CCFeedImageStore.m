//
//  CCFeedImageStore.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/7/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCFeedImageStore.h"

@implementation CCFeedImageStore

- (id)init
{
    self = [super init];
    if (self) {
        _dict = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}
+(CCFeedImageStore *) sharedStore
{
    static CCFeedImageStore* sharedStore = nil;
    @synchronized(self) {
        if(sharedStore == nil){
            sharedStore = [[self alloc] init];
        }
        return sharedStore;
    }
    
}
-count
{
    
}
-(UIImage *)getImageForURL:(NSString *)url
{
    UIImage *img = [_dict objectForKey:url];
    if ( !img ) {
        // Retrieve Image
        img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        [_dict setObject:img forKey:url];
    }
    return img;
}

-(UIImage *)getImageForURL:(NSString *)url withCompletion: completion
{
    
}

@end
