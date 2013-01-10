//
//  CreateViewController.h
//  PlayStroryBoard
//
//  Created by Gao Kevin on 1/5/13.
//  Copyright (c) 2013 Gao Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "ContactManager.h"

@interface CreateViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    BOOL isEdit;
    UIImagePickerController* imgPickerCtrller;
    IBOutlet UIImageView* imgView;
    ContactManager *cManager;
}

@property (retain, nonatomic) IBOutlet UITextField *txtEmail;
@property (retain, nonatomic) IBOutlet UITextField *txtPhone;
@property (retain, nonatomic) IBOutlet UITextField *txtName;
@property (retain, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic,retain) UIImagePickerController* imgPickerCtrller;
@property (retain,nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (retain, nonatomic) Contact *contact;

-(IBAction)createContact:(id)sender;
-(IBAction)cancel:(id)sender;
- (IBAction)textFiledReturnEditing:(id)sender;

-(void) getContact: (NSDictionary *)data;

+(NSString *) GenerateID;
@end
