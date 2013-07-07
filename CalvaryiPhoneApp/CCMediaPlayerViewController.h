//
//  CCMediaPlayerViewController.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/9/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SermonModel.h"

@interface CCMediaPlayerViewController : UIViewController

{
    float mRestoreAfterScrubbingRate;
	BOOL seekToZeroBeforePlay;
	id mTimeObserver;
    

    
}
@property(strong, nonatomic) NSURL *soundFileURL;
@property(strong, nonatomic) SermonModel *item;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewAlbumArt;

@property (strong, nonatomic) IBOutlet UILabel *titleTrack;
@property (strong, nonatomic) IBOutlet UITextView *summary;
@property (strong, nonatomic) IBOutlet UIButton *buttonPlayPause;
@property (strong, nonatomic) AVPlayer *streamingPlayer;
@property (nonatomic) bool isPlaying;
@property (strong, nonatomic) IBOutlet UISlider *scrubber;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) IBOutlet UILabel *titleCurrentTime;
@property (strong, nonatomic) IBOutlet UILabel *titleEndTime;

- (IBAction)pressButtonBack:(id)sender;
- (IBAction)pressButtonPlayPause:(id)sender;
- (IBAction)pressButtonForward:(id)sender;
- (IBAction)beginScrub:(id)sender;
- (IBAction)endScrub:(id)sender;


- (void)syncScrubber;
- (void)initScrubber;



@end

static void *CCMediaPlayerkViewControllerRateObservationContext = &CCMediaPlayerkViewControllerRateObservationContext;
static void *CCMediaPlayerViewControllerStatusObservationContext = &CCMediaPlayerViewControllerStatusObservationContext;
static void *CCMediaPlayerViewControllerCurrentItemObservationContext = &CCMediaPlayerViewControllerCurrentItemObservationContext;
