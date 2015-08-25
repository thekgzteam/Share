//
//  CategoriesViewController.m
//  Share
//
//  Created by Jim & Lisa on 8/17/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "CategoriesViewController.h"
@interface CategoriesViewController ()
@property (weak, nonatomic) IBOutlet UIButton *restaurantButton;
@property (weak, nonatomic) IBOutlet UIButton *shoppingButton;
@property (weak, nonatomic) IBOutlet UIButton *newsButton;
@property (weak, nonatomic) IBOutlet UIButton *entertainmentButton;

@end

@implementation

CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.restaurantButton.layer.masksToBounds = YES;
    self.restaurantButton.layer.cornerRadius = 8.0;

    self.entertainmentButton.layer.cornerRadius = 8.0;

    self.shoppingButton.layer.cornerRadius = 8.0;

    self.newsButton.layer.cornerRadius = 8.0;
}





- (IBAction)logOutButton:(id)sender {
    [PFUser logOut];

    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
