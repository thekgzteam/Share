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

@interface AllImagesViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation AllImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(NSInteger)numberOfSectionsInTableView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView: (UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postsArray.count;
}

-(UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellidentifier = @"imageCell";
    AllImageCollectionViewCell *cell = (AllImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellidentifier forIndexPath:indexPath];

    PFObject *imageObject = [self.postsArray objectAtIndex:indexPath.row];
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self likeImage:[self.postsArray objectAtIndex:indexPath.row]];
}

-(void) likeImage:(PFObject*)object {

    NSLog(@"Current user: %@", [PFUser currentUser].objectId);
    [object addUniqueObject:[PFUser currentUser].objectId forKey:@"favorites"];

    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //        self.
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
