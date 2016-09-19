
#import <XCTest/XCTest.h>
#import <Expecta.h>
#import <OHHTTPStubs.h>

@interface BaseTest : XCTestCase

- (NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileLocation;

@end
