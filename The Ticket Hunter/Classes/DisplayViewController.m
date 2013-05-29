//
//  DisplayViewController.m
//  TheatreBillboard
//
//  Created by Vaishnavi Naidu on 11/22/10.
//  Copyright 2010 Compubits Solutions Ltd. All rights reserved.
//

#import "DisplayViewController.h"


@implementation DisplayViewController
@synthesize url;
@synthesize webView, myIndicator,backButton,isFromResults,isFromInfo;
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
			// Custom initialization
		
		UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
		self.navigationItem.rightBarButtonItem=cancel;

    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	backButton.hidden=NO;
	webBack.hidden=YES;
	webNext.hidden=YES;


    
	NSString *temp;
	if (isFromInfo){ 
		temp=[NSString stringWithString:url];
	}	
	else{
		
//		NSString *tempURL=[url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//		NSArray *split = [tempURL componentsSeparatedByString:@"#"];
//		temp=[[split objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		temp=[NSString stringWithString:url];
	}

	NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:temp]];
	webView.delegate = self;
	webView.scalesPageToFit=YES;
	[webView loadRequest:requestObj];
	myIndicator.hidesWhenStopped=YES;
    [super viewDidLoad];
}

#pragma mark Actions
-(IBAction)backAction{
	[self.navigationController popViewControllerAnimated:YES];	
}

-(void)cancelAction{
	[webView stopLoading];
	[self.navigationController popViewControllerAnimated:YES];	
}

#pragma mark Webview delegates
- (void)webViewDidFinishLoad:(UIWebView *)webView {    
	webBack.hidden=NO;
	webNext.hidden=NO;
	[myIndicator stopAnimating];
	
}

- (void)webViewDidStartLoad:(UIWebView *)webView {     
	[myIndicator startAnimating];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

	UIAlertView *alert=[[[UIAlertView alloc]initWithTitle:@"Error"
												 message:@"Page failed to load content. Please try after some time" 
												delegate:self
									   cancelButtonTitle:@"OK" 
									   otherButtonTitles:nil]autorelease];
	[alert show];
}

#pragma mark dealloc

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}


@end
