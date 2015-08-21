//
//  ViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/17/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "IntroductionViewController.h"



@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    NSArray *imageArray;
    self.intro.image = [UIImage imageNamed:@"Intro"];
    NSLog(@"%@", self.intro.image);

    imageArray = [[NSArray alloc] initWithObjects:
                  [UIImage imageNamed:@""], nil];


}

@end
