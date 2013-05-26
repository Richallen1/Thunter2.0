//
//  EventsViewController.h
//  TheTicketHunter
//
//  Created by Rich Allen on 14/05/2013.
//
//

#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{

    IBOutlet UILabel *eventLabel;
    
    NSDate *now;
	NSDateFormatter *dateFormat;

    
}


@property(nonatomic,retain)NSString *eventName;
@property(strong, nonatomic)NSMutableArray *listOfEvents;
@property (retain, nonatomic) IBOutlet UITableView *eventsTableView;
@property (nonatomic, retain) UIImageView *customImage;
@property (strong, nonatomic)NSDate *dateHigh;
@property (nonatomic) BOOL loading;


-(void)loadMoreData;

@end
