//
//  EventsViewControllerSmall.h
//  TheTicketHunter
//
//  Created by Richard Allen on 20/05/2013.
//
//

#import <UIKit/UIKit.h>

@interface EventsViewControllerSmall : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    IBOutlet UILabel *eventLabel;
    
    NSDate *now;
	NSDateFormatter *dateFormat;
    
    
}


@property(nonatomic,retain)NSString *eventName;

@property (retain, nonatomic) IBOutlet UITableView *eventsTableView;

@end
