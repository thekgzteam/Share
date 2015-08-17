//
//  RegistrationViewController.m
//  
//
//  Created by Edil Ashimov on 8/17/15.
//
//

#import "RegistrationViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface RegistrationViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = CGPointMake(160.0, 380.0);
    [self.view addSubview:loginButton];
    
//
//
//        self.usernameTextfield.text = @"PlaceholderText";
//        self.usernameTextfield.delegate = self;
//        self.usernameTextfield.textColor = [UIColor darkGrayColor];

}
@end
