//
//  LaunchScreenViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/30/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "LaunchScreenViewController.h"
#import "CustomView.h"


@interface LaunchScreenViewController ()
@property (weak, nonatomic) IBOutlet CustomView *customView;

@end

@implementation LaunchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customView addUntitled1AnimationCompletionBlock:^(BOOL finished) {
        NSLog(@"Animated finished");
    }];
    [NSTimer scheduledTimerWithTimeInterval:2.3f
                                     target:self selector:@selector(segue) userInfo:nil repeats:NO];
}


-(void)segue{
    [self performSegueWithIdentifier:@"segueLauchScreen" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"segueLauchScreen"]) {
        UINavigationController *loginViewController =  segue.destinationViewController;
        loginViewController.modalPresentationStyle = UIModalPresentationPopover;

    }
}

@end


