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
    if ( !_streamingPlayer ) {
        _streamingPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:_item.audioFileLocation]];
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








- (IBAction)pressButtonBack:(id)sender {
    if ( _streamingPlayer) {
        CMTime currentTime = [_streamingPlayer currentTime];
        currentTime.value -= (30 * currentTime.timescale);
        
        [_streamingPlayer seekToTime:currentTime];
        
    }
}

- (IBAction)pressButtonPlayPause:(id)sender {
    
    static bool isPlaying = false; // This is a bug wating to happen
    
    
    if ( !isPlaying ){
        [_streamingPlayer play];
        isPlaying = true;
    } else {
        [_streamingPlayer pause];
        isPlaying = false;
    }
    
    
    
 }



-(void)initScrubber
{
    CMTime playerDuration  = [self playerItemDuration];
    if ( CMTIME_IS_INVALID(playerDuration)){
        // bad file
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
        currentTime.value += (30 * currentTime.timescale);
        
        [_streamingPlayer seekToTime:currentTime];
        
    }
}

- (IBAction)beginScrub:(id)sender {
}

- (IBAction)endScrub:(id)sender {
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


@end
