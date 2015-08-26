//
//  TableViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/18/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AllCommentsListViewController.h"

#import "ImageCellFormat.h"
@interface AllCommentsListViewController ()<UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchController *searchControllers;
@property NSArray *filteredResults;

@end


@implementation AllCommentsListViewController

- (void)viewDidLoad {
[super viewDidLoad];
[self retrieveFromParse];
[self.tableView reloadData];
self.posts = [NSMutableArray new];

self.searchControllers = [[UISearchController alloc] initWithSearchResultsController:nil];
self.searchControllers.searchResultsUpdater = self;
self.searchControllers.delegate = self;
self.searchControllers.dimsBackgroundDuringPresentation = false;
[self.searchControllers.searchBar  sizeToFit];


//self.searchControllers.searchBar.frame = CGRectMake(self.searchControllers.searchBar.frame.origin.x, self.searchControllers.searchBar.frame.origin.y + 500, self.searchControllers.searchBar.frame.size.width, 44.0);

//[imageView setFrame:CGRectMake(100, 100, imageView.frame.size.width, imageView.frame.size.height)];
//}
self.tableView.tableHeaderView = self.searchControllers.searchBar;
[self.tableView reloadData];
}



// Getting a Data From Parse
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


//Table View Methods
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





//// - Selecting a row and adding to your favorites
//-(void)tableView:(UITableView tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self likeComment:[self.posts objectAtIndex:indexPath.row]];
//}
//
//// Adding the selected row to
//-(void)likeComment:(PFObject *)object {
//    [object addUniqueObject:[PFUser currentUser].objectId forKey:@"comments"];
//
//    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            NSLog(@"selected row!");
//            [self likedSuccess];
//        }
//        else {
//            [self likedFail];
//        }
//    }];
//}
//
//-(void) likedSuccess {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"You have added the comment to your profile" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
//
//}
//
//-(void) likedFail {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error adding the comment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
}

-(IBAction)goBackButton:(id)sender {
[self dismissViewControllerAnimated:YES completion:nil];
}

@end
