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
        
        
        
    
        _list = [[CCRecentFeed alloc] initFromURLWithString:@"http://localhost:8080/Calvary/feeds/current"
                                                 completion:^(JSONModel *model, JSONModelError *err){
                                                     NSLog(@"feeds, %@", _list.sermons);
                                                     
                                                 }];

        
   /*     [JSONHTTPClient getJSONFromURLWithString:@"http://localhost:8080/Calvary/feeds/current" completion:^(NSDictionary *json, JSONModelError *err) {
            NSError *error = nil;
            NSLog([json description]);
            _list = [[CCRecentFeed alloc] initWithDictionary:json error:&error] ;
            
        }]; */
    }
    return self;
}

-(id) initWithView:(UIView *)parentView
{
    self = [super init];
    if (self) {
        [MBProgressHUD showHUDAddedTo:parentView animated:YES];
        _list = [[CCRecentFeed alloc] initFromURLWithString:@"http://localhost:8080/Calvary/feeds/current"
                                                 completion:^(JSONModel *model, JSONModelError *err){
                                                     NSLog(@"feeds, %@", _list.sermons);
                                                     [MBProgressHUD hideHUDForView:parentView animated:YES];
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
- (CCSermonModel  *) getMenuItemAtIndex: (int) index
{
    
    return [[_list sermons] objectAtIndex:index];
    
}
- (int) getNumberOfItems
{
    return [[_list sermons] count];
}
#warning Remote this is for testing only
-(NSString *)getJSONResponse
{
    return @"";
}
@end
