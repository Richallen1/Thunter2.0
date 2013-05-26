//
//  ShowListParser.m
//  TheTicketHunter
//
//  Created by Richard Allen on 19/05/2013.
//
//

#import "ShowListParser.h"
#import "ShowsList.h"

@implementation ShowListParser
@synthesize shows = _shows;



NSMutableString	*currentNodeContent;
NSXMLParser		*parser;
ShowsList		*currentShow;
bool            isStatus;

-(id) loadXMLByURL:(NSString *)urlString{
    
	_shows			= [[NSMutableArray alloc] init];
	NSURL *url		= [NSURL URLWithString:urlString];
	NSData	*data   = [[NSData alloc] initWithContentsOfURL:url];
	parser			= [[NSXMLParser alloc] initWithData:data];
	parser.delegate = self;
	[parser parse];
	return self;
    
    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if ([elementname isEqualToString:@"Show"])
	{
		currentShow = [ShowsList alloc];
        isStatus = YES;
	}
    
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (isStatus)
    {
        if ([elementname isEqualToString:@"Show"])
        {
            currentShow.showName = currentNodeContent;
        }

        
        
    }
	if ([elementname isEqualToString:@"Show"])
	{
        
		[self.shows addObject:currentShow];
		currentShow = nil;
		currentNodeContent = nil;
	}
    
    
}

@end
