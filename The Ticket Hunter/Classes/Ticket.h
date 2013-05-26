//
//  Ticket.h
//  TheatreBillboard
//
//  Created by Vaishnavi Naidu on 11/24/10.
//  Copyright 2010 Compubits Solutions Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Ticket : NSObject {

	NSString *Supplier;
	NSString *Time;
	NSString *Seating;
	NSString *Price;
	NSString *Fees;
	NSString *Total;
	NSString *URL;

}
@property(nonatomic, retain)NSString *Supplier;
@property(nonatomic, retain)NSString *Time;
@property(nonatomic, retain)NSString *Seating;
@property(nonatomic, retain)NSString *Price;
@property(nonatomic, retain)NSString *Fees;
@property(nonatomic, retain)NSString *Total;
@property(nonatomic, retain)NSString *URL;
@end
