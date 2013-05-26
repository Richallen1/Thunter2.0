//
//  Top10.h
//  TheatreBillboard
//
//  Created by Richard Allen on 15/11/2012.
//
//

#import <Foundation/Foundation.h>

@interface Top10 : NSObject{
    NSString *show;
}
@property (strong, nonatomic)NSString *showImg;
@property (strong, nonatomic)NSString *showName;
@property (strong, nonatomic)NSString *showDate;
@property (strong, nonatomic)NSString *showLocation;
@property(strong,nonatomic)NSString *category;



@end
