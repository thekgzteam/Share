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
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *postName;
@property (weak, nonatomic) IBOutlet UILabel *postDescription;

@end

@implementation DetailPostInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryParseMethod];

    self.profileImage.layer.cornerRadius = 10.0f;
    self.profileImage.clipsToBounds = YES;
    self.profileImage.layer.borderWidth = 3.0f;
    self.profileImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.postImage.image = [UIImage imageNamed:@"signature room"];
    self.profileImage.image = [UIImage imageNamed:@"profileImage"];
 
    NSLog(@"=====>%@", self.selectedPost);
}
-(void)queryParseMethod {
    NSLog (@"start query");
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {


        if (!error) {
            for (PFObject *image in self.detailDataArray) {
  self.postImage.image = [image objectForKey:@"image"];

            }
        }

        NSLog(@"Qeury is over");

    }];

}





@end
