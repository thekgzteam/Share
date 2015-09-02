//
//  CategoriesViewController.m
//  Share
//
//  Created by Jim & Lisa on 8/17/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "CategoriesViewController.h"
#import "MapViewController.h"
#import <Parse/Parse.h>
#import "ShareItViewController.h"
@interface CategoriesViewController ()
@property (weak, nonatomic) IBOutlet UIButton *restaurantButton;

@property (weak, nonatomic) IBOutlet UIButton *shoppingButton;
@property (weak, nonatomic) IBOutlet UIButton *newsButton;
@property (weak, nonatomic) IBOutlet UIButton *entertainmentButton;
@property (weak, nonatomic) IBOutlet UIButton *sportsButton;
@property (weak, nonatomic) IBOutlet UIButton *otherButton;
@property (weak, nonatomic) IBOutlet UIButton *topPatriesButton;
@property (weak, nonatomic) IBOutlet UIButton *businessMeetingButton;

@property NSString *selectedCategory;
@end

@implementation

CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restaurantButton.layer.masksToBounds = YES;
    self.restaurantButton.layer.cornerRadius = 4.0;

    self.entertainmentButton.layer.cornerRadius = 4.0;

    self.shoppingButton.layer.cornerRadius = 4.0;

    self.newsButton.layer.cornerRadius = 4.0;
    self.sportsButton.layer.cornerRadius = 4.0;
    self.otherButton.layer.cornerRadius = 4.0;
    self.businessMeetingButton.layer.cornerRadius = 4.0;
    self.topPatriesButton.layer.cornerRadius = 4.0;

}



- (IBAction)logOutButton:(id)sender {
    [PFUser logOut];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"categoriesSegue"]) {
        MapViewController *mapViewContoller =  segue.destinationViewController;
        mapViewContoller.category = self.selectedCategory;
    }
}
- (IBAction)buttonPressed:(UIButton *)sender {
    self.selectedCategory = sender.titleLabel.text;
    [self performSegueWithIdentifier:@"categoriesSegue" sender:sender];


}

- (IBAction)unwindAndbookit:(UIStoryboardSegue *) segue{
}
@end
