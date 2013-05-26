//
//  EventsViewControllerSmall.m
//  TheTicketHunter
//
//  Created by Richard Allen on 20/05/2013.
//
//

#import "EventsViewControllerSmall.h"
#import "EventsParser.h"

@interface EventsViewControllerSmall ()

@end

@implementation EventsViewControllerSmall
@synthesize eventName;
@synthesize eventsTableView;

EventsParser *xmlParser;

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
    
    
    
    NSLog(@"XXXX%@XXXX",eventName);
    
    NSString *str = [NSString stringWithFormat:@"%@ Tickets",eventName];
    
    eventLabel.text = str;
    
    now = [[NSDate alloc] init];
	dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd/MMM/yyyy"];
	NSString *todaysDate = [dateFormat stringFromDate:now];
    
    int daysToAdd = 60;
    NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    NSString *futureDate = [dateFormat stringFromDate:newDate1];
    
    
    NSString *url=[NSString stringWithFormat:@"http://awstest203.elasticbeanstalk.com/EventsSearch.aspx?showname=%@&dateLow=%@&dateHigh=%@&priceLow1&priceHigh150",[eventName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],todaysDate,futureDate];
    NSLog(@"URL : %@",url);
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("Show Downloader", NULL);
    
    dispatch_async(downloadQueue, ^{
        
        xmlParser = [[EventsParser alloc] loadXMLByURL:url];
        
        NSLog(@"%lu Count", (unsigned long)[xmlParser shows].count);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [eventsTableView reloadData];
            
        });
        
    });
    dispatch_release(downloadQueue);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma TableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [xmlParser shows].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        CGRect showFrame = CGRectMake(10, 2, 150, 20);
        UILabel *showLabel = [[UILabel alloc] initWithFrame:showFrame];
        showLabel.tag = 0011;
        showLabel.backgroundColor =[UIColor purpleColor];
        showLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:showLabel];
        
        CGRect locationFrame = CGRectMake(10, 25, 150, 15);
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:locationFrame];
        locationLabel.tag = 0012;
        locationLabel.backgroundColor =[UIColor redColor];
        locationLabel.font = [UIFont systemFontOfSize:10];
        [cell.contentView addSubview:locationLabel];
        
        CGRect dateFrame = CGRectMake(10, 40, 150, 15);
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:dateFrame];
        dateLabel.tag = 0013;
        dateLabel.backgroundColor =[UIColor blueColor];
        dateLabel.font = [UIFont systemFontOfSize:10];
        [cell.contentView addSubview:dateLabel];
        
        
        CGRect priceFrame = CGRectMake(170, 20, 65, 35);
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:priceFrame];
        priceLabel.tag = 0014;
        priceLabel.backgroundColor =[UIColor blueColor];
        priceLabel.font = [UIFont boldSystemFontOfSize:15];
        priceLabel.textColor = [UIColor orangeColor];
        [cell.contentView addSubview:priceLabel];
        
        CGRect labelFrame = CGRectMake(165, 2, 75, 30);
        UILabel *Label = [[UILabel alloc] initWithFrame:labelFrame];
        Label.tag = 0015;
        Label.backgroundColor =[UIColor blueColor];
        Label.font = [UIFont systemFontOfSize:10];
        Label.font = [UIFont boldSystemFontOfSize:10];
        [cell.contentView addSubview:Label];
        
        CGRect buttonFrame = CGRectMake(260, 10, 40, 30);
        UILabel *button = [[UILabel alloc] initWithFrame:buttonFrame];
        button.tag = 0016;
        button.backgroundColor =[UIColor blueColor];
        button.font = [UIFont systemFontOfSize:10];
        [cell.contentView addSubview:button];
        
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
