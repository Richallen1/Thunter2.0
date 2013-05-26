//
//  ContactViewController.m
//  TheatreBillboard
//
//  Created by Richard Allen on 20/11/2012.
//
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController
@synthesize tableView=_tableView;
@synthesize array=_array;
@synthesize imgArray=_imgArray;
@synthesize urlArray=_urlArray;
@synthesize customImage=_customImage;

UIImage	 *twitterLogo;
CGRect dateFrame;
UILabel *dateLabel;
CGRect contentFrame;
UILabel *contentLabel;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _array =[[NSMutableArray alloc]initWithObjects:@"Email",@"Facebook",@"Twitter", nil];
    _imgArray = [[NSMutableArray alloc]initWithObjects:@"em.jpg",@"fb.jpg",@"tw.jpg", nil];
    _urlArray = [[NSMutableArray alloc]initWithObjects:@"mailto:feedback@thebillboardgroup.com", @"https://www.facebook.com/pages/The-Ticket-Hunter/342061189214358",@"https://twitter.com/TheTicketHunt", nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_array count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        UIImage	 *twitterLogo = [UIImage imageNamed:[_imgArray objectAtIndex:indexPath.row]];
        
        CGRect imageFrame = CGRectMake(2, 8, 40, 40);
        self.customImage = [[UIImageView alloc] initWithFrame:imageFrame];
        self.customImage.image = twitterLogo;
        [cell.contentView addSubview:self.customImage];
        
        CGRect showFrame = CGRectMake(50, 20, 150, 20);
        UILabel *showLabel = [[UILabel alloc] initWithFrame:showFrame];
        showLabel.tag = 0011;
        //showLabel.backgroundColor =[UIColor purpleColor];
        showLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:showLabel];
        
    }
    
    UILabel *showLabel = (UILabel *)[cell.contentView viewWithTag:0011];
    showLabel.text = [_array objectAtIndex:indexPath.row];
    
    
    
    // NSDate *object = _array[indexPath.row];
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // ShareWebViewController *swvc = [[ShareWebViewController alloc]initWithNibName:@"ShareWebViewController" bundle:nil];
    
    // [self.navigationController pushViewController:swvc animated:YES];
    
    
    NSURL *url = [NSURL URLWithString:[_urlArray objectAtIndex:indexPath.row]];
    
    if (![[UIApplication sharedApplication] openURL:url])
        
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // myIndicator.hidden=YES;
    
}- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
