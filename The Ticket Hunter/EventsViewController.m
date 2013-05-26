//
//  EventsViewController.m
//  TheTicketHunter
//
//  Created by Rich Allen on 14/05/2013.
//
//

#import "EventsViewController.h"
#import "EventsParser.h"
#import "Shows2.h"
#import "ResultsViewController.h"

@interface EventsViewController ()

@end

@implementation EventsViewController
@synthesize eventName;
@synthesize eventsTableView;
@synthesize customImage;
@synthesize listOfEvents;
@synthesize dateHigh;
@synthesize loading;
EventsParser *EventxmlParser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    loading = NO;
    
    NSLog(@"XXXX%@XXXX",eventName);
    
    NSString *str = [NSString stringWithFormat:@"%@ Tickets",eventName];
    
    eventLabel.text = str;
    
    now = [[NSDate alloc] init];
	dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd/MMM/yyyy"];
	NSString *todaysDate = [dateFormat stringFromDate:now];
    
    int daysToAdd = 30;
    NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    NSString *futureDate = [dateFormat stringFromDate:newDate1];
    NSLog(@"%@",futureDate);
    dateHigh = newDate1;
    
NSString *url=[NSString stringWithFormat:@"http://awstest203.elasticbeanstalk.com/EventsSearch.aspx?showname=%@&dateLow=%@&dateHigh=%@&priceLow1&priceHigh150",[eventName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],todaysDate,futureDate];
    NSLog(@"URL : %@",url);
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("Show Downloader", NULL);
    
    dispatch_async(downloadQueue, ^{
     
        loading = YES;
        
    EventxmlParser = [[EventsParser alloc] loadXMLByURL:url];
    
        listOfEvents = [[NSMutableArray alloc]initWithArray:[EventxmlParser shows]];
        
    NSLog(@"%lu Count", (unsigned long)[EventxmlParser shows].count);

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [eventsTableView reloadData];
            loading = NO;
        });
        
    });
    dispatch_release(downloadQueue);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)loadMoreData
{

    
    
    int daysToAdd = 30;
    NSDate *newDate1 = [dateHigh dateByAddingTimeInterval:60*60*24*daysToAdd];
    NSString *futureDate = [dateFormat stringFromDate:newDate1];
    NSLog(@"%@",futureDate);
    
    NSString *url=[NSString stringWithFormat:@"http://awstest203.elasticbeanstalk.com/EventsSearch.aspx?showname=%@&dateLow=%@&dateHigh=%@&priceLow1&priceHigh150",[eventName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],dateHigh,futureDate];
    NSLog(@"URL : %@",url);

    dispatch_queue_t downloadQueue = dispatch_queue_create("Show Downloader", NULL);
    
    dispatch_async(downloadQueue, ^{
        
        EventxmlParser = [[EventsParser alloc] loadXMLByURL:url];
        
        //listOfEvents = [[NSMutableArray alloc]initWithArray:[EventxmlParser shows]];
        
        
        for (int i = 0; [EventxmlParser shows].count; i++) {
            
            Shows2 *currentEvent = [[EventxmlParser shows] objectAtIndex:i];
            
            [listOfEvents addObject:currentEvent];
            
        }
        
        NSLog(@"%lu Count", (unsigned long)[EventxmlParser shows].count);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
           // [eventsTableView reloadData];
            
        });
        
    });
    dispatch_release(downloadQueue);
    
dateHigh = newDate1;
    

}

#pragma TableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return listOfEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
//        if (indexPath.row >= (listOfEvents.count /3 *2)) {
//            if (!loading) {
//              loading = YES;
//                
//                [self loadMoreData];
//            }
//            
//            
//        }
        
        
        Shows2 *currentEvent = [listOfEvents objectAtIndex:indexPath.row];
        
        NSString *imgStr = [NSString stringWithFormat:@"%@",[currentEvent showMonth]];
        
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, 35, 35)];
        imv.image=[UIImage imageNamed:imgStr];
        imv.tag = 0010;
        [cell.contentView addSubview:imv];
        
        CGRect dateFrame = CGRectMake(10, 16, 20, 20);
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:dateFrame];
        dayLabel.tag = 0011;
        dayLabel.backgroundColor =[UIColor clearColor];
        dayLabel.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:dayLabel];
        dayLabel.text = [currentEvent showDay];

        
        CGRect showFrame = CGRectMake(55, 5, 250, 20);
        UILabel *showLabel = [[UILabel alloc] initWithFrame:showFrame];
        showLabel.tag = 0012;
        showLabel.font = [UIFont systemFontOfSize:10];
        [cell.contentView addSubview:showLabel];
        showLabel.text = [currentEvent showName];
        
        
        CGRect locationFrame = CGRectMake(55, 30, 250, 10);
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:locationFrame];
        locationLabel.tag = 0013;
        locationLabel.font = [UIFont systemFontOfSize:10];
        [cell.contentView addSubview:locationLabel];
        locationLabel.text = [currentEvent showLocation];
        
        CGRect priceLabelFrame = CGRectMake(170, 1, 150, 20);
        UILabel *priceInfoLabel = [[UILabel alloc] initWithFrame:priceLabelFrame];
        priceInfoLabel.tag = 0014;
        priceInfoLabel.font = [UIFont boldSystemFontOfSize:12];
        priceInfoLabel.textColor = [UIColor orangeColor];
        [cell.contentView addSubview:priceInfoLabel];
        priceInfoLabel.text = @"Tickets From";
        
        
        CGRect priceFrame = CGRectMake(180, 18, 80, 30);
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:priceFrame];
        priceLabel.tag = 0015;
        priceLabel.font = [UIFont boldSystemFontOfSize:14];
        priceLabel.textColor = [UIColor orangeColor];
        [cell.contentView addSubview:priceLabel];
        priceLabel.text = [currentEvent lowestPrice];

        
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    ResultsViewController *rvc = [[ResultsViewController alloc]initWithNibName:@"ResultsViewController" bundle:nil];
    
    [self.navigationController pushViewController:rvc animated:YES];
    
    
    [eventsTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [eventLabel release];
 
    [super dealloc];
}
- (void)viewDidUnload {
    [eventLabel release];
    eventLabel = nil;
//    [self setTableView:nil];
    [super viewDidUnload];
}
@end
