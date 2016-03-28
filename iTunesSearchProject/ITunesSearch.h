//
//  ITunesSearch.h
//  iTunesSearchProject
//
//  Created by Vasileios Loumanis on 26/03/2016.
//  Copyright © 2016 Vasileios Loumanis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITunesSearch : NSObject

@property (strong) NSDictionary *json;
// Could improve this by creating a category of NSMutableArray so it only allows ITunesTracks objects
@property (strong) NSMutableArray *tracksArray;

- (void)search:(NSString *)searchTerms completionHandler:(void (^)(void))completionHandler;
- (NSString *)urlFormatterWithSearchTerms:(NSString *)searchTerms;

@end
