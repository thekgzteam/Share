//
//  ImageViewController.h
//  Share
//
//  Created by Edil Ashimov on 8/18/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface AllImagesViewController : UIViewController {

}
@property NSArray *ImageFilesArray;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollection;
@property (nonatomic, strong) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property NSString *category;


@end
