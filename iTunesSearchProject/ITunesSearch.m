//
//  ITunesSearch.m
//  iTunesSearchProject
//
//  Created by Vasileios Loumanis on 26/03/2016.
//  Copyright © 2016 Vasileios Loumanis. All rights reserved.
//

#import "ITunesSearch.h"
#import "ITunesTrack.h"

static NSString * const itunesURL = @"http://itunes.apple.com/search?term=";

@implementation ITunesSearch

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tracksArray = [[NSMutableArray alloc] init];
    }
    return self;
}

// TODO: Consider using a third party network framework like AFNetworking/AFNetworking
- (void)search:(NSString *)searchTerms completionHandler:(void (^)(void))completionHandler {
    NSURL *url = [NSURL URLWithString:[self urlFormatterWithSearchTerms:searchTerms]];
    // NSURLSessionTask is supported on iOS 7+ only, NSURLConnection is deprecated in iOS 9
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                         completionHandler:
                              ^(NSData *data, NSURLResponse *response, NSError *error) {
                                  if (data) {
                                      NSError *parseError;
                                      self.json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                                      [self parseJSON];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          completionHandler();
                                      });
                                  } else {
                                      //TODO: Handle the error appropriately
                                      NSLog(@"Failed to fetch %@: %@", url, error);
                                  }
                              }];
    [task resume];
}

- (NSString *)urlFormatterWithSearchTerms:(NSString *)searchTerms {
    //TODO: Make sure that this method handles special characters etc in the future
    NSMutableArray *arrayOfSearchTerms = [NSMutableArray arrayWithArray:[searchTerms componentsSeparatedByString:@" "]];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", itunesURL, arrayOfSearchTerms.firstObject];
    [arrayOfSearchTerms removeObjectAtIndex:0];
    for (NSString *searchTerm in arrayOfSearchTerms) {
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"+%@", searchTerm]];
    }
    return urlString;
}

- (void)parseJSON {
    [self.tracksArray removeAllObjects];
    NSArray *results = [NSArray arrayWithArray:[self.json objectForKey:@"results"]];
    for (NSDictionary *trackInfo in results) {
        ITunesTrack *track = [[ITunesTrack alloc] initWithTrackInfo:trackInfo];
        [self.tracksArray addObject:track];
    }
}

@end
