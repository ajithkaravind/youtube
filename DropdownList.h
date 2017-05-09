//
//  DropdownList.h
//  YoututbePlayer
//
//  Created by Ajith on 5/3/17.
//  Copyright © 2017 sinergiasinergia. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DropdownList : UIViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchText;
@property (nonatomic, strong) NSMutableData *suggestionResponseData;
@property (nonatomic, strong) NSMutableArray *suggestionList;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
