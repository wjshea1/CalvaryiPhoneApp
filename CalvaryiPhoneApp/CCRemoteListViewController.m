//
//  CCRemoteListViewController.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/2/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCRemoteListViewController.h"
#import "CCSermonStudyStore.h"
#import "MBProgressHUD.h"
#import "CCFeedManager.h"                               

@interface CCRemoteListViewController ()

@end

@implementation CCRemoteListViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *requestUrl = _item.requestUrl;
    if ( _item.bookNumber ) {
        [requestUrl stringByAppendingFormat:@"\%d", _item.bookNumber];
    }
    CCFeedManager *myManager = [CCFeedManager sharedManager];
    [myManager getFeedWithURL:requestUrl 
                   completion:^{
                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                       [self.tableView reloadData];
                   }];
    

    
    
    
    
}
-(void) awakeFromNib
{
    NSLog(@"RemoteListView awakeFromNib");
    NSLog(@"item name: %@, bookNumber: %d", _item.name, _item.bookNumber);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // The logic of this function just got funky

    // Return the number of rows in the section.
    CCFeedManager *myManager = [CCFeedManager sharedManager];
     
    return [myManager getCurrentListCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SERMON_CELL_REUSE_ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CCFeedManager *myManager = [CCFeedManager sharedManager];
    SermonModel *sermon = [myManager objectInCurrentAtIndex:[indexPath row]];
    
  /*  CCSermonStudyStore *myStore = [CCSermonStudyStore sharedStoreWithView:self.view];
    SermonModel *sermon = [myStore getMenuItemAtIndex:[indexPath row]];*/
    [[cell textLabel] setText:[sermon title]];
    [[cell detailTextLabel] setText:[sermon summary]];
    
    
    // Create Image Cache and URL by
    // UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:sermon.]]];
    

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
