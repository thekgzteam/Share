//
//  PfQueryObjects.h
//  Share
//
//  Created by Edil Ashimov on 8/31/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFQueryObjects : NSObject

@property NSArray *allPFObjects;

-(void)queryForCategory:(NSString *)category withMethod:(void (^)(NSArray *array))completionMethod;

@end
