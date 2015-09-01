//
//  PfQueryObjects.m
//  Share
//
//  Created by Edil Ashimov on 8/31/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "PFQueryObjects.h"
#import <Parse/Parse.h>

@implementation PFQueryObjects

-(void)queryForCategory:(NSString *)category withMethod:(void (^)(NSArray *array))completionMethod {

    NSLog (@"start query");
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"category" equalTo:category];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.allPFObjects = [[NSArray alloc] initWithArray:objects];

            NSLog(@"Qeury is over");
            completionMethod(objects);
        } else {
            NSLog(@"----> ERROR: %@", error);
        }
    }];

}
@end
