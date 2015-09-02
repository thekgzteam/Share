//
//  MapViewController.h
//  Share
//
//  Created by Jim & Lisa on 8/17/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController <UIGestureRecognizerDelegate, MKMapViewDelegate>
@property NSMutableArray *coordinatesArray;
@property MKPointAnnotation *postAnnotation;
@property NSString *category;
@property NSArray *allPosts;
@end
