//
//  WebViewController.h
//  TheTicketHunter
//
//  Created by Rich Allen on 27/05/2013.
//
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *frontButton;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) NSString *resultURL;

- (IBAction)goBack:(id)sender;

- (IBAction)goForward:(id)sender;

@end
