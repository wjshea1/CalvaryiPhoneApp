//
//  CCNewsDetailViewController.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/21/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCNewsDetailViewController.h"
#import <Social/Social.h>

#import "constants.h"
#import "CCFeedImageStore.h"

@interface CCNewsDetailViewController ()

@end

@implementation CCNewsDetailViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // check item and validate that...
    if ( _item ){
        
        [_headline setText:_item.headline];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:DEFAULT_DATE_FORMAT];
        NSString *dateString = [format stringFromDate:_item.publishDate];

         
        [_date setText:dateString];
        [_description setText:_item.description];
       
        CCFeedImageStore *myStore = [CCFeedImageStore sharedStore];
        UIImage *image = [myStore getImageForURL:_item.imageLink];
        if ( image )
            [[self newsImage] setImage:image];

        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickShareButton:(id)sender {

    NSArray *activityItems;
    
    activityItems =@[_item.headline,_item.internetLink];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
    

}
- (IBAction)clickLearnMoreAction:(id)sender {
    
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:_item.internetLink]];
    
    // Web Navigation to more detail on the web
}
@end
