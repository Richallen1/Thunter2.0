//
//  Results.h
//  TheTicketHunter
//
//  Created by Richard Allen on 24/05/2013.
//
//

#import <Foundation/Foundation.h>

@interface Results : NSObject {
    
    NSString *show;
    
}

@property (strong, nonatomic)NSString *supplierName;
@property (strong, nonatomic)NSString *time;
@property (strong, nonatomic)NSString *seating;
@property (strong, nonatomic)NSString *price;
@property (strong, nonatomic)NSString *fees;
@property (strong, nonatomic)NSString *total;
@property (strong, nonatomic)NSString *resultLink;

@end
