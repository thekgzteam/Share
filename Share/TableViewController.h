//
//  TableViewController.h
//  Share
//
//  Created by Edil Ashimov on 8/18/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "IntroductionViewController.h"
#import "TableViewCell.h"
#import <Parse/Parse.h>

@interface TableViewController : IntroductionViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *commentDescription;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
