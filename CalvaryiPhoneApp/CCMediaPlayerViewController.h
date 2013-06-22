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
}
@property(strong, nonatomic)NSURL *soundFileURL;
@property(strong, nonatomic) SermonModel *item;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewAlbumArt;

@property (strong, nonatomic) IBOutlet UIProgressView *porgressBar;
@property (strong, nonatomic) IBOutlet UILabel *titleTrack;
@property (strong, nonatomic) IBOutlet UITextView *summary;
@property (strong, nonatomic) IBOutlet UIButton *buttonPlayPause;
@property (strong, nonatomic)AVAudioPlayer *myAudioPlayer;
@property (strong, nonatomic) AVPlayer *streamingPlayer;
@property (nonatomic) bool isPlaying;
- (IBAction)pressButtonBack:(id)sender;
- (IBAction)pressButtonPlayPause:(id)sender;
- (IBAction)pressButtonForward:(id)sender;



@end
