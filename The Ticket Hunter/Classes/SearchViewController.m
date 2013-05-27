//
//  SearchViewController.m
//  TheatreBillboard
//
//  Created by Vaishnavi Naidu on 11/22/10.
//  Copyright 2010 Compubits Solutions Ltd. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#import "SearchViewController.h"
#import "ShowNamesViewController.h"


@implementation SearchViewController

@synthesize showSearchBar;

#pragma mark Setup
- (void)viewDidLoad {
    

    if (IS_WIDESCREEN) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"APPBACKDROP568.png"]];
        showSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 248, 320, 44)];
        showSearchBar.delegate = self;
        showSearchBar.placeholder = @"What do you want to see?";
        [self.view addSubview:showSearchBar];
    
    }
    else
    {
        // code for 3.5-inch screen
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"APPBACKDROP568.png"]];

    showSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 180, 320, 44)];
    showSearchBar.delegate = self;
    showSearchBar.placeholder = @"What do you want to see?";
    [self.view addSubview:showSearchBar];
     
    }
	[super viewDidLoad];

	
}

-(void)viewWillAppear:(BOOL)animated{

    if (showSearchBar) {
       [showSearchBar resignFirstResponder]; 
    }

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


