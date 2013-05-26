//
//  ShowNamesViewController.h
//  TheatreBillboard
//
//  Created by Vaishnavi Naidu on 11/25/10.
//  Copyright 2010 Compubits Solutions Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheatreBillboardAppDelegate.h"


@interface ShowNamesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {

	IBOutlet UISearchBar *searchBar;
	IBOutlet UITableView *tableview;
	
	IBOutlet UIButton *backButton;
	IBOutlet UIButton *doneSearching;	

	NSMutableArray *listOfItems;
	NSMutableArray *copyListOfItems;

    BOOL isFiltered;
    
	BOOL searching;
	BOOL letUserSelectRow;



}

@property(nonatomic, retain) IBOutlet UITableView *tableview;

- (void) searchTableView;
- (void) doneSearching_Clicked;
-(IBAction)doneSearchingAction;
@end
