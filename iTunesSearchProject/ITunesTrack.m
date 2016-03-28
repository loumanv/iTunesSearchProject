//
//  ITunesTrack.m
//  iTunesSearchProject
//
//  Created by Vasileios Loumanis on 26/03/2016.
//  Copyright © 2016 Vasileios Loumanis. All rights reserved.
//

#import "ITunesTrack.h"

@implementation ITunesTrack

- (instancetype)initWithTrackInfo:(NSDictionary *)trackInfo
{
    self = [super init];
    if (self) {
        self.name = [trackInfo objectForKey:@"trackName"];
        self.albumName = [trackInfo objectForKey:@"collectionName"];
        self.artistName = [trackInfo objectForKey:@"artistName"];
        self.thumbnailArtworkUrl = [trackInfo objectForKey:@"artworkUrl60"];
        self.artworkUrl = [trackInfo objectForKey:@"artworkUrl100"];
        [self priceFormatterWithPrice:[trackInfo objectForKey:@"trackPrice"]];
        [self dateFormatterWithDate:[trackInfo objectForKey:@"releaseDate"]];
    }
    return self;
}

- (void)priceFormatterWithPrice:(NSNumber *)price {
    if ([price isEqual:@-1]) {
        self.price = @"Album Only";
    } else {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        self.price = [numberFormatter stringFromNumber:price];
    }
}

- (void)dateFormatterWithDate:(NSString *)dateString {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *date = [[NSDate alloc] init];
    date = [df dateFromString:dateString];
    [df setDateFormat:@"dd-MM-yyyy"];
    self.releaseDate = [df stringFromDate:date];
}

#pragma mark - Load Artwork methods
// TODO: Consider using a third party network framework like AFNetworking/AFNetworking
- (void)loadThumbnailImageWithCompletionHandler:(void (^)())completionHandler {
    if (self.thumbnailArtworkImage == nil) {
        self.thumbnailArtworkImage = [UIImage imageNamed:@"noart"];
        [self loadImageAsync:self.thumbnailArtworkUrl completionHandler:^(UIImage *image) {
            self.thumbnailArtworkImage = image;
            completionHandler();
        }];
    }
}

- (void)loadImageWithCompletionHandler:(void (^)())completionHandler {
    if (self.artworkImage == nil) {
        self.artworkImage = [UIImage imageNamed:@"noart"];
        [self loadImageAsync:self.artworkUrl completionHandler:^(UIImage *image) {
            self.artworkImage = image;
            completionHandler();
        }];
    }
}

- (void)loadImageAsync:(NSString *)urlString completionHandler:(void (^)(UIImage*))completionHandler {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                         completionHandler:
                              ^(NSData *data, NSURLResponse *response, NSError *error) {
                                  if (data) {
                                      UIImage *image = [[UIImage alloc]initWithData:data];
                                      completionHandler(image);
                                  } else {
                                      //TODO: Handle the error appropriately
                                      NSLog(@"%@",[error localizedDescription]);
                                  }
                              }];
    [task resume];
}

#pragma mark - Demo track

+ (ITunesTrack *)demoTrack {
    ITunesTrack *demoTrack = [[ITunesTrack alloc] init];
    demoTrack.name = @"";
    demoTrack.albumName = @"";
    demoTrack.artistName = @"";
    demoTrack.artworkImage = [UIImage imageNamed:@"noart"];
    demoTrack.price = @"";
    demoTrack.releaseDate = @"";
    return demoTrack;
}

@end
