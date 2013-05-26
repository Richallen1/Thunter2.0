//
//  Top10Theatre.h
//  TheatreBillboard
//
//  Created by Rich Allen on 18/11/2012.
//
//

#import <Foundation/Foundation.h>

@interface Top10Theatre : NSObject{
    NSString *show;
}
@property (strong, nonatomic)NSString *showImg;
@property (strong, nonatomic)NSString *showName;
@property (strong, nonatomic)NSString *showLocation;
@property(strong,nonatomic)NSString *category;


@end
