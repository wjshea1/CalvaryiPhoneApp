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
    
    _streamingPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:_item.audioFileLocation]];
    
    //_playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:_item.audioFileLocation] ];
   
                      
    //_streamingPlayer = [AVPlayer playerWithPlayerItem:playerItem];

    [_streamingPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_streamingPlayer addObserver:self forKeyPath:@"currentItem.duration"
                     options:0
                     context:nil];
    
    
    
    
    //_streamingPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:_item.audioFileLocation]];
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

-(void)setURL:(NSURL*)URL
{
}

-(void) initScrubberTimer
{
    double interval = .1f;
    
   
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
    
    [_streamingPlayer play];
    
    CMTime playerDuration  = [self playerItemDuration];
    if ( CMTIME_IS_INVALID(playerDuration)){
        // bad file
       //return;
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

/*
    _myAudioPlayer = [[AVAudioPlayer alloc] initWithData:_objectData error:&errorAudioPlayer];
    [_myAudioPlayer prepareToPlay];
    if (!_myAudioPlayer) {
        NSLog(@"Error Loading File %@", errorAudioPlayer.description);
    }
    [_myAudioPlayer play];
 
 */

    
    
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
        float minValue = [ _scrubber minimumValue];
        float maxValue = [ _scrubber maximumValue];
        double time = CMTimeGetSeconds([_streamingPlayer currentTime]);
        [_scrubber setValue:(maxValue - minValue) * time / duration + minValue];
    }
    
    
    
    
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


@end
