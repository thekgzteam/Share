//
//  ProfileViewController.h
//  Share
//
//  Created by Edil Ashimov on 8/19/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController {
    NSArray *imageFilesArray;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionOfImages;
@property (weak, nonatomic) IBOutlet UICollectionView *ProfileVisualImage;
@property NSMutableArray *messageArray;
@property NSArray *usernameArray;

@end

