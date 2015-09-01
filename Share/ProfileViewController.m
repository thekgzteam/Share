//
//  ProfileViewController.m
//  Share
//
//  Created by Edil Ashimov on 8/19/15.
//  Copyright (c) 2015 Edil Ashimov. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionViewCell.h"
#import "ProfileTableViewCell.h"
#import "VisualEffectCollectionViewCell.h"


@interface ProfileViewController ()
<UITextFieldDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *VisualParseImage;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dockHeight;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *visaulEffect;
@property (weak, nonatomic) IBOutlet UIView *dockView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *messageTextfield;

@end


@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self queryParseMethod];
    [self retrieveMessageFromParse];
    [self retrieveFavoriteImages];


    self.profileImage.layer.borderWidth = 4.0f;
    self.profileImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImage.layer.cornerRadius = 10.0f;
    self.profileImage.clipsToBounds = YES;


    self.profileImage.image = [UIImage imageNamed:@"profileImage"];
    self.VisualParseImage.image = [UIImage imageNamed:@"profileImage"];

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(visualEffectTapped:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.visaulEffect addGestureRecognizer:tapRecognizer];

    self.messageArray = [NSMutableArray new];

    NSArray *array1 = [NSArray arrayWithObjects:@"a", @"b", @"c", nil];

    NSArray *array2 = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];

    array1 = array2;


    [NSTimer scheduledTimerWithTimeInterval:5.0f
                                 target:self selector:@selector(retrieveRecentMessagesFromParse) userInfo:nil repeats:YES];
//
}
//
-(void) retrieveRecentMessagesFromParse {
    PFQuery *retrieveDescription = [PFQuery queryWithClassName:@"Message"];
    [retrieveDescription orderByDescending:@"createdAt"];
//    NSDate *then = [NSDate dateWithTimeIntervalSinceNow:-1200];
//    [retrieveDescription whereKey:@"updatedAt" greaterThanOrEqualTo:then];
    [retrieveDescription findObjectsInBackgroundWithBlock:^(NSArray *retrievedMessages, NSError *error) {

        if (!error) {
            NSLog(@"Message objects found: %lu", (unsigned long)retrievedMessages.count);
            self.messageArray = retrievedMessages.mutableCopy;
            [self.messageTableView reloadData];

//            for (PFObject *Message in objects) {
//                // you are always adding to an existing array!!
//                // reset the arra first
//
//
//                NSLog(@"Successfully loaded %lu messages.", (unsigned long)self.messageArray.count);
//
//            }
        } else {
            NSLog(@"Error getting data: %@", error);

        }
        [self.messageTableView reloadData];
    }];


}


// Query Method
-(void)queryParseMethod {
    NSLog (@"start query");
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
        }
// [self.collectionOfImages reloadData];
        NSLog(@"Qeury is over");
    }];

}


-(void)visualEffectTapped:(UITapGestureRecognizer *)recognizer {

    [self.messageTextfield endEditing:YES];
    NSLog(@"it is being tapped");
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
     self.sendButton.enabled = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.dockHeight.constant = 280;
        self.tableViewHeight.constant = 500;
    }
                     completion:^(BOOL finished) {
                         NSLog(@"done");
                     }];

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.5 animations:^{
        self.dockHeight.constant = 54;
        self.tableViewHeight.constant = 187;
    }
                     completion:^(BOOL finished) {
                         NSLog(@"done");
                     }];
}


//Collection View Method
-(NSInteger)numberOfSectionsInTableView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView: (UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //        if(collectionView == self.collectionOfImages){
    return imageFilesArray.count;
    //            } else if (collectionView == self.ProfileVisualImage){
    //                return [imageFilesArray count];
    //            }
    ////            return 0;
}


-(UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellidentifier = @"cellid";
    ProfileCollectionViewCell *cell = (ProfileCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellidentifier forIndexPath:indexPath];

    PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
    PFFile *imageFile = [imageObject objectForKey:@"image"];

    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.parseImageHolder.image = [UIImage imageWithData:data];
            cell.parseImageText.text = [imageObject objectForKey:@"text"];
            cell.descriptionLabel.text = [imageObject objectForKey:@"description"];

        }
    }];

    return cell;
}

// Getting Only Favorited Image From "favorites"
-(void) retrieveFavoriteImages {
    PFQuery *getFavorites = [PFQuery queryWithClassName:@"Post"];
    [getFavorites whereKey:@"favorites" equalTo:[PFUser currentUser].objectId];

    [getFavorites findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
        }
        [self.collectionOfImages reloadData];
    }];
}

//Segmented Control
- (IBAction)segmentedControlChanged:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.collectionOfImages.hidden = YES;
            self.messageTableView.hidden = NO;
            self.dockView.hidden = NO;
            break;
        case 1:
            self.collectionOfImages.hidden = NO;
            self.messageTableView.hidden = YES;
            self.dockView.hidden = YES;
            break;
            
    }
}

//Message Send Button Saving Method
- (IBAction)onSendMessageTapped:(id)sender {

    PFObject *textMessage = [PFObject objectWithClassName:@"Message"];
    textMessage[@"messageText"] = self.messageTextfield.text;
    textMessage[@"username"] = [PFUser currentUser].username;
        self.dockHeight.constant = 54;
    [self.messageTextfield endEditing:YES];
    self.sendButton.enabled = NO;

    [textMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"The Message Has Been Saved");

            self.messageTextfield.text = 0;
            [self retrieveMessageFromParse];
            [self.messageArray removeAllObjects];

        } else {
            NSLog(@"Error Saving the Message");        }
    }];

}

// Getting a Data From Parse

-(void) retrieveMessageFromParse {
    PFQuery *retrieveDescription = [PFQuery queryWithClassName:@"Message"];
    [retrieveDescription orderByDescending:@"createdAt"];
    [retrieveDescription findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"Message object found: %lu", (unsigned long)objects.count);
        if (!error) {
            for (PFObject *Message in objects) {
                // you are always adding to an existing array!!
                // reset the arra first

                [self.messageArray addObject:Message];
                NSLog(@"Successfully loaded %lu messages.", (unsigned long)self.messageArray.count);

            }
        } else {
            NSLog(@"Error getting data: %@", error);

        }
            [self.messageTableView reloadData];
    }];

}
//Table View Methods

-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

-(ProfileTableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Loading tableview.");
    ProfileTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"messageid"];
  
    PFObject *post = [self.messageArray objectAtIndex:indexPath.row];
//    PFFile *imageFile = [post objectForKey:@"image"];
    NSString *text = [post objectForKey:@"messageText"];
    NSString *username = [post objectForKey:@"username"];
    NSDate *time = [post objectForKey:@"createdAt"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *dateString = [dateFormatter stringFromDate:time];
    NSLog(@"Post: %@", post );

//    NSInteger myInt = [time integerValue];

    if ([text isEqual:@""]) {
        text = @"No message.";


    }

    cell.messageTextView.text = text;
    cell.usernameLabel.text = username;
    cell.timeLabel.text = dateString;

    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 8.0;
    cell.imageView.frame = CGRectMake(0, 50, 50, 50);
//
//    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        if (!error) {
//            cell.imageView.image = [UIImage imageWithData:data];
//            [cell setNeedsLayout];
//            NSLog (@"Got image.");
//
//        } else {
//            NSLog(@"Error grabbing picutre.");
//        }
//
//        
//    }];

    return cell;
}


@end
