//
//  SettingsViewController.m
//  Share
//
//  Created by Edil Ashimov on 9/1/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "ProfileSettingsViewController.h"
#import <Parse/Parse.h>

@interface ProfileSettingsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *ProfileName;
@property (weak, nonatomic) IBOutlet UILabel *profileDescription;
@property (weak, nonatomic) IBOutlet UIButton *changePictureButton;
@property (weak, nonatomic) IBOutlet UIButton *changeNameButton;
@property (weak, nonatomic) IBOutlet UIButton *changeDescriptionButton;

@end

@implementation ProfileSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryImageParseMethod];

    self.profilePicture.layer.borderWidth = 4.0f;
    self.profilePicture.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profilePicture.layer.cornerRadius = 10.0f;
    self.profilePicture.clipsToBounds = YES;}

- (void)queryImageParseMethod {

    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"Results from user query: %lu", (unsigned long)objects.count);
        PFUser *postUser = objects.firstObject;
        PFFile *userImage = [postUser objectForKey:@"ProfilePic"];
        [userImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error)  {
            NSLog(@"Getting data for user image.");
            if (!error) {

                NSLog(@"No error! Retrieved profile image: %p", data);
                UIImage *profilePicture = [UIImage imageWithData:data];
                self.profilePicture.image = profilePicture;
                self.ProfileName.text = [postUser objectForKey:@"username"];
            } else {
                NSLog(@"There was an error retrieving the image: %@", error.localizedDescription);
            }
        }];
    }];
    NSLog(@"Post username is nil!");
}
- (IBAction)logOutButton:(id)sender {
        [PFUser logOut];
}


@end
