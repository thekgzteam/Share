//
//  ImageCellFormat.m
//  Share
//
//  Created by Edil Ashimov on 8/20/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "ImageCellFormat.h"

@implementation ImageCellFormat

- (UIImage*)imageScaledToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
