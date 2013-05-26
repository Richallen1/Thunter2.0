//
//  DisplayViewController.h
//  TheatreBillboard
//
//  Created by Vaishnavi Naidu on 11/22/10.
//  Copyright 2010 Compubits Solutions Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DisplayViewController : UIViewController<UIWebViewDelegate> {

	NSString *url;
	
	IBOutlet UIWebView *webView;
	IBOutlet UIActivityIndicatorView *myIndicator;
	IBOutlet UIButton *backButton;
	IBOutlet UIButton *webBack, *webNext;
	
	BOOL isFromResults, isFromInfo;

}
@property BOOL isFromResults,isFromInfo;
@property(nonatomic, retain)NSString *url;
@property(nonatomic, retain)IBOutlet UIWebView *webView;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *myIndicator;
@property(nonatomic, retain) IBOutlet UIButton *backButton;
-(IBAction)backAction;
@end
