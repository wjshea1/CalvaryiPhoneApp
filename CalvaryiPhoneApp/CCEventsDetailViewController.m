//
//  CCEventsDetailViewController.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/6/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//
#import <EventKit/EventKit.h>
#import "CCEventsDetailViewController.h"
#import "CCFeedImageStore.h"

@interface CCEventsDetailViewController ()

@end

@implementation CCEventsDetailViewController

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
	// Do any additional setup after loading the view.
    [_titleLabel setText: _item.title];
    [_descriptionTextView setText:_item.description];
    [_dateLabel setText:_item.formatDateString];
    if ( _item.imageURL ) {
        
        // Load the image
        CCFeedImageStore  *imageStore = [CCFeedImageStore sharedStore];
        UIImage *img = [imageStore getImageForURL:_item.imageURL];
        [_eventImage setImage: img];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToCalendarAction:(id)sender {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    event.title     = _item.title;
    
    event.startDate = [[NSDate alloc] init];
    event.endDate   = [[NSDate alloc] initWithTimeInterval:600 sinceDate:_item.eventDate];
    
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
}
@end
