//
//  ITunesSearch_Tests.m
//  iTunesSearchProject
//
//  Created by Vasileios Loumanis on 26/03/2016.
//  Copyright © 2016 Vasileios Loumanis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ITunesSearch.h"

@interface ITunesSearch_Tests : XCTestCase

@property (retain) ITunesSearch *iTunesSearch;

@end

@implementation ITunesSearch_Tests

- (void)setUp {
    [super setUp];
    self.iTunesSearch = [[ITunesSearch alloc] init];
}

- (void)testRetrievingItunesResponseAsynchronously {
    XCTAssertNil(self.iTunesSearch.json, @"Json should be nil");
    XCTAssertTrue(self.iTunesSearch.tracksArray.count == 0, @"tracksArray should be empty");
    XCTestExpectation *asyncExpectation = [self expectationWithDescription:@"RetrievingItunesResponse"];
    [self.iTunesSearch search:@"u2" completionHandler:^{
        [asyncExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error == nil) {
            XCTAssertNotNil(self.iTunesSearch.json, @"Json should not be nil");
            XCTAssertTrue(self.iTunesSearch.tracksArray.count > 0, @"tracksArray should not be empty");
        }
    }];
}

- (void)testUrlFormatter {
    NSString *searchTerms = @"florence and the machine";
    NSString *resultedURLString = [self.iTunesSearch urlFormatterWithSearchTerms:searchTerms];
    XCTAssertTrue([resultedURLString isEqualToString:@"http://itunes.apple.com/search?term=florence+and+the+machine"], @"resultedURLString should match");
}

@end
