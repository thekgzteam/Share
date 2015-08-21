//
//  CategoriesViewController.m
//  Share
//
//  Created by Jim & Lisa on 8/17/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "CategoriesViewController.h"
@interface CategoriesViewController ()

@end

@implementation

CategoriesViewController
- (IBAction)buttonRestaurants:(UIButton *)sender {

}



- (IBAction)buttonEntertainment:(UIButton *)sender {
}
- (IBAction)buttonNews:(UIButton *)sender {

}



- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect labelFrame = CGRectMake( 10, 40, 100, 30 );
    UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
    [label setText: @"My Label"];
    [label setTextColor: [UIColor orangeColor]];

}

- (IBAction)logOutButton:(id)sender {
    [PFUser logOut];

    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
