//
//  ITunesTrack.h
//  iTunesSearchProject
//
//  Created by Vasileios Loumanis on 26/03/2016.
//  Copyright © 2016 Vasileios Loumanis. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ITunesTrack : NSObject

@property (strong) NSString *name;
@property (strong) NSString *albumName;
@property (strong) NSString *artistName;
@property (strong) NSString *thumbnailArtworkUrl;
@property (strong) NSString *artworkUrl;
@property (strong) UIImage *thumbnailArtworkImage;
@property (strong) UIImage *artworkImage;
@property (strong) NSString *price;
@property (strong) NSString *releaseDate;

- (instancetype)initWithTrackInfo:(NSDictionary *)trackInfo;
- (void)loadThumbnailImageWithCompletionHandler:(void (^)())completionHandler;
- (void)loadImageWithCompletionHandler:(void (^)())completionHandler;
- (void)priceFormatterWithPrice:(NSNumber *)price;
+ (ITunesTrack *)demoTrack;

@end
