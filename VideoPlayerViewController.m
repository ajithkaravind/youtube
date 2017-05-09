//
//  VideoPlayerViewController.m
//  YoututbePlayer
//
//  Created by Ajith on 5/3/17.
//  Copyright © 2017 sinergiasinergia. All rights reserved.
// comment

#import "VideoPlayerViewController.h"
#import "YTplayerview.h"

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.strngvideotitle;
    self.playerView=[[YTPlayerView alloc]initWithFrame:CGRectMake(0,0,375,290)];
    [self.playerView loadWithVideoId:self.strngvideoId];
    [self.view addSubview:_playerView];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
