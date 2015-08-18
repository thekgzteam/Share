//
//  ImageViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/18/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageCollectionViewCell.h"
@interface ImageViewController ()

@end

@implementation ImageViewController

@synthesize imageCollection, loadingSpinner;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryParseMethod];

}
-(void)queryParseMethod {
    NSLog (@"start query");
    PFQuery *query = [PFQuery queryWithClassName:@"collectionImage"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
        }
        [self.imageCollection reloadData];
    }];

}

    -(NSInteger)numberOfSectionsInTableView:(UICollectionView *)collectionView {
        return 1;
    }

    -(NSInteger)collectionView: (UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return [imageFilesArray count];
    }

    -(UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

       NSString *cellidentifier = @"imageCell";
        ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellidentifier forIndexPath:indexPath];
        PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
        PFFile *imageFile = [imageObject objectForKey:@"imageFile"];

        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.parseImage.image = [UIImage imageWithData:data];
            NSLog (@"getting image");
        }
    }];
        return cell;
       
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self likeImage:[imageFilesArray objectAtIndex:indexPath.row]];
}

-(void) likeImage:(PFObject*)object {

    NSLog(@"Current user: %@", [PFUser currentUser].objectId);
    [object addUniqueObject:[PFUser currentUser].objectId forKey:@"favorites"];

    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if (!error) {
        NSLog(@"selected picture!");
        [self likedSuccess];
        }
    else {
        [self likedFail];
        }
    }];
}

-(void) likedSuccess {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"You have liked the image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}

-(void) likedFail {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error liking the image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}































@end
