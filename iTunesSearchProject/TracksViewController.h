//
//  MasterViewController.h
//  iTunesSearchProject
//
//  Created by Vasileios Loumanis on 26/03/2016.
//  Copyright © 2016 Vasileios Loumanis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrackDetailViewController;

@interface TracksViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) TrackDetailViewController *trackDetailViewController;

@end

