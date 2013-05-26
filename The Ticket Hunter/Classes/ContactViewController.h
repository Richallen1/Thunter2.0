//
//  ContactViewController.h
//  TheatreBillboard
//
//  Created by Richard Allen on 20/11/2012.
//
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIImageView *customImage;

@property (strong, nonatomic) NSMutableArray *imgArray;

@property (strong, nonatomic) NSMutableArray *array;

@property (strong, nonatomic) NSMutableArray *urlArray;

@end
