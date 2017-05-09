//
//  DropdownList.m
//  YoututbePlayer
//
//  Created by Ajith on 5/3/17.
//  Copyright © 2017 sinergiasinergia. All rights reserved.
//

#import "DropdownList.h"
#import "XMLReader.h"
#import "list.h"

@interface DropdownList ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@end
@implementation DropdownList

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title=@"Search";
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    }

- (void)didReceiveMemoryWarning
   {
    [super didReceiveMemoryWarning];
   }

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
 {
    if(searchText && [searchText length] > 3)
    {
       self.suggestionResponseData = [NSMutableData data];
        NSString *stringurl=[NSString stringWithFormat:@"http://google.com/complete/search?output=toolbar&q="];
        NSString *appendstring=[stringurl stringByAppendingString:searchText];
        NSURLRequest *nrl=[NSURLRequest requestWithURL:[NSURL URLWithString:appendstring]];
        NSURLConnection *connection=[NSURLConnection connectionWithRequest:nrl delegate:self];
        [connection start];
        }
    else
    {
        [self.suggestionList removeAllObjects];
        [self.tableview reloadData];
 
    }
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
      NSError *err=nil;
      NSDictionary *dict = [XMLReader dictionaryForXMLData:self.suggestionResponseData error:&err];
      self.suggestionList =[ [dict objectForKey:@"toplevel"] objectForKey:@"CompleteSuggestion"];
      [_tableview reloadData];
 }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
    return self.suggestionList.count;
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.font=[UIFont fontWithName:@"Thonburi-Light" size:14];
    cell.textLabel.text = [[[self.suggestionList objectAtIndex:indexPath.row] objectForKey:@"suggestion"] objectForKey:@"@data"];
    return cell;
 }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.searchText.text = [[[self.suggestionList objectAtIndex:indexPath.row] objectForKey:@"suggestion"] objectForKey:@"@data"];
    list *n=[[list alloc]init];
    n.searchstring=[NSString stringWithFormat:@"%@",self.searchText.text];
    [self.suggestionList removeAllObjects];
    [tableView reloadData];
    [self.navigationController pushViewController:n animated:YES];
}


@end
