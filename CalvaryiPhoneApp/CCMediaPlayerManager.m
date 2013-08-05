//
//  CCMediaPlayerManager.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/17/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCMediaPlayerManager.h"

@implementation CCMediaPlayerManager
{
    AVPlayer *_player;
}

- (id)init
{
    self = [super init];
    if (self) {
        _player = [[AVPlayer alloc] init];
    }
    return self;
}

+(CCMediaPlayerManager *) sharedManager
{
    static CCMediaPlayerManager *manager = nil;
    @synchronized(self) {
        if (!manager) {
            manager = [[CCMediaPlayerManager alloc] init];
        }
    }
    return manager;

    
}
-(AVPlayer *)getCurrentPlayer
{
    return _player;
}

@end
