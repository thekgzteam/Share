//
//  TableViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/18/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "TableViewController.h"


@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self performSelector:@selector(retrieveFromParse)];
}

    -(void) retrieveFromParse {
        PFQuery *retrieveDescription = [PFQuery queryWithClassName:@"tableView"];

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

    cell.textLabel.text = [tempObject objectForKey:@"description"];

    return cell;

}
































@end
