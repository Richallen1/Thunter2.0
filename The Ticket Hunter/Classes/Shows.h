//
//  Shows.h
//  TheatreBillboard
//
//  Created by Vaishnavi Naidu on 11/22/10.
//  Copyright 2010 Compubits Solutions Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Shows : NSObject {

	NSString *show;
}
@property (strong, nonatomic)NSString *showName;
@property (strong, nonatomic)NSString *showLocation;
@property (strong, nonatomic)NSString *date;
@property (strong, nonatomic)NSString *time;
@property (strong, nonatomic)NSString *lowestPrice;
@end
