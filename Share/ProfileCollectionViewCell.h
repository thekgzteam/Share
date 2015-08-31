//
//  ProfileCollectionViewCell.h
//  Share
//
//  Created by Edil Ashimov on 8/19/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCollectionViewCell :UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *parseImageText;
@property (weak, nonatomic) IBOutlet UIImageView *parseImageHolder;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
