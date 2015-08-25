//
//  ShareItViewController.m
//  
//
//  Created by Edil Ashimov on 8/24/15.
//
//

#import "ShareItViewController.h"

@interface ShareItViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextfield;


@property UIImagePickerController *picker;
@property UIImagePickerController *picker2;
@property IBOutlet UIImageView *imageView;
@property UIImage *image;
@property (weak, nonatomic) IBOutlet UIButton *libraryButton;

@end

@implementation ShareItViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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

@end
