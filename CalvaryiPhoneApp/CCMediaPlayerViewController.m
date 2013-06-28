//
//  CCMediaPlayerViewController.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/9/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCMediaPlayerViewController.h"
#import "CCFeedImageStore.h"
/* Asset keys */
NSString * const kTracksKey         = @"tracks";
NSString * const kPlayableKey		= @"playable";

/* PlayerItem keys */
NSString * const kStatusKey         = @"status";

/* AVPlayer keys */
NSString * const kRateKey			= @"rate";
NSString * const kCurrentItemKey	= @"currentItem";


@interface CCMediaPlayerViewController ()
- (CMTime)playerItemDuration;
- (void)removePlayerTimeObserver;

@end

@implementation CCMediaPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad

{
    
    [super viewDidLoad];
    [_titleTrack setText:_item.title];
    [_summary setText:_item.summary];
    _isPlaying = false;
    
    
    // GetImage
    
    CCFeedImageStore *myStore = [CCFeedImageStore sharedStore];
    UIImage *image = [myStore getImageForURL:_item.imageFileLocation];
    [[self imageViewAlbumArt] setImage:image];
    
    NSLog(@"play file %@", _item.audioFileLocation);
    NSURL *url = [[NSURL alloc] initWithString:_item.audioFileLocation];
    
    _streamingPlayer = [[AVPlayer alloc] initWithURL:url];

    
       

    
    
}

-(void)viewDidAppear:(BOOL)animated
{
	// Do any additional setup after loading the view.
 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButtonBack:(id)sender {
    if ( _streamingPlayer) {
        CMTime currentTime = [_streamingPlayer currentTime];
        currentTime.value -= (30 * currentTime.timescale);
        
        [_streamingPlayer seekToTime:currentTime];
        
    }
}

- (IBAction)pressButtonPlayPause:(id)sender {
    
    static bool isPlaying = false;
    if ( !isPlaying ){
        [_streamingPlayer play];
        isPlaying = true;
    } else {
        [_streamingPlayer pause];
        isPlaying = false;
    }
    
    
    
    
/*
    _myAudioPlayer = [[AVAudioPlayer alloc] initWithData:_objectData error:&errorAudioPlayer];
    [_myAudioPlayer prepareToPlay];
    if (!_myAudioPlayer) {
        NSLog(@"Error Loading File %@", errorAudioPlayer.description);
    }
    [_myAudioPlayer play];
 
 */

    
    
}

- (IBAction)pressButtonForward:(id)sender {
    if ( _streamingPlayer) {
        CMTime currentTime = [_streamingPlayer currentTime];
        currentTime.value += (30 * currentTime.timescale);
        
        [_streamingPlayer seekToTime:currentTime];
        
    }
}

- (IBAction)beginScrub:(id)sender {
}

- (IBAction)endScrub:(id)sender {
}
-(void)initScrubberTimer
{
	double interval = .1f;
	
	CMTime playerDuration = [self playerItemDuration];
	if (CMTIME_IS_INVALID(playerDuration))
	{
		return;
	}
	double duration = CMTimeGetSeconds(playerDuration);
	if (isfinite(duration))
	{
		CGFloat width = CGRectGetWidth([self.scrubber bounds]);
		interval = 0.5f * duration / width;
	}
    
	/* Update the scrubber during normal playback. */
	mTimeObserver = [self.streamingPlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC)
                                                                queue:NULL /* If you pass NULL, the main queue is used. */
                                                           usingBlock:^(CMTime time)
                      {
                          [self syncScrubber];
                      }];
    
}


/* Set the scrubber based on the player current time. */
- (void)syncScrubber
{
	CMTime playerDuration = [self playerItemDuration];
	if (CMTIME_IS_INVALID(playerDuration))
	{
		_scrubber.minimumValue = 0.0;
		return;
	}
    
	double duration = CMTimeGetSeconds(playerDuration);
	if (isfinite(duration))
	{
		float minValue = [self.scrubber minimumValue];
		float maxValue = [self.scrubber maximumValue];
		double time = CMTimeGetSeconds([self.streamingPlayer currentTime]);
		
		[self.scrubber setValue:(maxValue - minValue) * time / duration + minValue];
	}
}

