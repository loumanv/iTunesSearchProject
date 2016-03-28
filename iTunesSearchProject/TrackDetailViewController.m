//
//  DetailViewController.m
//  iTunesSearchProject
//
//  Created by Vasileios Loumanis on 26/03/2016.
//  Copyright © 2016 Vasileios Loumanis. All rights reserved.
//

#import "TrackDetailViewController.h"

@interface TrackDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *trackLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;

@end

@implementation TrackDetailViewController

- (void)configureView {
    self.trackLabel.text = [NSString stringWithFormat:@"Track: %@", self.track.name];
    self.albumLabel.text = [NSString stringWithFormat:@"Album: %@", self.track.albumName];
    self.artistLabel.text = [NSString stringWithFormat:@"Artist: %@", self.track.artistName];
    self.priceLabel.text = [NSString stringWithFormat:@"Price: %@", self.track.price];
    self.releaseDateLabel.text = [NSString stringWithFormat:@"Release Date: %@", self.track.releaseDate];
    [self loadArtwork];
    [self artworkImageViewStyle];
}

- (void)loadArtwork {
    [self.track loadImageWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.artworkImageView.image = self.track.artworkImage;
        });
    }];
    self.artworkImageView.image = self.track.artworkImage;
}

- (void)artworkImageViewStyle {
    // TODO: Create a imageView category for reusability that draws this properly
    self.artworkImageView.layer.cornerRadius = self.artworkImageView.frame.size.height / 2;
    self.artworkImageView.layer.masksToBounds = YES;
    self.artworkImageView.layer.borderWidth = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

@end
