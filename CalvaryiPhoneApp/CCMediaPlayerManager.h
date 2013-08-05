//
//  CCMediaPlayerManager.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/17/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface CCMediaPlayerManager : NSObject
+(CCMediaPlayerManager *) sharedManager;
-(AVPlayer *)getCurrentPlayer;


@end
