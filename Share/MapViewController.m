//
//  MapViewController.m
//  Share
//
//  Created by Jim & Lisa on 8/17/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "MapViewController.h"
#import <mapKit/mapKit.h>



@interface MapViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property MKPointAnnotation *chicagoIlannotation;
@property CLLocationManager *locationManager;
@property NSString *Title;
@property NSString *AddPost;
@property UIPopoverController *popOver;
@property (weak, nonatomic) IBOutlet UIButton *popButton;
@end

@implementation MapViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    [self addGestureRecognizerToMap];
    [self.mapView setZoomEnabled:YES];
    



    double latitude = 41.90;
    double longitude = -87.65;

//    CLLocationCoordinate2D location;

    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = true;

    self.chicagoIlannotation = [MKPointAnnotation new];
    self.chicagoIlannotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [self.mapView addAnnotation: self.chicagoIlannotation];

}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

    NSLog(@"updating");
    CLLocationCoordinate2D centerCoordinate = self.mapView.userLocation.coordinate;

    MKCoordinateRegion region;
    MKCoordinateSpan coordinateSpan;
    coordinateSpan.longitudeDelta = 0.02;
    coordinateSpan.latitudeDelta = 0.02;
    region.center = centerCoordinate;
    region.span = coordinateSpan;

    [self.mapView setRegion:region animated:YES];

}


-(void)mapViewWillStartLocatingUser:(MKMapView *)mapView{
    NSLog(@"locating");
}

-(void) addGestureRecognizerToMap {


    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    longPressGestureRecognizer.minimumPressDuration = 0.5; //length of user press

    [self.mapView addGestureRecognizer:longPressGestureRecognizer];


}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {

    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    NSLog(@"tap regoznized");

    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];

    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.coordinate = touchMapCoordinate;
    annot.subtitle = @"Click To Add";
    annot.title = @"Post";


    [self.mapView addAnnotation:annot];
}
-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    if (annotation == mapView.userLocation) {
        return nil;
    }else{
    pin.pinColor = MKPinAnnotationColorPurple;
    pin.canShowCallout =  YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pin.draggable = NO;
    pin.image = [UIImage imageNamed:@"RestaurantsIcon"];
    return pin;
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Post" message:@"Share an Event" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction* Save = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [alertController addAction:Save];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *nameTextField) {
        nameTextField.placeholder = @"Name";

//        [nameTextField set];

    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *durationTextField) {
        durationTextField.placeholder = @"Duration";

    }];

    [self presentViewController:alertController animated:YES completion:nil];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"popover"]) {
        UIViewController *popoverViewContoller =  segue.destinationViewController;
        popoverViewContoller.modalPresentationStyle = UIModalPresentationPopover;
        popoverViewContoller.popoverPresentationController.delegate = self;
    }

}
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}



@end
