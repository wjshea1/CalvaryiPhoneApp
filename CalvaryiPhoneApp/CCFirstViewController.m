//
//  CCFirstViewController.m
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 5/24/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "CCFirstViewController.h"
#import "CCMainMenuStore.h"
#import "CCRemoteListViewController.h"

@interface CCFirstViewController ()

@end

@implementation CCFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger) section
{
    NSLog(@"numbersOfSectionsInTable");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection");
    return [[CCMainMenuStore sharedStore] getNumberOfMenuItems];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    static NSString *CellIdentifier =@"SERMONS_CELL_REUSE";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil){
        // Need to allocate the cell here
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
       // cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    
    CCMenuItem *item = [[CCMainMenuStore sharedStore] getMenuItemAtIndex:[indexPath row]];
    NSString *menuText = [item name];
    
    [[cell textLabel] setText:menuText];
    
    return cell;
}

-(void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Something was selected
    NSLog(@"didDeslectRowAtIndexPath");
        
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    CCMenuItem *item = [[CCMainMenuStore sharedStore] getMenuItemAtIndex:[indexPath row] ];
    if (item.requiresBooksOfTheBible) {
        
        [self performSegueWithIdentifier:@"SEGUE_BOOKS_OF_THE_BIBLE" sender:self];
    }
    else {
       // [(CCRemoteListViewController *)]
        [self performSegueWithIdentifier:@"REMOTE_LIST_VIEW_SEGUE" sender:self];
        // Set the name of the study in the array
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Note: Even though we have are calling performSeque this will always be called
    NSLog(@"prepareForSeque");
    
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    CCMenuItem *item = [[CCMainMenuStore sharedStore] getMenuItemAtIndex:[indexPath row] ];
    if ( item.requiresBooksOfTheBible){
        // Do something here for books of the bible
    } else {
        CCRemoteListViewController *destView = segue.destinationViewController;
        destView.item = item;
    }
}



@end


