//
//  CCMediaPlayerViewController.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/9/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCMediaPlayerViewController.h"
#import "CCFeedImageStore.h"


@interface CCMediaPlayerViewController ()

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
    if ( _myAudioPlayer) {
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
    if ( _myAudioPlayer) {
        CMTime currentTime = [_streamingPlayer currentTime];
        currentTime.value += (30 * currentTime.timescale);
        
        [_streamingPlayer seekToTime:currentTime];
        
    }
}
@end
