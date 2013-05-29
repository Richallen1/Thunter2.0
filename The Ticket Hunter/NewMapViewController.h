//
//  NewMapViewController.h
//  TheTicketHunter
//
//  Created by Rich Allen on 28/05/2013.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
    
	CLLocationCoordinate2D coordinate;
	
	NSString *mTitle;
	NSString *mSubTitle;
    NSString    *message;
    
    
}
@property (nonatomic, retain) NSString *message;


@end


@interface NewMapViewController : UIViewController <MKMapViewDelegate> {

    CLGeocoder *_geocoder;


    IBOutlet UILabel *postCodeLabel;

    IBOutlet UILabel *latLabel;

    IBOutlet UILabel *longLabel;
    
    MKMapView *mapView;
    
    AddressAnnotation *addAnnotation;
    
    double latDbl;
    double longDbl;
    
    NSString *latStr;
    NSString *longStr;
    NSString    *message;
}
@property (strong, nonatomic) NSString *VenuePostCode;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSString *message;


@end
