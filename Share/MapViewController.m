//
//  MapViewController.m
//  Share
//
//  Created by Jim & Lisa on 8/17/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "MapViewController.h"
#import <mapKit/mapKit.h>

@interface MapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property MKPointAnnotation *chicagoIlannotation;
@property CLLocationManager *locationManager;
@end

@implementation MapViewController
- (IBAction)buttonList:(UIBarButtonItem *)sender {
}
- (IBAction)buttonMap:(UIBarButtonItem *)sender {
}
- (IBAction)buttonSearch:(UIBarButtonItem *)sender {
}




- (void)viewDidLoad {
    [super viewDidLoad];
    double latitude = 41.90;
    double longitude = 87.65;

    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];

    self.mapView.delegate = self;
    self.chicagoIlannotation = [MKPointAnnotation new];
    self.chicagoIlannotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [self.mapView addAnnotation: self.chicagoIlannotation];
    self.mapView.showsUserLocation = true;

    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //length of user press
    [self.mapView addGestureRecognizer:lpgr];


}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;

    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];

    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.coordinate = touchMapCoordinate;
    [self.mapView addAnnotation:annot];
}




@end
