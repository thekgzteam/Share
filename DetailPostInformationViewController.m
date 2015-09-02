//
//  DetailPostInformationViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/28/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "DetailPostInformationViewController.h"
#import <Parse/Parse.h>

@interface DetailPostInformationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImageImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *postName;
@property (weak, nonatomic) IBOutlet UILabel *postDescription;
@property (weak, nonatomic) IBOutlet UILabel *profileInformation;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end


@implementation DetailPostInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryParseMethod];
    [self.activityIndicator startAnimating];

    self.userImageImageView.layer.cornerRadius = 10.0f;
    self.userImageImageView.clipsToBounds = YES;
    self.userImageImageView.layer.borderWidth = 3.0f;
    self.userImageImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //    self.userImageImageView.image = [UIImage imageNamed:@"profileImage"];

    NSLog(@"=====>%@", self.selectedPost);
}

- (void)queryParseMethod {

    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"objectId" equalTo:self.selectedPost];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *post in objects) {
                self.postName.text = [post objectForKey:@"text"];
                self.postDescription.text = [post objectForKey: @"description"];

                // Retrieve user image
                if ([post objectForKey:@"username"] != nil) {
                    NSLog(@"Post username found: %@", [post objectForKey:@"username"]);
                    NSString *username = [post objectForKey:@"username"];
                    PFQuery *userQuery = [PFUser query];
                    [userQuery whereKey:@"username" equalTo:username];
                    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        NSLog(@"Results from user query: %lu", (unsigned long)objects.count);
                        PFUser *postUser = objects.firstObject;
                        PFFile *userImage = [postUser objectForKey:@"ProfilePic"];
                        [userImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error)  {
                            NSLog(@"Getting data for user image.");
                            if (!error) {

                                NSLog(@"No error! Retrieved profile image: %p", data);
                                UIImage *profilePicture = [UIImage imageWithData:data];
                                self.userImageImageView.image = profilePicture;
                                self.profileName.text = [postUser objectForKey:@"username"];
                            } else {
                                NSLog(@"There was an error retrieving the image: %@", error.localizedDescription);
                            }
                        }];
                    }];
                } else {
                    NSLog(@"Post username is nil!");
                }

                // Retireve post image.
                PFFile *imageFile = [post objectForKey:@"image"];
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        [self.activityIndicator stopAnimating];
                        self.activityIndicator.hidden = YES;
                        self.postImage.image = [UIImage imageWithData:data];
                        NSLog (@"Post image was successfully retrieved.");
                    }
                }];
            }
        } else {
            NSLog(@"There was an error retrieving the post.");
        }
        NSLog(@"Qeury is over");
    }];
}

@end
