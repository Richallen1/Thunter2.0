//
//  Ticket.m
//  TheatreBillboard
//
//  Created by Vaishnavi Naidu on 11/24/10.
//  Copyright 2010 Compubits Solutions Ltd. All rights reserved.
//

#import "Ticket.h"


@implementation Ticket
@synthesize Supplier, Time, Seating,Price,Fees, Total, URL;

-(void)dealloc {
	[Supplier release];
	[Time release];
	[Seating release];
	[Price release];
	[Fees release];
	[Total release];
	[URL release];
	[super dealloc];
}
@end
