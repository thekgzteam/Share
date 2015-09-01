//
//  ExtraCodeViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/31/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "ExtraCodeViewController.h"

@interface ExtraCodeViewController ()

@end

@implementation ExtraCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Post" message:@"Share an Event" preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//    UIAlertAction* Save = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:ok];
//    [alertController addAction:Save];
//
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField *nameTextField) {
//        nameTextField.placeholder = @"Name";
//
//        //        [nameTextField set];
//
//    }];
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField *durationTextField) {
//        durationTextField.placeholder = @"Duration";
//
//    }];
//
//    [self presentViewController:alertController animated:YES completion:nil];






//// - Selecting a row and adding to your favorites
//-(void)tableView:(UITableView tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self likeComment:[self.posts objectAtIndex:indexPath.row]];
//}
//
//// Adding the selected row to
//-(void)likeComment:(PFObject *)object {
//    [object addUniqueObject:[PFUser currentUser].objectId forKey:@"comments"];
//
//    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            NSLog(@"selected row!");
//            [self likedSuccess];
//        }
//        else {
//            [self likedFail];
//        }
//    }];
//}
//
//-(void) likedSuccess {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"You have added the comment to your profile" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
//
//}
//
//-(void) likedFail {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error adding the comment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
@end
