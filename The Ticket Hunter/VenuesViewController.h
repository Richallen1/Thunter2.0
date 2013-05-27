//
//  VenuesViewController.h
//  TheTicketHunter
//
//  Created by Richard Allen on 27/05/2013.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface VenuesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>
{

    MBProgressHUD *HUD;
    
    BOOL loading;

}

@property (retain, nonatomic) IBOutlet UITableView *venuesTableView;

@end
