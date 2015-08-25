//
//  RegistrationViewController.m
//  
//
//  Created by Edil Ashimov on 8/17/15.
//
//

#import "LogInViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse/Parse.h>
#import "CategoriesViewController.h"
@interface LogInViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.usernameTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    self.usernameTextfield.placeholder = @"Username";
    self.passwordTextfield.placeholder = @"Password";

    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = CGPointMake(190, 390.0);
    [self.view addSubview:loginButton];

//    CategoriesViewController*vc1 = [[CategoriesViewController alloc] initWithNibName:@"Catergories View Controller" bundle:nil];
//    [vc1 setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//    [self presentViewController:vc1 animated:YES completion:nil];

    PFUser *user = [PFUser user];
    user.username = self.usernameTextfield.text;
    user.password = self.passwordTextfield.text;
    user.email = @"email@example.com";




}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    PFUser *user = [PFUser currentUser];
    if (user.username !=nil) {
        [self performSegueWithIdentifier:@"signin" sender:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

        UITouch *touch = [[event allTouches] anyObject];
        if ([self.usernameTextfield isFirstResponder] && [touch view] != self.usernameTextfield)
            [self.usernameTextfield resignFirstResponder];
            ([self.passwordTextfield isFirstResponder] && [touch view] != self.passwordTextfield); {
                [self.passwordTextfield resignFirstResponder];
        }
        [super touchesBegan:touches withEvent:event];
        }



- (IBAction)loginButton:(id)sender {
    [PFUser logInWithUsernameInBackground:self.usernameTextfield.text password:self.passwordTextfield.text block:^(PFUser *user, NSError *error){
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed To Login!" message:@"Sorry we had a problem logging you in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else {
            [self performSegueWithIdentifier:@"signin" sender:self];
            NSLog(@"Login user!");
        }
    }];

}


@end
