//
//  ShowListParser.h
//  TheTicketHunter
//
//  Created by Richard Allen on 19/05/2013.
//
//

#import <Foundation/Foundation.h>

@interface ShowListParser : NSObject <NSXMLParserDelegate>

@property (strong, readonly) NSMutableArray *shows;


-(id) loadXMLByURL:(NSString *)urlString;


@end
