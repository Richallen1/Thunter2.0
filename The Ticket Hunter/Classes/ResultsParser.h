//
//  ResultsParser.h
//  TheTicketHunter
//
//  Created by Richard Allen on 24/05/2013.
//
//

#import <Foundation/Foundation.h>

@interface ResultsParser : NSObject <NSXMLParserDelegate>

@property (strong, readonly) NSMutableArray *shows;

-(id) loadXMLByURL:(NSString *)urlString;



@end