/* The user is dragging the movie controller thumb to scrub through the movie. */
- (IBAction)beginScrubbing:(id)sender
{
	mRestoreAfterScrubbingRate = [self.streamingPlayer rate];
	[self.streamingPlayer setRate:0.f];
	
	/* Remove previous timer. */
	[self removePlayerTimeObserver];
}

/* Set the player current time to match the scrubber position. */
- (IBAction)scrub:(id)sender
{
	if ([sender isKindOfClass:[UISlider class]])
	{
		UISlider* slider = sender;
		
		CMTime playerDuration = [self playerItemDuration];
		if (CMTIME_IS_INVALID(playerDuration)) {
			return;
		}
		
		double duration = CMTimeGetSeconds(playerDuration);
		if (isfinite(duration))
		{
			float minValue = [slider minimumValue];
			float maxValue = [slider maximumValue];
			float value = [slider value];
			
			double time = duration * (value - minValue) / (maxValue - minValue);
			
			[self.streamingPlayer seekToTime:CMTimeMakeWithSeconds(time, NSEC_PER_SEC)];
		}
	}
}

/* The user has released the movie thumb control to stop scrubbing through the movie. */
- (IBAction)endScrubbing:(id)sender
{
	if (!mTimeObserver)
	{
		CMTime playerDuration = [self playerItemDuration];
		if (CMTIME_IS_INVALID(playerDuration))
		{
			return;
		}
		
		double duration = CMTimeGetSeconds(playerDuration);
		if (isfinite(duration))
		{
			CGFloat width = CGRectGetWidth([self.scrubber bounds]);
			double tolerance = 0.5f * duration / width;
            
			mTimeObserver = [self.streamingPlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(tolerance, NSEC_PER_SEC) queue:NULL usingBlock:
                              ^(CMTime time)
                              {
                                  [self syncScrubber];  // Fix this issue
                              }];
		}
	}
    
	if (mRestoreAfterScrubbingRate)
	{
		[self.streamingPlayer setRate:mRestoreAfterScrubbingRate];
		mRestoreAfterScrubbingRate = 0.f;
	}
}

- (BOOL)isScrubbing
{
	return mRestoreAfterScrubbingRate != 0.f;
}

-(void)enableScrubber
{
    self.scrubber.enabled = YES;
}

-(void)disableScrubber
{
    self.scrubber.enabled = NO;
}

- (CMTime)playerItemDuration
{
	AVPlayerItem *playerItem = [self.streamingPlayer currentItem];
	if (playerItem.status == AVPlayerItemStatusReadyToPlay)
	{
        /*
         NOTE:
         Because of the dynamic nature of HTTP Live Streaming Media, the best practice
         for obtaining the duration of an AVPlayerItem object has changed in iOS 4.3.
         Prior to iOS 4.3, you would obtain the duration of a player item by fetching
         the value of the duration property of its associated AVAsset object. However,
         note that for HTTP Live Streaming Media the duration of a player item during
         any particular playback session may differ from the duration of its asset. For
         this reason a new key-value observable duration property has been defined on
         AVPlayerItem.
         
         See the AV Foundation Release Notes for iOS 4.3 for more information.
         */
        
		return([playerItem duration]);
	}
	
	return(kCMTimeInvalid);
}


/* Cancels the previously registered time observer. */
-(void)removePlayerTimeObserver
{
	if (mTimeObserver)
	{
		[self.streamingPlayer removeTimeObserver:mTimeObserver];
		//[mTimeObserver release];
		mTimeObserver = nil;
	}
}

#pragma mark -
#pragma mark Loading the Asset Keys Asynchronously

