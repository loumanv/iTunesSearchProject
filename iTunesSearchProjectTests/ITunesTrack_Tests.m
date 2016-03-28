//
//  ITunesTrack_Tests.m
//  iTunesSearchProject
//
//  Created by Vasileios Loumanis on 26/03/2016.
//  Copyright © 2016 Vasileios Loumanis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ITunesTrack.h"

@interface ITunesTrack_Tests : XCTestCase

@property (retain) ITunesTrack *iTunesTrack;

@end

@implementation ITunesTrack_Tests

- (void)setUp {
    [super setUp];
    NSError *jsonError;
    NSData *objectData = [[self mockData] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    self.iTunesTrack = [[ITunesTrack alloc] initWithTrackInfo:json];
}

- (void)testName {
    XCTAssertTrue([self.iTunesTrack.name isEqualToString:@"Beautiful Day"], @"Name should be equal to 'Beautiful Day'");
}

- (void)testAlbumName {
    XCTAssertTrue([self.iTunesTrack.albumName isEqualToString:@"All That You Can't Leave Behind"], @"Album name should be equal to 'All That You Can't Leave Behind'");
}

- (void)testArtistName {
    XCTAssertTrue([self.iTunesTrack.artistName isEqualToString:@"U2"], @"Artist name should be equal to 'U2'");
}

- (void)testThumbnailArtworkUrl {
    XCTAssertTrue([self.iTunesTrack.thumbnailArtworkUrl isEqualToString:@"http://is5.mzstatic.com/image/thumb/Music/v4/4e/cc/72/4ecc72d6-2257-baaf-163c-a4dfd08015ba/source/60x60bb.jpg"], @"Thumbnail artwork Url should be equal to provided URL");
}

- (void)testArtworkUrl {
    XCTAssertTrue([self.iTunesTrack.artworkUrl isEqualToString:@"http://is5.mzstatic.com/image/thumb/Music/v4/4e/cc/72/4ecc72d6-2257-baaf-163c-a4dfd08015ba/source/100x100bb.jpg"], @"Artwork Url should be equal to provided URL");
}

- (void)testPrice {
    XCTAssertTrue([self.iTunesTrack.price isEqualToString:@"$1.29"], @"Price should be equal to '1.29'");
}

- (void)testReleaseDate {
    XCTAssertTrue([self.iTunesTrack.releaseDate isEqualToString:@"09-10-2000"], @"Release date should be equal to '09-10-2000'");
}

- (void)testPriceWhenPriceMinusOne {
    [self.iTunesTrack priceFormatterWithPrice:@-1];
    XCTAssertTrue([self.iTunesTrack.price isEqualToString:@"Album Only"], @"Price should be equal to 'Album Only'");
}

- (void)testDefaultThumbnailImageIsLoaded {
    UIImage *defaultImage = [UIImage imageNamed:@"noart"];
    XCTAssertNil(self.iTunesTrack.thumbnailArtworkImage, @"Thumbnail artwork should be nil");
    [self.iTunesTrack loadThumbnailImageWithCompletionHandler:^{}];
    XCTAssertNotNil(self.iTunesTrack.thumbnailArtworkImage, @"Thumbnail artwork should not be nil");
    XCTAssertTrue([self.iTunesTrack.thumbnailArtworkImage isEqual:defaultImage], @"Thumbnail artwork should be set to default image");
}

- (void)testDefaultArtworkImageIsLoaded {
    UIImage *defaultImage = [UIImage imageNamed:@"noart"];
    XCTAssertNil(self.iTunesTrack.artworkImage, @"Artwork should be nil");
    [self.iTunesTrack loadImageWithCompletionHandler:^{}];
    XCTAssertNotNil(self.iTunesTrack.artworkImage, @"Artwork should not be nil");
    XCTAssertTrue([self.iTunesTrack.artworkImage isEqual:defaultImage], @"Artwork should be set to default image");
}

- (void)testThumbnailImageIsLoadedAsynchronously {
    
    XCTestExpectation *asyncExpectation = [self expectationWithDescription:@"RetrievingThumbnailImage"];
    [self.iTunesTrack loadThumbnailImageWithCompletionHandler:^{
        [asyncExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error == nil) {
            UIImage *defaultImage = [UIImage imageNamed:@"noart"];
            XCTAssertNotNil(self.iTunesTrack.thumbnailArtworkImage, @"Thumbnail artwork should not be nil");
            XCTAssertFalse([self.iTunesTrack.thumbnailArtworkImage isEqual:defaultImage], @"Thumbnail artwork should not be set to default image");
        }
    }];
}

- (void)testArtworkImageIsLoadedAsynchronously {
    
    XCTestExpectation *asyncExpectation = [self expectationWithDescription:@"RetrievingArtworkImage"];
    [self.iTunesTrack loadImageWithCompletionHandler:^{
        [asyncExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error == nil) {
            UIImage *defaultImage = [UIImage imageNamed:@"noart"];
            XCTAssertNotNil(self.iTunesTrack.artworkImage, @"Artwork should not be nil");
            XCTAssertFalse([self.iTunesTrack.artworkImage isEqual:defaultImage], @"Artwork should not be set to default image");
        }
    }];
}

- (NSString *)mockData {
    return @"{ \
        \"artistId\" : 78500,\
        \"artistName\" : \"U2\",\
        \"artistViewUrl\" : \"https://itunes.apple.com/us/artist/u2/id78500?uo=4\",\
        \"artworkUrl100\" : \"http://is5.mzstatic.com/image/thumb/Music/v4/4e/cc/72/4ecc72d6-2257-baaf-163c-a4dfd08015ba/source/100x100bb.jpg\",\
        \"artworkUrl30\" : \"http://is5.mzstatic.com/image/thumb/Music/v4/4e/cc/72/4ecc72d6-2257-baaf-163c-a4dfd08015ba/source/30x30bb.jpg\",\
        \"artworkUrl60\" : \"http://is5.mzstatic.com/image/thumb/Music/v4/4e/cc/72/4ecc72d6-2257-baaf-163c-a4dfd08015ba/source/60x60bb.jpg\",\
        \"collectionCensoredName\" : \"All That You Can't Leave Behind\",\
        \"collectionExplicitness\" : \"notExplicit\",\
        \"collectionId\" : 122726,\
        \"collectionName\" : \"All That You Can't Leave Behind\",\
        \"collectionPrice\" : 9.99,\
        \"collectionViewUrl\" : \"https://itunes.apple.com/us/album/beautiful-day/id122726?i=122701&uo=4\",\
        \"country\" : \"USA\",\
        \"currency\" : \"USD\",\
        \"discCount\" : 1,\
        \"discNumber\" : 1,\
        \"isStreamable\" : 1,\
        \"kind\" : \"song\",\
        \"previewUrl\" : \"http://a1856.phobos.apple.com/us/r1000/105/Music/38/30/97/mzm.akzgiqgo.aac.p.m4a\",\
        \"primaryGenreName\" : \"Rock\",\
        \"releaseDate\" : \"2000-10-09T07:00:00Z\",\
        \"trackCensoredName\" : \"Beautiful Day\",\
        \"trackCount\" : 11,\
        \"trackExplicitness\" : \"notExplicit\",\
        \"trackId\" : 122701,\
        \"trackName\" : \"Beautiful Day\",\
        \"trackNumber\" : 1,\
        \"trackPrice\" : 1.29,\
        \"trackTimeMillis\" : 248067,\
        \"trackViewUrl\" : \"https://itunes.apple.com/us/album/beautiful-day/id122726?i=122701&uo=4\",\
        \"wrapperType\" : \"track\"\
    }";
}

@end
