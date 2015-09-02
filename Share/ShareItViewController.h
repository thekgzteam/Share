//
//  ShareItViewController.h
//  
//
//  Created by Edil Ashimov on 8/24/15.
//
//

#import <UIKit/UIKit.h>

@interface ShareItViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property NSString *postCategory;
@property MKPointAnnotation *postAnnotation;
@property MKPointAnnotation *selectedAnnotation;
@property MKPinAnnotationView *pinAnnotationView;

- (IBAction)ChooseExisting;

@end
