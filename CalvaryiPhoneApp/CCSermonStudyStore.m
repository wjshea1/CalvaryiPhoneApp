//
//  CCSermonStudyStore.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/5/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//
#import "JSONModelLib.h"
#import "CCSermonStudyStore.h"
#import "CCRecentFeed.h"
#import "MBProgressHUD.h"

@implementation CCSermonStudyStore

- (id)init
{
    self = [super init];
    if (self) {
        
        _dict = [[NSMutableDictionary alloc] init];
        
        // Init with recent feed
      
      }
    return self;
}

-(id) initWithView:(UIView *)parentView
{
    self = [super init];
    if (self) {
        [MBProgressHUD showHUDAddedTo:parentView animated:YES];
        _list = [[CCRecentFeed alloc] initFromURLWithString:@"http://calvary.cfapps.io/Calvary/feeds/current"
                                                 completion:^(JSONModel *model, JSONModelError *err){
                                                     NSLog(@"feeds, %@", _list.sermons);
                                                     _loaded = true;
                                                     [MBProgressHUD hideHUDForView:parentView animated:YES];
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [((UITableView *)parentView) reloadData];
                                                         
                                                     });
                                                 }];

        
    }
    return self;
        
}





+ (CCSermonStudyStore *) sharedStoreWithView:(UIView *)parent
{
    
    static CCSermonStudyStore *store = nil;
    if ( !store ) {
        store = [[CCSermonStudyStore alloc] initWithView:parent];
    }
   
  
    
    return store;
}
- (SermonModel  *) getMenuItemAtIndex: (int) index
{
    
    return [[_list sermons] objectAtIndex:index];
    
}
- (int) getNumberOfItems
{
    return [[_list sermons] count];
}

-(NSString *)getJSONResponse
{
    return @"";
}
@end
