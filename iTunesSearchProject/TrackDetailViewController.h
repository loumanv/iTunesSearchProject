//
//  DetailViewController.h
//  iTunesSearchProject
//
//  Created by Vasileios Loumanis on 26/03/2016.
//  Copyright © 2016 Vasileios Loumanis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITunesTrack.h"

@interface TrackDetailViewController : UIViewController

@property (strong, nonatomic) ITunesTrack *track;

@end

