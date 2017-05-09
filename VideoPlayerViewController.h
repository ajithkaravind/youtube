//
//  VideoPlayerViewController.h
//  YoututbePlayer
//
//  Created by Ajith on 5/3/17.
//  Copyright © 2017 sinergiasinergia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YTPlayerView.h>

@interface VideoPlayerViewController : UIViewController
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property(nonatomic,strong)NSString *strngvideoId;
@property(nonatomic,strong)NSString *strngvideotitle;
@property(nonatomic,strong)NSString *strngdetails;

@end
