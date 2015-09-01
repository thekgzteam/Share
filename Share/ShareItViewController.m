//
//  ShareItViewController.m
//  
//
//  Created by Edil Ashimov on 8/24/15.
//
//
#import <Parse/Parse.h>
#import "MapViewController.h"
#import "ShareItViewController.h"

@interface ShareItViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextfield;


@property UIImagePickerController *picker;
@property UIImagePickerController *picker2;
@property IBOutlet UIImageView *imageView;
@property UIImage *image;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityContoller;

@property (weak, nonatomic) IBOutlet UIButton *PostButton;



@end

@implementation ShareItViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityContoller.hidden = YES;

    self.nameTextfield.placeholder = @"Name";
    self.descriptionTextfield.placeholder = @"Description";



}
- (IBAction)TakePhoto {
    self.picker =[[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.
     picker animated:YES completion:NULL];

}

- (IBAction)ChooseExisting {
    _picker2 =[[UIImagePickerController alloc] init];
    self.picker2.delegate = self;
    [self.picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.picker2 animated:YES completion:NULL];
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageView setImage:self.image];
    [self dismissViewControllerAnimated:YES completion:NULL];

}
- (IBAction)onPostButtonPressed:(id)sender {
    [self.activityContoller startAnimating];
    self.activityContoller.hidden = NO;
    self.PostButton.enabled = NO;


    PFObject *textMessage = [PFObject objectWithClassName:@"Post"];
    textMessage[@"text"] = self.nameTextfield.text;
    textMessage[@"description"] = self.descriptionTextfield.text;
    textMessage[@"latitude"] =  [NSNumber numberWithFloat:self.postAnnotation.coordinate.latitude];
    textMessage[@"longitude"] =  [NSNumber numberWithFloat:self.postAnnotation.coordinate.longitude];
    textMessage[@"image"] = UIImagePNGRepresentation(self.imageView.image);

//    NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
//    PFFile *file = [PFFile fileWithData:imageData];





////Getting the Current User's Location
//    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
//        if (!error) {
//            // do something with the new geoPoint
//        }
//    }];

    [textMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self.activityContoller stopAnimating];
            self.activityContoller.hidden = YES;
            NSLog(@"The Message Has Been Saved");
            [self postSuccess];
            self.nameTextfield.text = 0;
            self.descriptionTextfield.text = 0;
//            self.imageView.image = 0;
            [self dismissViewControllerAnimated:YES completion:NULL];

        } else {
            [self postFail];
            NSLog(@"Error Saving the Message");        }
    }];


}


//insert a user current location to *textMessage[@"location"]



//AlertViews
-(void) postSuccess {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Thank you for making a post" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}

-(void) postFail {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error making a post" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}


////Message Send Button Saving Method
//- (IBAction)onPostButtonTapped:(id)sender {
//
//    PFObject *textMessage = [PFObject objectWithClassName:@"Message"];
//    textMessage[@"messageText"] = self.messageTextfield.text;
//
//    [textMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            NSLog(@"The Message Has Been Saved");
//            self.messageTextfield.text = 0;
//            [self.messageTableView reloadData];
//        } else {
//            NSLog(@"Error Saving the Message");        }
//    }];
//    
//    
//}

@end