#pragma mark -
#pragma mark Error Handling - Preparing Assets for Playback Failed

/* --------------------------------------------------------------
 **  Called when an asset fails to prepare for playback for any of
 **  the following reasons:
 **
 **  1) values of asset keys did not load successfully,
 **  2) the asset keys did load successfully, but the asset is not
 **     playable
 **  3) the item did not become ready to play.
 ** ----------------------------------------------------------- */

-(void)assetFailedToPrepareForPlayback:(NSError *)error
{
    [self removePlayerTimeObserver];
    [self syncScrubber];
    [self disableScrubber];
   // [self disablePlayerButtons];
    
    /* Display the error. */
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
														message:[error localizedFailureReason]
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
	[alertView show];
//	[alertView release];
}


#pragma mark Prepare to play asset, URL

/*
 Invoked at the completion of the loading of the values for all keys on the asset that we require.
 Checks whether loading was successfull and whether the asset is playable.
 If so, sets up an AVPlayerItem and an AVPlayer to play the asset.
 */
- (void)prepareToPlayAsset:(AVURLAsset *)asset withKeys:(NSArray *)requestedKeys
{
    /* Make sure that the value of each key has loaded successfully. */
	for (NSString *thisKey in requestedKeys)
	{
		NSError *error = nil;
		AVKeyValueStatus keyStatus = [asset statusOfValueForKey:thisKey error:&error];
		if (keyStatus == AVKeyValueStatusFailed)
		{
			[self assetFailedToPrepareForPlayback:error];
			return;
		}
		/* If you are also implementing -[AVAsset cancelLoading], add your code here to bail out properly in the case of cancellation. */
	}
    
    /* Use the AVAsset playable property to detect whether the asset can be played. */
    if (!asset.playable)
    {
        /* Generate an error describing the failure. */
		NSString *localizedDescription = NSLocalizedString(@"Item cannot be played", @"Item cannot be played description");
		NSString *localizedFailureReason = NSLocalizedString(@"The assets tracks were loaded, but could not be made playable.", @"Item cannot be played failure reason");
		NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:
								   localizedDescription, NSLocalizedDescriptionKey,
								   localizedFailureReason, NSLocalizedFailureReasonErrorKey,
								   nil];
		NSError *assetCannotBePlayedError = [NSError errorWithDomain:@"StitchedStreamPlayer" code:0 userInfo:errorDict];
        
        /* Display the error to the user. */
        [self assetFailedToPrepareForPlayback:assetCannotBePlayedError];
        
        return;
    }
	
	/* At this point we're ready to set up for playback of the asset. */
    
    /* Stop observing our prior AVPlayerItem, if we have one. */
    if (self.playerItem)
    {
        /* Remove existing player item key value observers and notifications. */
        
        [self.playerItem removeObserver:self forKeyPath:kStatusKey];
		
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:self.streamingPlayer];
    }
	
    /* Create a new instance of AVPlayerItem from the now successfully loaded AVAsset. */
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    
    /* Observe the player item "status" key to determine when it is ready to play. */
    [self.playerItem addObserver:self
                       forKeyPath:kStatusKey
                          options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                          context:CCMediaPlayerViewControllerStatusObservationContext];
	
    /* When the player item has played to its end time we'll toggle
     the movie controller Pause button to be the Play button */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.streamingPlayer];
	
    seekToZeroBeforePlay = NO;
	
    /* Create new player, if we don't already have one. */
    if (!self.streamingPlayer)
    {
        /* Get a new AVPlayer initialized to play the specified player item. */
        _streamingPlayer = [AVPlayer playerWithPlayerItem:_playerItem];
		
        /* Observe the AVPlayer "currentItem" property to find out when any
         AVPlayer replaceCurrentItemWithPlayerItem: replacement will/did
         occur.*/
        [self.streamingPlayer addObserver:self
                      forKeyPath:kCurrentItemKey
                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                         context:CCMediaPlayerViewControllerCurrentItemObservationContext];
        
        /* Observe the AVPlayer "rate" property to update the scrubber control. */
        [self.streamingPlayer addObserver:self
                      forKeyPath:kRateKey
                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                         context:CCMediaPlayerViewControllerCurrentItemObservationContext];
    }
    
    /* Make our new AVPlayerItem the AVPlayer's current item. */
    if (self.streamingPlayer.currentItem != _playerItem)
    {
        /* Replace the player item with a new player item. The item replacement occurs
         asynchronously; observe the currentItem property to find out when the
         replacement will/did occur*/
        [self.streamingPlayer replaceCurrentItemWithPlayerItem:_playerItem];
        
    //    [self syncPlayPauseButtons];
    }
	
    [self.scrubber setValue:0.0];
}

