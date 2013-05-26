
//  TheatreBillboardAppDelegate.h
//  TheatreBillboard
//
//  Created by Vaishnavi Naidu on 11/22/10.
//  Copyright 2010 Compubits Solutions Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TheatreBillboardAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;

	UIImageView *container;
    


	NSMutableArray *showNameArray;
	NSMutableArray *searchArray;
    
    
    NSMutableArray *venueArray;
    

	NSString *name;
	
	NSUserDefaults *standardUserDefaults;
	
	IBOutlet UITabBarController *tabbarController;
}
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSMutableArray *showNameArray;
@property (nonatomic, retain) NSMutableArray *searchArray;
@property (nonatomic, retain) NSUserDefaults *standardUserDefaults;
@property (nonatomic, retain) IBOutlet UITabBarController *tabbarController;
@property (strong, nonatomic) NSMutableArray *venueArray;


@end

