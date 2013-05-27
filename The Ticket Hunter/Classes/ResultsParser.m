//
//  ResultsParser.m
//  TheTicketHunter
//
//  Created by Richard Allen on 24/05/2013.
//
//

#import "ResultsParser.h"
#import "Results.h"


@implementation ResultsParser

NSMutableString	*currentNodeContent;
NSXMLParser		*parser;
Results         *currentShow;


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
	if ([elementname isEqualToString:@"Ticket"])
	{
		currentShow = [Results alloc];
        isStatus = YES;
	}
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (isStatus)
    {
        if ([elementname isEqualToString:@"Supplier"])
        {
            currentShow.supplierName = currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"Time"])
        {
            currentShow.time = currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"Seating"])
        {
            currentShow.seating= currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"Price"])
        {
            currentShow.price= currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"Fees"])
        {
            currentShow.fees= currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"Total"])
        {
            currentShow.total = currentNodeContent;
        }
        
        if ([elementname isEqualToString:@"URL"])
        {
            currentShow.resultLink = currentNodeContent;
        }
        NSLog(@"Result Found");
        
    }
	if ([elementname isEqualToString:@"Ticket"])
	{
		[self.shows addObject:currentShow];
		currentShow = nil;
		currentNodeContent = nil;
	}
}


@end