#pragma mark -
#pragma mark Asset Key Value Observing
#pragma mark

#pragma mark Key Value Observer for player rate, currentItem, player item status

/* ---------------------------------------------------------
 **  Called when the value at the specified key path relative
 **  to the given object has changed.
 **  Adjust the movie play and pause button controls when the
 **  player item "status" value changes. Update the movie
 **  scrubber control when the player item is ready to play.
 **  Adjust the movie scrubber control when the player item
 **  "rate" value changes. For updates of the player
 **  "currentItem" property, set the AVPlayer for which the
 **  player layer displays visual output.
 **  NOTE: this method is invoked on the main queue.
 ** ------------------------------------------------------- */

- (void)observeValueForKeyPath:(NSString*) path
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context
{
	/* AVPlayerItem "status" property value observer. */
	if (context == CCMediaPlayerViewControllerStatusObservationContext)
	{
		//[self syncPlayPauseButtons];
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status)
        {
                /* Indicates that the status of the player is not yet known because
                 it has not tried to load new media resources for playback */
            case AVPlayerStatusUnknown:
            {
                [self removePlayerTimeObserver];
                [self syncScrubber];
                
                [self disableScrubber];
              //  [self disablePlayerButtons];
            }
                break;
                
            case AVPlayerStatusReadyToPlay:
            {
                /* Once the AVPlayerItem becomes ready to play, i.e.
                 [playerItem status] == AVPlayerItemStatusReadyToPlay,
                 its duration can be fetched from the item. */
                
                [self initScrubberTimer];
                
                [self enableScrubber];
 //               [self enablePlayerButtons];
            }
                break;
                
            case AVPlayerStatusFailed:
            {
                AVPlayerItem *playerItem = (AVPlayerItem *)object;
                [self assetFailedToPrepareForPlayback:playerItem.error];
            }
                break;
        }
	}
	/* AVPlayer "rate" property value observer. */
	else if (context == CCMediaPlayerkViewControllerRateObservationContext)
	{
        //[self syncPlayPauseButtons];
	}
	/* AVPlayer "currentItem" property observer.
     Called when the AVPlayer replaceCurrentItemWithPlayerItem:
     replacement will/did occur. */
	else if (context == CCMediaPlayerkViewControllerRateObservationContext)
	{
        AVPlayerItem *newPlayerItem = [change objectForKey:NSKeyValueChangeNewKey];
        
        /* Is the new player item null? */
        if (newPlayerItem == (id)[NSNull null])
        {
           // [self disablePlayerButtons];
            [self disableScrubber];
        }
        else /* Replacement of player currentItem has occurred */
        {
            /* Set the AVPlayer for which the player layer displays visual output. */
         //   [self.streamingPlayer = mPlayer];
            
        //    [self setViewDisplayName];
            
            /* Specifies that the player should preserve the video’s aspect ratio and
             fit the video within the layer’s bounds. */
         //   [self.mPlaybackView setVideoFillMode:AVLayerVideoGravityResizeAspect];
            
           // [self syncPlayPauseButtons];
        }
	}
	else
	{
		[super observeValueForKeyPath:path ofObject:object change:change context:context];
	}
}


@end
