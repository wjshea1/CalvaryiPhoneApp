//
//  CCNewsViewController.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 6/20/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCNewsViewController.h"
#import "CCNewsFeedManager.h"
#import "MBProgressHUD.h"
#import "CCNewsDetailViewController.h"

@interface CCNewsViewController ()

@end

@implementation CCNewsViewController

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
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    
    
    [refreshControl addTarget:self action:@selector(refreshList) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refreshControl;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    // Need to put this in a plist
    NSString *requestUrl = @"http://calvary.cfapps.io/feeds/news";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    CCNewsFeedManager *myManager = [CCNewsFeedManager sharedManager];
    
    [myManager getNewsWithUrl:requestUrl completion:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView reloadData];
        
    }];
    
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
    // Return the number of rows in the section.
    CCNewsFeedManager *feedMgr = [CCNewsFeedManager sharedManager];
    return [feedMgr getCurrentListCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NEWS_CELL_REUSE";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CCNewsFeedManager *myManager = [CCNewsFeedManager sharedManager];
    NewsModel *model = [myManager objectInCurrentAtIndex:[indexPath row]];
    
    /*  CCSermonStudyStore *myStore = [CCSermonStudyStore sharedStoreWithView:self.view];
     SermonModel *sermon = [myStore getMenuItemAtIndex:[indexPath row]];*/
    [[cell textLabel] setText:[model  headline]];
    [[cell detailTextLabel] setText:[model description]];
        
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CCNewsDetailViewController *destView = segue.destinationViewController;
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    CCNewsFeedManager *myManager = [CCNewsFeedManager sharedManager];
    NewsModel *item = [myManager objectInCurrentAtIndex:[indexPath row]];
    destView.item = item;

}

- (void) refreshList
{
    NSString *requestUrl = @"http://calvary.cfapps.io/feeds/news";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    CCNewsFeedManager *myManager = [CCNewsFeedManager sharedManager];
    
    [myManager getNewsWithUrl:requestUrl completion:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
         
    }];

    
}

@end
