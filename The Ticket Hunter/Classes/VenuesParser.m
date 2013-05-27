//
//  VenuesParser.m
//  TheTicketHunter
//
//  Created by Richard Allen on 27/05/2013.
//
//

#import "VenuesParser.h"
#import "Venues.h"


@implementation VenuesParser
@synthesize venues = _venues;


NSMutableString	*currentNodeContent;
NSXMLParser		*parser;
Venues			*currentVenue;
bool            isStatus;



-(id) loadXMLByURL:(NSString *)urlString
{

	_venues			= [[NSMutableArray alloc] init];
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
	if ([elementname isEqualToString:@"Venue"])
	{
		currentVenue = [Venues alloc];
        isStatus = YES;
	}
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    
    
    if (isStatus)
    {
        if ([elementname isEqualToString:@"VenueName"])
        {
            currentVenue.venueName = currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"VenuePostCode"])
        {
            currentVenue.address = currentNodeContent;
        }
        
        
        
    }
	if ([elementname isEqualToString:@"Venue"])
	{
		[_venues addObject:currentVenue];
        currentVenue = nil;
		currentNodeContent = nil;
        
        
        
        
	}
    
    
}

@end
