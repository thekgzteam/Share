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
#import "CategoriesViewController.h"
#import "SharePostAnnotation.h"


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

    NSLog(@"=====%@====",self.postCategory);

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


    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.8);
    PFFile *file = [PFFile fileWithData:imageData];


    
    PFObject *post = [PFObject objectWithClassName:@"Post"];
    post[@"text"] = self.nameTextfield.text;
    post[@"description"] = self.descriptionTextfield.text;
    post[@"latitude"] =  [NSNumber numberWithFloat:self.postAnnotation.coordinate.latitude];
    post[@"longitude"] =  [NSNumber numberWithFloat:self.postAnnotation.coordinate.longitude];
    post[@"image"] = file;
    post[@"username"] = [PFUser currentUser].username;
    post[@"category"] = self.postCategory;
    self.selectedAnnotation.title = self.nameTextfield.text;
    self.selectedAnnotation.subtitle = self.descriptionTextfield.text;
//    self.pinAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    MKPinAnnotationView *selectedAnnotationView = test.superview;
//    selectedAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self.activityContoller stopAnimating];
            self.activityContoller.hidden = YES;
            NSLog(@"The Message Has Been Saved");
            [self postSuccess];
            self.nameTextfield.text = 0;
            self.descriptionTextfield.text = 0;
            [self dismissViewControllerAnimated:YES completion:NULL];
        } else {
            [self postFail];
            NSLog(@"Error Saving the Message");
        }
    }];
}

//AlertViews
-(void) postSuccess {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Thank you for making a post" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}

-(void) postFail {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error making a post" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}
@end
