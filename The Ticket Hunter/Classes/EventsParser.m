//
//  EventsParser.m
//  TheTicketHunter
//
//  Created by Richard Allen on 20/05/2013.
//
//

#import "EventsParser.h"
#import "Shows2.h"

@implementation EventsParser
@synthesize shows = _shows;

NSMutableString	*currentNodeContent;
NSXMLParser		*parser;
Shows2			*currentShow;
bool            isStatus;

-(id) loadXMLByURL:(NSString *)urlString
{
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
		currentShow = [Shows2 alloc];
        isStatus = YES;
	}
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (isStatus)
    {
        if ([elementname isEqualToString:@"ShowName"])
        {
            currentShow.showName = currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"ShowLocation"])
        {
            currentShow.showLocation = currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"Date"])
        {
            currentShow.date= currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"ShowMonth"])
        {
            currentShow.showMonth= currentNodeContent;
        }

       if ([elementname isEqualToString:@"ShowDay"])
       {
            currentShow.showDay= currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"LowestPrice"])
        {
            currentShow.lowestPrice = currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"ShowLink"])
        {
            currentShow.showLink = currentNodeContent;
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
