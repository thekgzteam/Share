//
//  MapViewController.m
//  Share
//
//  Created by Jim & Lisa on 8/17/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import <mapKit/mapKit.h>
#import <Parse/Parse.h>
#import "MapViewController.h"
#import "ShareItViewController.h"
#import "DetailPostInformationViewController.h"
#import "CategoriesViewController.h"
#import "PfQueryObjects.h"
#import "ProfileViewController.h"
#import "SharePostAnnotation.h"
#import "AllImagesViewController.h"

@interface MapViewController () <UIPopoverPresentationControllerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property MKPointAnnotation *signatureRoom;
@property CLLocationManager *locationManager;
@property NSString *Title;
@property NSString *AddPost;
@property UIPopoverController *popOver;
@property PFObject *object;
@property BOOL hasZoomed;
@property SharePostAnnotation *selectedAnnotation;
@property MKPinAnnotationView *pinAnnotationView;

@end


@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGestureRecognizerToMap];
    self.mapView.showsUserLocation = true;
    [self retrieveCoordinatesFromParse];
    self.hasZoomed = NO;

    NSLog(@"locating");
    NSLog(@"category selected == %@", self.category);
}

#pragma mark - User Interaction

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {

    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    NSLog(@"tap regoznized");

    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];

    self.postAnnotation = [[MKPointAnnotation alloc] init];
    self.postAnnotation.coordinate = touchMapCoordinate;
    self.postAnnotation.title = @"Click + button To Add  a Post";

    [self.mapView addAnnotation:self.postAnnotation];
    [self.mapView selectAnnotation:self.postAnnotation animated:YES];
}

- (IBAction)onArrowButtonPressed:(id)sender {
    [self setZoom];
}

#pragma mark - Map

//Costumizing the Pin
-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

    if (annotation == self.mapView.userLocation) {
        return nil;
    }

    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    pin.pinColor = MKPinAnnotationColorPurple;
    pin.canShowCallout =  YES;

    if ([pin.annotation.title isEqualToString:@"Click + button To Add  a Post"]) {
        pin.rightCalloutAccessoryView = nil;
        self.pinAnnotationView = pin;
    } else {
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }

    pin.draggable = NO;
    pin.image = [UIImage imageNamed:@"pin"];

    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"popover2" sender:view.annotation];
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    if (self.hasZoomed == NO) {
        [self setZoom];
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    self.selectedAnnotation = view.annotation;
}

- (void)setZoom {

    CLLocationCoordinate2D userCoordinate = self.mapView.userLocation.coordinate;

    MKCoordinateSpan coordinateSpan;
    coordinateSpan.longitudeDelta = 0.02;
    coordinateSpan.latitudeDelta = 0.02;

    MKCoordinateRegion region;
    region.center = userCoordinate;
    region.span = coordinateSpan;

    [self.mapView setRegion:region animated:YES];

    self.hasZoomed = YES;
}

//Long Press Getsture Recognizer Methods
- (void) addGestureRecognizerToMap {
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                                initWithTarget:self action:@selector (handleLongPress:)];

    longPressGestureRecognizer.minimumPressDuration = 0.5; //length of user press
    [self.mapView addGestureRecognizer:longPressGestureRecognizer];
}

#pragma mark - Parse 

- (void)retrieveCoordinatesFromParse {

    PFQueryObjects *query = [PFQueryObjects new];
    [query queryForCategory:self.category withMethod:^(NSArray *array) {

        for (PFObject *post in array) {

            SharePostAnnotation *annotation = [SharePostAnnotation new];
            annotation.postObjectId = post.objectId;
            double longitude = [[post objectForKey:@"longitude"]doubleValue];
            double latitude = [[post objectForKey:@"latitude"]doubleValue];

            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            annotation.coordinate = coordinate;
            annotation.title = [post objectForKey:@"text"];
            annotation.subtitle = [post objectForKey:@"description"];

            [self.mapView addAnnotation:annotation];

            NSLog(@"%@", annotation);
            NSLog(@"%f", annotation.coordinate.latitude);
            NSLog(@"%f", annotation.coordinate.longitude);
        }
        self.allPosts = array;
        [self.mapView showAnnotations:self.mapView.annotations animated:YES];
    }];
}

#pragma mark - Segue

//PopOverSegue Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"popover"]) {
        ShareItViewController *dvc =  segue.destinationViewController;
        dvc.modalPresentationStyle = UIModalPresentationPopover;
        dvc.popoverPresentationController.delegate = self;
        dvc.postAnnotation = self.postAnnotation;
        dvc.postCategory = self.category;
        dvc.selectedAnnotation = self.selectedAnnotation;
        dvc.pinAnnotationView = self.pinAnnotationView;
        
    } else if ([segue.identifier  isEqual: @"popover2"]) {
        DetailPostInformationViewController *popoverViewContoller =  segue.destinationViewController;
        NSLog(@"Sender: %@", sender);
        SharePostAnnotation *spa = (SharePostAnnotation *)sender;
        popoverViewContoller.selectedPost = spa.postObjectId;

    } else if ([segue.identifier isEqualToString:@"allImagesSegue"]) {
        AllImagesViewController *allImagesViewController = segue.destinationViewController;
        NSLog(@">>>>>>>> self.allPosts == %li", self.allPosts.count);
        allImagesViewController.postsArray = self.allPosts;
        for(PFObject *post in self.allPosts) {
            NSLog(@"---> %@", post.objectId);
        }
        NSLog(@">>>>>>>> self.allPosts == %li", self.allPosts.count);
    }
}

//PopOverSegue Methods
- (void)prepareForNextSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"popover2"]) {
        DetailPostInformationViewController *popoverViewContoller =  segue.destinationViewController;
        popoverViewContoller.modalPresentationStyle = UIModalPresentationPopover;
        popoverViewContoller.popoverPresentationController.delegate = self;
        popoverViewContoller.selectedPost = sender;
    }
}


- (IBAction)unwindAndbookit:(UIStoryboardSegue *) segue {

}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

@end
