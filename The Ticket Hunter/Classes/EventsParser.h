//
//  EventsParser.h
//  TheTicketHunter
//
//  Created by Richard Allen on 20/05/2013.
//
//

#import <Foundation/Foundation.h>

@interface EventsParser : NSObject <NSXMLParserDelegate>

@property (strong, readonly) NSMutableArray *shows;

-(id) loadXMLByURL:(NSString *)urlString;


@end
