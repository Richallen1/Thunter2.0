//
//  SearchViewController.m
//  TheatreBillboard
//
//  Created by Vaishnavi Naidu on 11/22/10.
//  Copyright 2010 Compubits Solutions Ltd. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "SearchViewController.h"
#import "ShowNamesViewController.h"


@implementation SearchViewController

@synthesize showSearchBar;

#pragma mark Setup
- (void)viewDidLoad {
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"APPBACKDROP568.png"]];
    } else {
        // code for 3.5-inch screen
    }

    
    
    
	[super viewDidLoad];

	
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
	NSLog(@"BeginEditing...");
	
	ShowNamesViewController *snvc=[[ShowNamesViewController alloc]initWithNibName:@"ShowNamesViewController" bundle:nil];
    
	[self.navigationController pushViewController:snvc animated:YES];
	//[self resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   
}


#pragma mark dealloc
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {

    [super dealloc];
}





@end


