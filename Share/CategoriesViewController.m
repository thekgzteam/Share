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

}

- (IBAction)logOutButton:(id)sender {
    [PFUser logOut];
   
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
