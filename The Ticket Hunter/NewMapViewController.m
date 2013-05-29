//
//  NewMapViewController.m
//  TheTicketHunter
//
//  Created by Rich Allen on 28/05/2013.
//
//

#import "NewMapViewController.h"

@interface NewMapViewController ()

@end


@implementation AddressAnnotation

@synthesize coordinate;
@synthesize message;


- (NSString *)subtitle{
	return @"";
}
- (NSString *)title{
	return @"";
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

@end



@implementation NewMapViewController
@synthesize VenuePostCode;
@synthesize geocoder=_geocoder;
@synthesize mapView;
@synthesize message;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{

    if (!self.geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    [self.geocoder geocodeAddressString:VenuePostCode completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            longLabel.text = [NSString stringWithFormat:@"%f, %f", coordinate.latitude, coordinate.longitude];
            if ([placemark.areasOfInterest count] > 0) {
                latLabel.text = [placemark.areasOfInterest objectAtIndex:0];
                
                //                latDbl = coordinate.latitude;
                //                longDbl = coordinate.longitude;
                
                CLLocationCoordinate2D location;
                location.latitude = coordinate.latitude;
                location.longitude = coordinate.longitude;

                
                MKCoordinateRegion newRegion;
                newRegion.center.latitude = coordinate.latitude;
                newRegion.center.longitude = coordinate.longitude;
                newRegion.span.latitudeDelta = 0.008388;
                newRegion.span.longitudeDelta = 0.016243;
                
                [self.mapView setRegion:newRegion animated:YES];
                
                mapView.showsUserLocation = TRUE;
                
                latStr = [NSString stringWithFormat:@"%f", coordinate.latitude];
                longStr = [NSString stringWithFormat:@"%f", coordinate.latitude];
                
                if(addAnnotation != nil) {
                    [mapView removeAnnotation:addAnnotation];
                    [addAnnotation release];
                    addAnnotation = nil;
                }

            addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
            NSLog(@"ssss%f", location);
            [mapView addAnnotation:addAnnotation];

                
            } else {
                latLabel.text = @"No Area of Interest Was Found";
                
                
                
            }
        }
    }];


}


- (void)viewDidLoad
{

    
    self.title = @"Maps";
    
    postCodeLabel.text = VenuePostCode;
    


    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    self.VenuePostCode = nil;
    self.message = nil;
}

- (void)dealloc {
    [postCodeLabel release];
    [latLabel release];
    [longLabel release];
    [super dealloc];
}
@end
