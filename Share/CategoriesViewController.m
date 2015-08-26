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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *entertainmentButton;
@property (weak, nonatomic) IBOutlet UIButton *sportsButton;
@property (weak, nonatomic) IBOutlet UIButton *vacantButton;
@property (weak, nonatomic) IBOutlet UIButton *topPatriesButton;
@property (weak, nonatomic) IBOutlet UIButton *vacantButton2;


@end

@implementation

CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(406, 800)];
    self.restaurantButton.layer.masksToBounds = YES;
    self.restaurantButton.layer.cornerRadius = 8.0;

    self.entertainmentButton.layer.cornerRadius = 8.0;

    self.shoppingButton.layer.cornerRadius = 8.0;

    self.newsButton.layer.cornerRadius = 8.0;
    self.sportsButton.layer.cornerRadius = 8.0;
    self.vacantButton.layer.cornerRadius = 8.0;
    self.vacantButton2.layer.cornerRadius = 8.0;
    self.topPatriesButton.layer.cornerRadius = 8.0;
}





- (IBAction)logOutButton:(id)sender {
    [PFUser logOut];

    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
