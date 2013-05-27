//
//  VenuesParser.h
//  TheTicketHunter
//
//  Created by Richard Allen on 27/05/2013.
//
//

#import <Foundation/Foundation.h>

@interface VenuesParser : NSObject <NSXMLParserDelegate>

@property (strong, readonly) NSMutableArray *venues;

-(id) loadXMLByURL:(NSString *)urlString;


@end
