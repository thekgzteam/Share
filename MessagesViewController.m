//
//  SearchViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/19/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import <Parse/Parse.h>
#import "MessagesViewController.h"


@interface MessagesViewController ()<UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchController *searchControllers;
@property NSArray *filteredResults;
@property NSMutableArray *posts;

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveFromParse];
    [self.tableView reloadData];
    

    self.searchControllers = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchControllers.searchResultsUpdater = self;
    self.searchControllers.delegate = self;
    self.searchControllers.dimsBackgroundDuringPresentation = false;
    [self.searchControllers.searchBar  sizeToFit];
    self.tableView.tableHeaderView = self.searchControllers.searchBar;

}

-(void) retrieveFromParse {
    PFQuery *retrieveDescription = [PFQuery queryWithClassName:@"Post"];
    [retrieveDescription findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        if (!error) {
            for (PFObject *post in objects) {
                [self.posts addObject:post];
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"Error getting data: %@", error);
            
        }
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.searchControllers.active) {
        return self.filteredResults.count;
    }
    else
    {
        return self.posts.count;
    }
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Loading tableview.");
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (self.searchControllers.active) {
        PFObject *post = [self.filteredResults objectAtIndex:indexPath.row];
        cell.textLabel.text = post[@"text"];

        return cell;
    }
    else
    {
        PFObject *post = [self.posts objectAtIndex:indexPath.row];
        PFFile *imageFile = [post objectForKey:@"image"];

        NSString *text = [post objectForKey:@"text"];

        NSLog(@"Loadng post: %@", text);

        cell.textLabel.text = [post objectForKey:@"text"];
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.layer.cornerRadius = 8.0;
        cell.imageView.frame = CGRectMake(0, 50, 50, 50);

        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell.imageView.image = [UIImage imageWithData:data];
                [cell setNeedsLayout];
                NSLog (@"Got image.");

            } else {
                NSLog(@"Error grabbing picutre.");
            }


        }];

        return cell;
    }
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    //[self.filteredResults removeAllObjects];
    NSLog(@"%@", searchController.searchBar.text);
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"SELF.text contains[c] %@",searchController.searchBar.text];
    
    NSArray *array = [self.posts filteredArrayUsingPredicate:predicate];
    self.filteredResults = (NSArray *)array;
    NSLog(@"%li", array.count);
    [self.tableView reloadData];
}
-(IBAction)goBackButton:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
