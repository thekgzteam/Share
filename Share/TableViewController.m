//
//  TableViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/18/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "TableViewController.h"


@interface TableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tableViewImageIcon;
@property (weak, nonatomic) IBOutlet UILabel *tableViewLabel;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveFromParse];
    
}


    -(void) retrieveFromParse {
        PFQuery *retrieveDescription = [PFQuery queryWithClassName:@"Post"];

        [retrieveDescription findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                commentDescription = [[NSArray alloc] initWithArray:objects];
            }
            NSLog(@"%@", objects);
            [self.tableView reloadData];
        }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return commentDescription.count;
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellid"];
    PFObject *tempObject = [commentDescription objectAtIndex:indexPath.row];

    UIImage *foodImages = [UIImage imageNamed:@"food"];

    cell.textLabel.text = [tempObject objectForKey:@"text"];
//    cell.imageView.image = [tempObject objectForKey:@"image"];
    cell.imageView.image = foodImages;

    return cell;

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self likeComment:[commentDescription objectAtIndex:indexPath.row]];
}

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
