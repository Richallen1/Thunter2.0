//
//  ResultsViewController.m
//  TheTicketHunter
//
//  Created by Richard Allen on 24/05/2013.
//
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "ResultsViewController.h"
#import "ResultsParser.h"
#import "Results.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController
@synthesize ResultsTableView;
@synthesize listOfResults;
@synthesize showImgStr;
@synthesize eventStr;
@synthesize showLabel;
@synthesize eventDate;


ResultsParser *ResultsxmlParser;

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
    showLabel.text = eventStr;
    
    loading = YES;
    dispatch_queue_t downloadQueue = dispatch_queue_create("Show Downloader", NULL);
    
    dispatch_async(downloadQueue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
			// No need to hod onto (retain)
			MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
			hud.labelText = @"Loading";
		});
        
        NSLog(@"%@",eventStr);
        NSLog(@"%@",eventDate);
        
    NSString *url1= @"http://awstest203.elasticbeanstalk.com/mobile_search2.aspx?showname=Wicked&date=2013-06-14&tickets=1&seating=ANY&priceLow=0&priceHigh=150";
    NSString *url=[NSString stringWithFormat:@"http://awstest203.elasticbeanstalk.com/mobile_search2.aspx?showname=%@&date=%@&tickets=1&seating=ANY&priceLow=0&priceHigh=150",[eventStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],eventDate];
    NSString *url3=[NSString stringWithFormat:@"http://awstest203.elasticbeanstalk.com/mobile_search2.aspx?showname=%@&date=%@&tickets=1&seating=ANY&priceLow=0&priceHigh=150",[@"39 Steps" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"5/27/2013 12:00:00 AM"];

        NSLog(@"Date : %@",eventDate);

        NSLog(@"URL : %@",url);
        
       
    
    ResultsxmlParser = [[ResultsParser alloc]loadXMLByURL:url3];
    
    listOfResults = [[NSMutableArray alloc]initWithArray:[ResultsxmlParser shows]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        loading = NO;
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        [ResultsTableView reloadData];
            
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
    
    return [ResultsxmlParser shows].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     

      Results *currentResult = [listOfResults objectAtIndex:indexPath.row];

        
        
        NSString *imgStrURL = [NSString stringWithFormat:@"http://awstest203.elasticbeanstalk.com/%@",[currentResult supplierName]];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgStrURL]]];

        
       // NSString *imgStr = [NSString stringWithFormat:@"ticketmaster.jpg"];
        
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, 60, 35)];
        //imv.image=[UIImage imageNamed:imgStr];
        imv.image = [UIImage imageWithData:mydata];
        imv.tag = 0010;
        imv.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imv];
        
       
        CGRect seatingFrame = CGRectMake(70, 5, 200, 20);
        UILabel *seatingLabel = [[UILabel alloc] initWithFrame:seatingFrame];
        seatingLabel.tag = 0012;
        seatingLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:seatingLabel];
        NSString *seatingStr = [NSString stringWithFormat:@"%@", [currentResult seating]];
        seatingLabel.text = seatingStr;
       
        CGRect timeFrame = CGRectMake(70, 30, 200, 10);
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:timeFrame];
        timeLabel.tag = 0013;
        timeLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:timeLabel];
        timeLabel.text = [currentResult time];
     
        CGRect priceFrame = CGRectMake(230, 8, 80, 30);
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:priceFrame];
        priceLabel.tag = 0015;
        priceLabel.font = [UIFont boldSystemFontOfSize:14];
        priceLabel.textColor = [UIColor orangeColor];
        [cell.contentView addSubview:priceLabel];
        priceLabel.text = [currentResult total];

      


        
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
    [_showImgView release];
    [showLabel release];
    [super dealloc];
}
@end
