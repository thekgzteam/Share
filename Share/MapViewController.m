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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//}

@end
