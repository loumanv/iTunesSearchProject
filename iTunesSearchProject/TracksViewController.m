//
//  MasterViewController.m
//  iTunesSearchProject
//
//  Created by Vasileios Loumanis on 26/03/2016.
//  Copyright © 2016 Vasileios Loumanis. All rights reserved.
//

#import "TracksViewController.h"
#import "TrackDetailViewController.h"
#import "ITunesSearch.h"
#import "ITunesTrack.h"

@interface TracksViewController ()

@property ITunesSearch *itunesSearch;

@end

@implementation TracksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itunesSearch = [[ITunesSearch alloc] init];
    self.trackDetailViewController = (TrackDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.trackDetailViewController.track = [ITunesTrack demoTrack];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TrackDetailViewController *trackDetailViewController = (TrackDetailViewController *)[[segue destinationViewController] topViewController];
        trackDetailViewController.track = self.itunesSearch.tracksArray[indexPath.row];
        trackDetailViewController.title = trackDetailViewController.track.name;
        trackDetailViewController.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itunesSearch.tracksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    ITunesTrack *track = (ITunesTrack *)self.itunesSearch.tracksArray[indexPath.row];
    cell.textLabel.text = track.name;
    [track loadThumbnailImageWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
            if (updateCell) {
                updateCell.imageView.image = track.thumbnailArtworkImage;
            }
        });
    }];
    cell.imageView.image = track.thumbnailArtworkImage;
    return cell;
}

#pragma mark - Search Bar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.itunesSearch search:searchBar.text completionHandler:^{
        [self.tableView reloadData];
    }];
    [searchBar resignFirstResponder];
}

@end
