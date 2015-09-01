//
//  ImageViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/18/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "AllImagesViewController.h"
#import "AllImageCollectionViewCell.h"
#import "PFQueryObjects.h"

@interface AllImagesViewController ()

@end

@implementation AllImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PFQueryObjects *query = [PFQueryObjects new];
    [query queryForCategory:self.category withMethod:^(NSArray *array) {
        self.ImageFilesArray = array;
        NSLog(@"%@", array);

    }];
}


//-(void)queryParseMethod {
//    NSLog (@"start query");
//    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            imageFilesArray = [[NSArray alloc] initWithArray:objects];
//        }
//        [self.imageCollection reloadData];
//        NSLog(@"Qeury is over");
//    }];
//
//}
//}
//-(void)retrieveCoordinatesFromParse {
//    PFQueryObjects *query = [PFQueryObjects new];
//    [query queryForCategory:self.images withMethod:^(NSArray *array) {
//        self.ImageFilesArray = array;
//    }];
//    }
-(NSInteger)numberOfSectionsInTableView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView: (UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.ImageFilesArray count];
}

-(UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

   NSString *cellidentifier = @"imageCell";
    AllImageCollectionViewCell *cell = (AllImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellidentifier forIndexPath:indexPath];

    PFObject *imageObject = [self.ImageFilesArray objectAtIndex:indexPath.row];
    PFFile *imageFile = [imageObject objectForKey:@"image"];

    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.parseImage.image = [UIImage imageWithData:data];
            cell.parseImageText.text = [imageObject objectForKey:@"text"];
            NSLog (@"getting image");
        }
    }];
    return cell;
       
}
- (IBAction)onLikeButtonPressed:(id)sender {
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self likeImage:[self.ImageFilesArray objectAtIndex:indexPath.row]];
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

- (IBAction)gobackbutton:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];

}





























@end
