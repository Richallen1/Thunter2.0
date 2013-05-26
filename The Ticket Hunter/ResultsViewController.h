//
//  ResultsViewController.h
//  TheTicketHunter
//
//  Created by Richard Allen on 24/05/2013.
//
//

#import <UIKit/UIKit.h>

@interface ResultsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    BOOL *loading;
    
}

@property (retain, nonatomic) IBOutlet UIImageView *showImgView;
@property (retain, nonatomic) IBOutlet UILabel *showLabel;
@property (retain, nonatomic) IBOutlet UITableView *ResultsTableView;
@property (strong, nonatomic) NSMutableArray *listOfResults;
@property (strong, nonatomic) NSString *showImgStr;


@end
