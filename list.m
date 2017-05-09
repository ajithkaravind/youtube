//
//  list.m
//  YoututbePlayer
//
//  Created by Ajith on 5/3/17.
//  Copyright © 2017 sinergiasinergia. All rights reserved.
//

#import "list.h"
#import "SearchCellTableViewCell.h"
#import "VideoPlayerViewController.h"
#import "XMLReader.h"

@interface list ()<UITabBarDelegate,UITableViewDataSource>

@end

@implementation list

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=self.searchstring;
    self.suggestionResponseData = [NSMutableData data];
    self.videoID=[NSMutableString string];
    NSString *youtubeApi=@"https://www.googleapis.com/youtube/v3/search?part=snippet&fields=items(id,snippet(title,channelTitle,thumbnails))&order=viewCount&q=\(searchBar.text)&type=video&maxResults=25&key=AIzaSyDtotL6tN1X2M8LQtdXr7_qHRKkPBHMNFo";
    
     NSString *newyoutubeapi=[youtubeApi stringByReplacingOccurrencesOfString:@"\(searchBar.text)" withString:self.searchstring];
     newyoutubeapi = [newyoutubeapi stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSURL *url=[NSURL URLWithString:newyoutubeapi];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     NSURLConnection *connection=[NSURLConnection connectionWithRequest:request delegate:self];
}
-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    return request;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.suggestionResponseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSMutableDictionary *suggestions = [NSJSONSerialization JSONObjectWithData:self.suggestionResponseData options:NSJSONReadingMutableContainers error:nil];
    if([suggestions objectForKey:@"items"])
    {
        self.suggestionList = [suggestions objectForKey:@"items"];
        NSLog(@"suggestionList : %@", self.suggestionList);
        [self.tableview reloadData];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.suggestionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cells";
    SearchCellTableViewCell *cell = (SearchCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell= (SearchCellTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"SearchCellTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.label.text = [[[self.suggestionList objectAtIndex:indexPath.row] objectForKey:@"snippet"] objectForKey:@"title"];
    cell.label.textAlignment=NSTextAlignmentLeft;
    cell.label.lineBreakMode = NSLineBreakByWordWrapping;
    cell.label.numberOfLines = 0;
    cell.label.font=[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15];
    self.imgUrl=[[[[[_suggestionList objectAtIndex:indexPath.row]objectForKey:@"snippet"] objectForKey:@"thumbnails"] objectForKey:@"default"]objectForKey:@"url"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgUrl]];
    cell.img.image=[UIImage imageWithData:imageData];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    self.videoID=[[[_suggestionList objectAtIndex:indexPath.row] objectForKey:@"id"] objectForKey:@"videoId"];
    VideoPlayerViewController *n=[[VideoPlayerViewController alloc]init];
    n.strngvideoId=[NSString stringWithFormat:@"%@",self.videoID];
    self.videotitle=[[[_suggestionList objectAtIndex:indexPath.row] objectForKey:@"snippet"] objectForKey:@"title"];
    n.strngvideotitle=[NSString stringWithFormat:@"%@",self.videotitle];
    [self.navigationController pushViewController:n animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end
