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
@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *reenterPasswordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.usernameTextfield.placeholder = @"  Username";
    self.passwordTextfield.placeholder = @"  Password";
    self.emailTextfield.placeholder = @"  Email";
    self.reenterPasswordTextfield.placeholder = @"  Re-enter Password";

     self.registerButton.layer.cornerRadius = 8.0;
    self.usernameTextfield.layer.cornerRadius = 8.0;
    self.passwordTextfield.layer.cornerRadius = 8.0;
    self.emailTextfield.layer.cornerRadius = 8.0;
    self.reenterPasswordTextfield.layer.cornerRadius = 8.0;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (IBAction)registerButtonTapped:(id)sender {
    [self checkEmailFormat];
    [self.usernameTextfield resignFirstResponder];
    [self.emailTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    [self.reenterPasswordTextfield resignFirstResponder];


}

-(void)checkEmailFormat{
        if ([self.emailTextfield.text isEqualToString:@""])  {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Email is Wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else {
            [self checkFieldsComplete];
        }
}

-(void)checkFieldsComplete{
    if ([self.usernameTextfield.text isEqualToString:@""] || [self.emailTextfield.text isEqualToString:@""] || [self.passwordTextfield.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Message need to be completed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self checkPasswordMatch];
    }
}
-(void)checkPasswordMatch {
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

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)  {
        if (!error) {
            NSLog(@"Registration success!");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Complete" message:@"Registration success!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];

            [self performSegueWithIdentifier:@"registerSegue" sender:self];
        }
        else {
            NSLog(@"There was an error in registration");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"There was an error in registration" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}
@end
