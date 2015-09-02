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
#import "ProfileSettingsViewController.h"


@interface ProfileViewController ()
<UITextFieldDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *VisualParseImage;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dockHeight;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *visaulEffect;
@property (weak, nonatomic) IBOutlet UIView *dockView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *messageTextfield;
@property UIPopoverController *popOver;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;


@end


@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveMessageFromParse];
    [self retrieveFavoriteImages];
    [self queryImageParseMethod];
    // controller set selected index 0/1
    [self.segmentedControl setSelectedSegmentIndex:1];


    self.profileImage.layer.borderWidth = 4.0f;
    self.profileImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImage.layer.cornerRadius = 10.0f;
    self.profileImage.clipsToBounds = YES;



    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(visualEffectTapped:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.visaulEffect addGestureRecognizer:tapRecognizer];

    [NSTimer scheduledTimerWithTimeInterval:5.0f
                                     target:self selector:@selector(retrieveRecentMessagesFromParse) userInfo:nil repeats:YES];
}
#pragma mark - User Interaction

- (void)visualEffectTapped:(UITapGestureRecognizer *)recognizer {
    [self.messageTextfield endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.sendButton.enabled = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.dockHeight.constant = 280;
    }
                     completion:^(BOOL finished) {
                         NSLog(@"done");
                     }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.5 animations:^{
        self.dockHeight.constant = 54;
    }
                     completion:^(BOOL finished) {
                         NSLog(@"done");
                     }];
}

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
#pragma mark - Parse Methods

- (void) retrieveRecentMessagesFromParse {
    PFQuery *retrieveDescription = [PFQuery queryWithClassName:@"Message"];
    [retrieveDescription orderByDescending:@"createdAt"];
    [retrieveDescription findObjectsInBackgroundWithBlock:^(NSArray *retrievedMessages, NSError *error) {

        if (!error) {
            NSLog(@"Message objects found: %lu", (unsigned long)retrievedMessages.count);
            self.messageArray = retrievedMessages.mutableCopy;
            [self.messageTableView reloadData];
        } else {
            NSLog(@"Error getting data: %@", error);

        }
        [self.messageTableView reloadData];
    }];
}

- (void)queryParseMethod {
    NSLog (@"start query");
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
        }
        NSLog(@"Qeury is over");
    }];
}

// Getting Only Favorited Image From "favorites"
- (void) retrieveFavoriteImages {
    PFQuery *getFavorites = [PFQuery queryWithClassName:@"Post"];
    [getFavorites whereKey:@"favorites" equalTo:[PFUser currentUser].objectId];

    [getFavorites findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
        }
        [self.collectionOfImages reloadData];
    }];
}
// Getting  Messages
- (void) retrieveMessageFromParse {
    PFQuery *retrieveDescription = [PFQuery queryWithClassName:@"Message"];
    [retrieveDescription orderByDescending:@"createdAt"];
    [retrieveDescription findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"Message object found: %lu", (unsigned long)objects.count);
        if (!error) {
            for (PFObject *Message in objects) {
                [self.messageArray addObject:Message];
                NSLog(@"Successfully loaded %lu messages.", (unsigned long)self.messageArray.count);
            }
        } else {
            NSLog(@"Error getting data: %@", error);

        }
        [self.messageTableView reloadData];
    }];
}
#pragma mark - collection View Methods

-(NSInteger)numberOfSectionsInTableView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView: (UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageFilesArray.count;
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

#pragma mark TableView Methods

-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

-(ProfileTableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Loading tableview.");
    ProfileTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"messageid"];

    PFObject *post = [self.messageArray objectAtIndex:indexPath.row];
    NSString *text = [post objectForKey:@"messageText"];
    NSString *username = [post objectForKey:@"username"];
    NSDate *time = [post objectForKey:@"createdAt"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *dateString = [dateFormatter stringFromDate:time];
    NSLog(@"Post: %@", post );

    if ([text isEqual:@""]) {
        text = @"No message.";
    }

    cell.messageTextView.text = text;
    cell.usernameLabel.text = username;
    cell.timeLabel.text = dateString;

    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 8.0;
    cell.imageView.frame = CGRectMake(0, 50, 50, 50);
        return cell;
   }
#pragma mark - Seque's

-(void) prepareForSegue: (UIStoryboardSegue * ) segue sender: (id) sender {
    // Assuming you've hooked this all up in a Storyboard with a popover presentation style
    if ([segue.identifier isEqualToString: @"settings"]) {
        ProfileSettingsViewController * destNav = segue.destinationViewController;

        // This is the important part
        UIPopoverPresentationController * popPC = destNav.popoverPresentationController;
        popPC.delegate = self;
    }
}
- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController * ) controller {
    return UIModalPresentationNone;
}

- (void)queryImageParseMethod {

    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"Results from user query: %lu", (unsigned long)objects.count);
        PFUser *postUser = objects.firstObject;
        PFFile *userImage = [postUser objectForKey:@"ProfilePic"];
        [userImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error)  {
            NSLog(@"Getting data for user image.");
            if (!error) {

                NSLog(@"No error! Retrieved profile image: %p", data);
                UIImage *profilePicture = [UIImage imageWithData:data];
                self.profileImage.image = profilePicture;
                self.VisualParseImage.image = profilePicture;
                self.profileName.text = [postUser objectForKey:@"username"];
            } else {
                NSLog(@"There was an error retrieving the image: %@", error.localizedDescription);
            }
        }];
    }];
    NSLog(@"Post username is nil!");
}

@end
