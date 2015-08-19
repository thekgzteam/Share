//
//  ProfileViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/19/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionViewCell.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self queryParseMethod];
    [self retrieveFavoriteImages];
}

    -(void)queryParseMethod {
        NSLog (@"start query");
        PFQuery *query = [PFQuery queryWithClassName:@"collectionImage"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                imageFilesArray = [[NSArray alloc] initWithArray:objects];
            }
            [self.collectionOfImages reloadData];
            NSLog(@"Qeury is over");
        }];

    }

    -(NSInteger)numberOfSectionsInTableView:(UICollectionView *)collectionView {
        return 1;
    }

    -(NSInteger)collectionView: (UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return [imageFilesArray count];
    }

    -(UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

        NSString *cellidentifier = @"cellid";
        ProfileCollectionViewCell *cell = (ProfileCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellidentifier forIndexPath:indexPath];
        PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
        PFFile *imageFile = [imageObject objectForKey:@"imageFile"];

        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell.parseImageHolder.image = [UIImage imageWithData:data];
                NSLog (@"getting image");
            }
        }];
        return cell;
        
    }
-(void) retrieveFavoriteImages {
    PFQuery *getFavorites = [PFQuery queryWithClassName:@"collectionImage"];
    [getFavorites whereKey:@"favorites" equalTo:[PFUser currentUser].objectId];

    [getFavorites findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
        }
        NSLog(@"%@", objects);
        [self.collectionOfImages reloadData];
    }];
}
- (IBAction)onButtonPressed:(id)sender {
    [self retrieveFavoriteImages];
}

- (IBAction)buttonpressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}















@end
