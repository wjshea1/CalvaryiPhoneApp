//
//  CCStateManager.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/4/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SermonModel.h"

@interface CCStateManager : NSObject
{
    // History will provide user to see there playback history and allow us to restart at the last playpoint
    NSMutableDictionary *_history;
}
+(CCStateManager *)sharedManager;

@property(strong, nonatomic) SermonModel *currentItem;
@property(strong, nonatomic) AVPlayer *currentPlayer;


@end
