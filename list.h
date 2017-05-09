//
//  list.h
//  YoututbePlayer
//
//  Created by Ajith on 5/3/17.
//  Copyright © 2017 sinergiasinergia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface list : UIViewController
@property (nonatomic, strong) NSMutableData *suggestionResponseData;
@property (nonatomic, strong) NSMutableArray *suggestionList;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableString *videoID;
@property(nonatomic,strong) NSString *searchstring;
@property (nonatomic, strong) NSMutableString *imgUrl;
@property (nonatomic, strong) NSMutableString *videotitle;

@end
