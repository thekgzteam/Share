//
//  TableViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/18/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "AllCommentsListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageCellFormat.h"
@interface AllCommentsListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation AllCommentsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveFromParse];
    [self.tableView reloadData];
    self.posts = [NSMutableArray new];

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
    return self.posts.count;
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Loading tableview.");
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellid"];

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

// - Selecting a row and adding to your favorites
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self likeComment:[self.posts objectAtIndex:indexPath.row]];
}

// Adding the selected row to
-(void)likeComment:(PFObject *)object {
    [object addUniqueObject:[PFUser currentUser].objectId forKey:@"comments"];

    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"selected row!");
            [self likedSuccess];
        }
        else {
            [self likedFail];
        }
    }];
}

-(void) likedSuccess {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"You have added the comment to your profile" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}

-(void) likedFail {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error adding the comment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(IBAction)goBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
