//
//  CCFeedImageStore.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/7/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCFeedImageStore : NSObject
{
    NSMutableDictionary* _dict;
}
+(CCFeedImageStore *) sharedStore;
-count;
-(UIImage *)getImageForURL:(NSString *)url;
@end
