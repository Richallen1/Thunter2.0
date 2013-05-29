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

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@interface EventsViewController ()

@end

@implementation EventsViewController
@synthesize eventName;
@synthesize eventsTableView;
@synthesize customImage;
@synthesize listOfEvents;
@synthesize dateHigh;
@synthesize loading;
@synthesize showImage;
EventsParser *EventxmlParser;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    
    return self;
}



#pragma mark -
#pragma mark Execution code

- (void)viewDidLoad
{

    if (IS_WIDESCREEN) {
    //Set up Table View iPhone 5
    eventsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, 320, 444) style:UITableViewStylePlain];
    eventsTableView.delegate = self;
    eventsTableView.dataSource = self;
    [eventsTableView reloadData];
    [self.view addSubview:eventsTableView];
    }
    else
    {
    //Set up Table View iPhone 4s and lower
    eventsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, 320, 356) style:UITableViewStylePlain];
    eventsTableView.delegate = self;
    eventsTableView.dataSource = self;
    [eventsTableView reloadData];
    [self.view addSubview:eventsTableView];
    }
    
    loading = NO;
    
    NSLog(@"XXXX%@XXXX",eventName);
    
    NSString *str = [NSString stringWithFormat:@"%@",eventName];
    
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
     
        dispatch_async(dispatch_get_main_queue(), ^{
			// No need to hod onto (retain)
			MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
			hud.labelText = @"Loading";
		});
        
        loading = YES;
        
    EventxmlParser = [[EventsParser alloc] loadXMLByURL:url];
    
        listOfEvents = [[NSMutableArray alloc]initWithArray:[EventxmlParser shows]];
        
    NSLog(@"%lu Count", (unsigned long)[EventxmlParser shows].count);

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            [eventsTableView reloadData];
            
            Shows2 *currentEvent = [[Shows2 alloc]init];

            NSString *str = [[NSString alloc]init];
            //str = @"http://media.ticketmaster.co.uk/tm/en-gb/dbimages/35369a.jpg";
            
            str = [currentEvent showImg];
            if (str == nil) {
                
                UIImageView *showImv = [[UIImageView alloc]initWithFrame:CGRectMake(9, 10, 123, 86)];
                showImv.image=[UIImage imageNamed:@"backupImg.png"];
                showImv.tag = 0016;
                [self.view addSubview:showImv];

            }
            else
            {
                UIImageView *showImv = [[UIImageView alloc]initWithFrame:CGRectMake(9, 10, 123, 86)];
                NSURL *imageURL = [NSURL URLWithString:str];
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                UIImage *image = [UIImage imageWithData:imageData];
                showImv.tag = 0016;
                showImv.image = image;
                [self.view addSubview:showImv];
                
                
            }
            //showImage.image = image;
            
            
            loading = NO;
        });
        
    });
    dispatch_release(downloadQueue);

    
    [super viewDidLoad];
 
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
        
        CGRect priceLabelFrame = CGRectMake(200, 1, 150, 20);
        UILabel *priceInfoLabel = [[UILabel alloc] initWithFrame:priceLabelFrame];
        priceInfoLabel.tag = 0014;
        priceInfoLabel.font = [UIFont boldSystemFontOfSize:12];
        priceInfoLabel.textColor = [UIColor orangeColor];
        [cell.contentView addSubview:priceInfoLabel];
        priceInfoLabel.text = @"Tickets From";
        
        
        CGRect priceFrame = CGRectMake(215, 18, 80, 30);
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
    
    //Pass Varibles to Results VC
    Shows2 *currentEvent = [listOfEvents objectAtIndex:indexPath.row];
    rvc.eventStr = eventName;
    NSString *dateStr = [currentEvent date];
    NSLog(@"1 %@",dateStr);
    
    //Format Date
    NSString *currentDateString = [currentEvent date];
    NSLog(@"currentDateString: %@", currentDateString);
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate = [dateFormater dateFromString:[currentEvent date]];
    rvc.eventDate = [dateFormat stringFromDate:currentDate];
    NSLog(@"%@", rvc.eventDate);
    
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
