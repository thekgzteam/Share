//
//  TableViewCell.m
//  Share
//
//  Created by Edil Ashimov on 8/18/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "AllCommentsListViewCell.h"

@implementation AllCommentsListViewCell

- (void)awakeFromNib {
    self.imageView.frame = CGRectMake(0,0,32,32);
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
