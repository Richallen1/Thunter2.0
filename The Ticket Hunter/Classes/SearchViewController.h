//
//  SearchViewController.h
//  TheatreBillboard
//
//  Created by Vaishnavi Naidu on 11/22/10.
//  Copyright 2010 Compubits Solutions Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheatreBillboardAppDelegate.h"

@interface SearchViewController : UIViewController<UISearchBarDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    IBOutlet UISearchBar *showSearchBar;
    
}

@property(nonatomic, retain) IBOutlet UISearchBar *showSearchBar;

	@end
