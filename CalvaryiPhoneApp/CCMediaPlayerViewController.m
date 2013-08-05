//
//  CCMediaPlayerViewController.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/9/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCMediaPlayerViewController.h"
#import "CCFeedImageStore.h"
#import "CCMediaPlayerManager.h"

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
    if ( !_streamingPlayer ) {
       // _streamingPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:_item.audioFileLocation]];
        _streamingPlayer = [[CCMediaPlayerManager sharedManager] getCurrentPlayer];
       // [_streamingPlayer initWithURL:[NSURL URLWithString:_item.audioFileLocation]];
    } else {
        // There is already a streaming running
        // We want to remove the observers and listeners and start up a new player
        [_streamingPlayer pause];
        _streamingPlayer = nil;
// todo:not finished
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
	// Do any additional setup after loading the view.
    [_streamingPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_streamingPlayer addObserver:self forKeyPath:@"currentItem.duration"
                          options:0
                          context:nil];
    
    // Call Init scrubber here
    [self initScrubber];
    
    
    
}
-(void) viewDidDisappear:(BOOL)animated
{
    
    // Removing these observers because they are not need as the view can no longer be seen
    // I will leave the PerodicTimeObserver until dealloc
    [_streamingPlayer removeObserver:self forKeyPath:@"status"];
    [_streamingPlayer removeObserver:self forKeyPath:@"currentItem.duration"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
    if ( object == _streamingPlayer && [keyPath isEqualToString:@"currentItem.duration"]){
        NSLog(@"duration");
    }
    
    if (object == _streamingPlayer && [keyPath isEqualToString:@"status"]) {
        if (_streamingPlayer.status == AVPlayerStatusReadyToPlay) {
            //[playingLbl setText:@"Playing Audio"];
            NSLog(@"fineee");
            //[playBtn setEnabled:YES];
        } else if (_streamingPlayer.status == AVPlayerStatusFailed) {
            // something went wrong. player.error should contain some information
            NSLog(@"not fineee");
            NSLog(@"%@",_streamingPlayer.error);
            
        }
        else if (_streamingPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            
            
        }
        
        
        if (object == _streamingPlayer.currentItem && [keyPath isEqualToString:@"status"]) {
            if (_streamingPlayer.currentItem.status == AVPlayerItemStatusFailed) {
                NSLog(@"------player item failed:%@",_streamingPlayer.currentItem.error);
            }
        }
    }
}








- (IBAction)scrubberValueChanged:(id)sender {
    NSLog(@"%f", _scrubber.value);
    double duration = CMTimeGetSeconds([self playerItemDuration]);
    NSLog(@"%f", duration);
    NSLog(@"%f", duration * _scrubber.value);
    
    
}

- (IBAction)pressButtonBack:(id)sender {
    if ( _streamingPlayer) {
        CMTime currentTime = [_streamingPlayer currentTime];
        currentTime.value -= (1800 * currentTime.timescale);
        
        [_streamingPlayer seekToTime:currentTime];
        
    }
}

- (IBAction)pressButtonPlayPause:(id)sender {
    
 //   static bool isPlaying = false; // This is a bug wating to happen
    [self initScrubber];
    
    if ( ![self isPlaying] ){
        [_streamingPlayer play];
        _isPlaying = true;
        // SetPauseImage
        [_buttonPlayPause setImage:[UIImage imageNamed:@"basic_pause_small"] forState:UIControlStateNormal];
        
    } else {
        [_streamingPlayer pause];
        _isPlaying = false;
        // SetPlayImage
        [_buttonPlayPause setImage:[UIImage imageNamed:@"basic_play_button_small"] forState:UIControlStateNormal];
    }
    
    
    
 }

-(void)syncPlayPauseButton
{
    
}

-(BOOL) isPlaying
{
    if (_streamingPlayer.rate != 0.f)
        return true;
    return false;
}


-(void)initScrubber
{	
    CMTime playerDuration  = [self playerItemDuration];
    if ( CMTIME_IS_INVALID(playerDuration)){
        // bad file
        
        // ok this causes a problem in initing the scrubber for files that are not loading yet
        return;
    }
    
    CGFloat interval = .1f;
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration)){
        CGFloat width = CGRectGetWidth([_scrubber bounds]);
        interval = 0.5f * duration / width;
    }
    __weak typeof(self) weakSelf = self;
    
    mTimeObserver = [_streamingPlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC)
                                                                   queue:NULL
                                                              usingBlock:
                     ^(CMTime time)
                     {
                         [weakSelf syncScrubber];
                     }];

    
}






- (CMTime)playerItemDuration
{
    AVPlayerItem *thePlayerItem = [_streamingPlayer currentItem];
    if (thePlayerItem.status == AVPlayerItemStatusReadyToPlay)
    {
        
        return(self.streamingPlayer.currentItem.duration);
    }
    
    return(kCMTimeInvalid);
}

-(void)syncPlayerButtons {
    
        
    
}

- (IBAction)pressButtonForward:(id)sender {
    if ( _streamingPlayer) {
        CMTime currentTime = [_streamingPlayer currentTime];
        currentTime.value += (1800 * currentTime.timescale);
        
        [_streamingPlayer seekToTime:currentTime];
        
    }
}

- (IBAction)beginScrub:(id)sender
{
    NSLog(@"Begin scubbing");
	mRestoreAfterScrubbingRate = [self.streamingPlayer rate];
    [self.streamingPlayer setRate:0.f];
	
	/* Remove previous timer. */
	[self removePlayerTimeObserver];


}

- (IBAction)endScrub:(id)sender {
    NSLog(@"End Scrubbing");
    
    // Where to seek to

    
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
                                  [self syncScrubber];
                              }];
		}
	}
    
	if (mRestoreAfterScrubbingRate)
	{
		[self.streamingPlayer setRate:mRestoreAfterScrubbingRate];
		mRestoreAfterScrubbingRate = 0.f;
	}
    
    
    
}

/* The user has released the movie thumb control to stop scrubbing through the movie. */
- (IBAction)endScrubbing:(id)sender
{
}

-(NSString *)getTextforPlayerWithCMTime:(CMTime )durationV
{
    if (CMTIME_IS_INVALID(durationV))
        return @"0:00";
    NSUInteger dTotalSeconds = CMTimeGetSeconds(durationV);
    
    NSUInteger dHours = floor(dTotalSeconds / 3600);
    NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
    NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
    
    NSString *videoDurationText = [NSString stringWithFormat:@"%i:%02i:%02i",dHours, dMinutes, dSeconds];
    NSLog(@"%@",videoDurationText);
    return videoDurationText;
}

-(void) syncScrubber
{
    NSLog(@"Scrub");
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration))
    {
        _scrubber.minimumValue = 0.0;
        NSLog(@"Invalid Duration");
        return;
    }
    
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration) && (duration > 0))
    {
        NSLog(@"Duration of audio is %f", duration);
        float minValue = [ _scrubber minimumValue];
        float maxValue = [ _scrubber maximumValue];
        double time = CMTimeGetSeconds([_streamingPlayer currentTime]);
        [_scrubber setValue:(maxValue - minValue) * time / duration + minValue];
  
        [_titleCurrentTime setText:[self getTextforPlayerWithCMTime:_streamingPlayer.currentTime]];
        [_titleEndTime setText:[self getTextforPlayerWithCMTime:playerDuration]];
    }
    
    
}

- (NSTimeInterval) availableDuration;
{
    NSArray *loadedTimeRanges = [[self.streamingPlayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;
    return result;
}


@end
