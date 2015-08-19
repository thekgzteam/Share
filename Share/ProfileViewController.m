//
//  ProfileViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/19/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionViewCell.h"
#import "ProfileTableViewCell.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self queryParseMethod];
    [self retrieveFavoriteImages];
    [self retrieveFavoriteComments];
    [self retrieveCommentsFromParse];

    self.profileImage.image = [UIImage imageNamed:@"profilepicture"];
}

    -(void)queryParseMethod {
        NSLog (@"start query");
        PFQuery *query = [PFQuery queryWithClassName:@"Post"];
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
        PFFile *imageFile = [imageObject objectForKey:@"image"];

        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell.parseImageHolder.image = [UIImage imageWithData:data];
                NSLog (@"getting image");
            }
        }];
        return cell;
        
    }
-(void) retrieveFavoriteImages {
    PFQuery *getFavorites = [PFQuery queryWithClassName:@"Post"];
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

//-pragma mark for table view
-(void) retrieveCommentsFromParse {
    PFQuery *retrieveDescription = [PFQuery queryWithClassName:@"Post"];

    [retrieveDescription findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            commentDescription = [[NSArray alloc] initWithArray:objects];
        }
        NSLog(@"%@", objects);
        [self.collectionOfComments reloadData];
    }];
}


-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [commentDescription count];
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellid"];
    PFObject *tempObject = [commentDescription objectAtIndex:indexPath.row];

     cell.textLabel.text = [tempObject objectForKey:@"text"];

    return cell;

}
-(void) retrieveFavoriteComments {
    PFQuery *getFavoriteComments = [PFQuery queryWithClassName:@"Post"];
    [getFavoriteComments whereKey:@"comments" equalTo:[PFUser currentUser].objectId];

    [getFavoriteComments findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
        }
        NSLog(@"%@", objects);
        [self.collectionOfComments reloadData];
    }];
}


- (IBAction)goBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}













@end
