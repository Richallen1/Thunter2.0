//
//  VenuesViewController.m
//  TheTicketHunter
//
//  Created by Richard Allen on 27/05/2013.
//
//
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#import "VenuesViewController.h"
#import "VenuesParser.h"
#import "Venues.h"

@interface VenuesViewController ()

@end

@implementation VenuesViewController
@synthesize venuesTableView;
VenuesParser *VenuesXMlParser;


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
  
    loading = YES;
    
    if (IS_WIDESCREEN) {
        //Set up Table View iPhone 5
        venuesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 46, 320, 502) style:UITableViewStylePlain];
        venuesTableView.delegate = self;
        venuesTableView.dataSource = self;
        [venuesTableView reloadData];
        [self.view addSubview:venuesTableView];
    }
    else
    {
        //Set up Table View iPhone 4s and lower
        venuesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 46, 320, 414) style:UITableViewStylePlain];
        venuesTableView.delegate = self;
        venuesTableView.dataSource = self;
        [venuesTableView reloadData];
        [self.view addSubview:venuesTableView];
    }
    
    loading = YES;
    //DOWNLOAD
    dispatch_queue_t downloadQueue = dispatch_queue_create("Show Downloader", NULL);
    
    dispatch_async(downloadQueue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
			MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
			hud.labelText = @"Loading";
		});
        
        
        VenuesXMlParser = [[VenuesParser alloc] loadXMLByURL:@"http://awstest203.elasticbeanstalk.com/venues.aspx"];

        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            [venuesTableView reloadData];
            loading = NO;
        });
        
    });
    dispatch_release(downloadQueue);
    
    UIImage *logo = [UIImage imageNamed:@"103-map.png"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma TableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [VenuesXMlParser venues].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        Venues *currentVenue = [[VenuesXMlParser venues]objectAtIndex:indexPath.row];
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(2, 8, 26, 21)];
        imv.image=[UIImage imageNamed:@"103-map.png"];
        imv.tag = 0010;
        [cell.contentView addSubview:imv];

        
        CGRect showFrame = CGRectMake(45, 5, 250, 20);
        UILabel *showLabel = [[UILabel alloc] initWithFrame:showFrame];
        showLabel.tag = 0011;
        showLabel.text = [currentVenue venueName];
        showLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:showLabel];

        
        
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

@end
