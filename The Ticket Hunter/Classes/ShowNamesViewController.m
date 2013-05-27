//
//  ShowNamesViewController.m
//  TheatreBillboard
//
//  Created by Vaishnavi Naidu on 11/25/10.
//  Copyright 2010 Compubits Solutions Ltd. All rights reserved.
//

#import "ShowNamesViewController.h"
#import "SearchViewController.h"
#import "ShowListParser.h"
#import "ShowsList.h"
#import "EventsViewController.h"



#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@implementation ShowNamesViewController
@synthesize tableview;

ShowListParser *xmlParser;


#pragma mark Setup

- (void)viewDidLoad {

    dispatch_queue_t downloadQueue = dispatch_queue_create("Show Downloader", NULL);
    
    dispatch_async(downloadQueue, ^{
    
    xmlParser = [[ShowListParser alloc]loadXMLByURL:@"http://awstest203.elasticbeanstalk.com/mobile_showlist.aspx"];
    
    
    
    //listOfItems = [[NSMutableArray alloc]initWithObjects:@"One", @"two", @"three", nil];
    listOfItems = [[NSMutableArray alloc]init];
    copyListOfItems=[[NSMutableArray alloc]init];
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	searchBar.showsCancelButton=YES;
   

    for (int i = 0; i < [xmlParser shows].count; i++){
        ShowsList *currentShow = [[xmlParser shows] objectAtIndex:i];
    
        [listOfItems addObject:currentShow.showName];
        
        NSLog(@"%@ Added!!",currentShow.showName);
    }
    
        dispatch_async(dispatch_get_main_queue(), ^{
    //NSLog(@"%@",[xmlParser shows]);
    
	if ([ listOfItems
         count]==0) {
		UIAlertView *alert=[[[UIAlertView alloc] initWithTitle:@"Oops!"
													   message:@"No shows found"
													  delegate:self
											 cancelButtonTitle:@"OK"
											 otherButtonTitles:nil]autorelease];
		[alert show];
	}
            
      [tableview reloadData];
            
        });
        
});
    dispatch_release(downloadQueue);
    
	[super viewDidLoad];
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (isFiltered == YES) {
        return copyListOfItems.count;
    }
    else
    {
		return listOfItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        //Show Image
//        CGRect imgFrame = CGRectMake(0, 0, 40, 40);
//        UILabel *imgLabel = [[UILabel alloc] initWithFrame:imgFrame];
//        imgLabel.tag = 0010;
//        imgLabel.backgroundColor =[UIColor purpleColor];
//        imgLabel.font = [UIFont systemFontOfSize:16];
//        [cell.contentView addSubview:imgLabel];
        
        
        //Show Label
        CGRect showFrame = CGRectMake(10, 10, 250, 20);
        UILabel *showLabel = [[UILabel alloc] initWithFrame:showFrame];
        showLabel.tag = 0011;
        //showLabel.backgroundColor =[UIColor purpleColor];
        showLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:showLabel];
        

        
        
    }
    if (isFiltered == YES) {
        
        NSLog(@"%i", copyListOfItems.count);
        
   // 	ShowsList *currentShow = [copyListOfItems objectAtIndex:indexPath.row];
        UILabel *showLabel = (UILabel *)[cell.contentView viewWithTag:0011];
   //     showLabel.text = [currentShow showName];
       showLabel.text = [copyListOfItems objectAtIndex:indexPath.row];

    
    }
    else
    {
        //NSMutableArray *arr = [[NSMutableArray alloc]init];
    
	ShowsList *currentShow = [[xmlParser shows] objectAtIndex:indexPath.row];
	UILabel *showLabel = (UILabel *)[cell.contentView viewWithTag:0011];
    showLabel.text = [currentShow showName];
        
        [listOfItems addObject:[currentShow showName]];
        
        
       }
    
    return cell;

}


#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
      
    EventsViewController *evc = [[EventsViewController alloc]initWithNibName:@"EventsViewController" bundle:nil];
        if (isFiltered == YES) {
            
            evc.eventName = [copyListOfItems objectAtIndex:indexPath.row];
        }
        else
        {
            ShowsList *currentShow = [[xmlParser shows] objectAtIndex:indexPath.row];
            
            evc.eventName = [currentShow showName];
        }
        
        [self.navigationController pushViewController:evc animated:YES];

}

#pragma UISearchBar Delegate Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        //Set Bool Flag
        isFiltered = NO;
        NSLog(@"1");
    }
    else
    {
        //Set Bool Flag
        isFiltered = YES;
    NSLog(@"2");
        
     
        
        
        //Init filtered Array
        copyListOfItems = [[NSMutableArray alloc]init];
        
        //Fast Enum
        for (NSString * show in listOfItems)
        {
            NSRange showRange = [show rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (showRange.location != NSNotFound) {
                [copyListOfItems addObject:show];
                
                NSLog(@"%@", show);
            }
            
        }
        
    }

    [tableview reloadData];
    

    
}
- (void) searchTableView {
	
	NSString *searchText = searchBar.text;
	NSMutableArray *searchArray = [[NSMutableArray alloc] init];
	
	for (NSString *s in listOfItems)
	{
		[searchArray addObject:s];
		
	}
	for (NSString *sTemp in searchArray)
	{
		NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
		if (titleResultsRange.length > 0)
            
			[copyListOfItems addObject:sTemp];
        
	}
	[searchArray release];
	searchArray = nil;
}





#pragma mark dealloc
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}


@end
