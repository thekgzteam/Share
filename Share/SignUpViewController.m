//
//  SignUpViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/17/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "SignUpViewController.h"
#import "LogInViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *reenterPasswordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property UIImage *image;
@property UIImagePickerController *picker2;
@property UIImagePickerController *picker;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end


@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.usernameTextfield.placeholder = @"  First and Lastname";
    self.passwordTextfield.placeholder = @"  Password";
    self.emailTextfield.placeholder = @"  Email";
    self.reenterPasswordTextfield.placeholder = @"  Re-enter Password";

    self.registerButton.layer.cornerRadius = 8.0;
    self.usernameTextfield.layer.cornerRadius = 8.0;
    self.passwordTextfield.layer.cornerRadius = 8.0;
    self.emailTextfield.layer.cornerRadius = 8.0;
    self.reenterPasswordTextfield.layer.cornerRadius = 8.0;

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(profileImageTapped:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.profileImageView addGestureRecognizer:tapRecognizer];
}

# pragma mark - User Interaction

- (void)profileImageTapped:(UITapGestureRecognizer *)recognizer {
        [self  ChooseExisting];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    if ([self.usernameTextfield isFirstResponder] && [touch view] != self.usernameTextfield)
        [self.usernameTextfield resignFirstResponder];

        ([self.passwordTextfield isFirstResponder] && [touch view] != self.passwordTextfield); {
        [self.passwordTextfield resignFirstResponder];

        ([self.reenterPasswordTextfield isFirstResponder] && [touch view] != self.reenterPasswordTextfield); {
        [self.reenterPasswordTextfield resignFirstResponder];

        ([self.emailTextfield isFirstResponder] && [touch view] != self.emailTextfield);{
        [self.emailTextfield resignFirstResponder];
            }
        [super touchesBegan:touches withEvent:event];
        }
    }
}

# pragma mark - UIImagePickerMethods

- (IBAction)ChooseExisting {
    _picker2 =[[UIImagePickerController alloc] init];
    self.picker2.delegate = self;
    [self.picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.picker2 animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.profileImageView setImage:self.image];
    [self dismissViewControllerAnimated:YES completion:NULL];

}

#pragma mark - Sign Up Methods

- (IBAction)registerButtonTapped:(id)sender {

    [self.registerButton setEnabled:false];
    [self checkEmailFormat];
    [self.usernameTextfield resignFirstResponder];
    [self.emailTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    [self.reenterPasswordTextfield resignFirstResponder];
}

#pragma mark - Check Fields

- (void)checkEmailFormat{
    if ([self.emailTextfield.text isEqualToString:@""])  {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Email is Wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        [self checkFieldsComplete];
    }
}

- (void)checkFieldsComplete{
    if ([self.usernameTextfield.text isEqualToString:@""] || [self.emailTextfield.text isEqualToString:@""] || [self.passwordTextfield.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Message need to be completed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        [self checkPasswordMatch];
    }
}

- (void)checkPasswordMatch {
    if (![self.passwordTextfield.text isEqualToString:self.reenterPasswordTextfield.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Passwords don't match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self registerNewUser];
    }
}

-(void)registerNewUser {
    NSLog(@"registering...");
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameTextfield.text;
    newUser.email = self.emailTextfield.text;
    newUser.password = self.passwordTextfield.text;

    NSData *imageData = UIImageJPEGRepresentation(self.profileImageView.image, 0.8);
    PFFile *imageFile = [PFFile fileWithData:imageData];

    [imageFile saveInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [newUser setObject:imageFile forKey:@"ProfilePic"];
            [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)  {
                if (!error) {
                    NSLog(@"Registration success!");
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Complete" message:@"Registration success!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];

                    [self performSegueWithIdentifier:@"registerSegue" sender:self];
                }
                else {
                    NSLog(@"There was an error in registration. Error: %@", error.localizedDescription);
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:[NSString stringWithFormat:@"There was an error in registration. Error: %@", error.localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        } else {
            NSLog(@"There was an error saving the user and image: %@", error.localizedDescription);
        }
    }];
}
@end
