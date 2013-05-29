//
//  WebViewController.m
//  TheTicketHunter
//
//  Created by Rich Allen on 27/05/2013.
//
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize webView;
@synthesize backButton;
@synthesize frontButton;
@synthesize resultURL;


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
    
    NSString *temp;

	temp=[NSString stringWithString:resultURL];
	
    NSLog(@"%@", resultURL);
    
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:temp]];
	webView.delegate = self;
	webView.scalesPageToFit=YES;
	[webView loadRequest:requestObj];
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [webView release];
    [backButton release];
    [frontButton release];
    [backButton release];
    [backButton release];
    [super dealloc];
}
- (IBAction)goBack:(id)sender {
}

- (IBAction)goForward:(id)sender {
}
@end
