//
//  CreateViewController.m
//  PlayStroryBoard
//
//  Created by Gao Kevin on 1/5/13.
//  Copyright (c) 2013 Gao Kevin. All rights reserved.
//

#import "CreateViewController.h"

#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"

@interface CreateViewController ()

@end

@implementation CreateViewController

@synthesize txtEmail;
@synthesize txtName;
@synthesize txtPhone;
@synthesize contact;
@synthesize imgView;
@synthesize imgPickerCtrller;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Edit Contact";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
       
    txtEmail.delegate = self;//设置委托
    txtName.delegate = self;
    txtPhone.delegate = self;
    
    imgPickerCtrller = [[UIImagePickerController alloc] init];
    imgPickerCtrller.delegate = self;
    if(!contact)
        contact = [[Contact alloc] init];

    self->cManager = [[ContactManager alloc] initWithDataSource];
    [self->cManager connectDataSource];
    
    self->isEdit = false;
    
    UIImage *image;
    if(contact.personID) {
        [txtEmail setText:contact.email];
        [txtName setText:contact.name];
        [txtPhone setText:contact.phone];
        if([contact.photoURL length]!=0){
            image = [UIImage imageWithContentsOfFile:contact.photoURL];
        }else{
            image = [UIImage imageNamed:@"Avatar1"];
        }
        [imgView setImage:image];
        self->isEdit = true;
    }
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated
{
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}


-(IBAction)createContact:(id)sender
{
    
    contact.name = txtName.text;
    contact.phone = txtPhone.text;
    contact.email = txtEmail.text;
    if (!contact.personID) {
       
        contact.personID = [CreateViewController GenerateID];
        if (!contact.photo) {
            contact.photo = @"";
            contact.photoURL = @"";
        }
    }
    
    if (contact.name.length>0) {
        if (!self->isEdit) {
            //[self->cManager setDataWithName:name andPhone:phone andEmail:email];
            [self->cManager createContact:contact];
            [self->cManager saveData];
        }else{
            //[self->cManager updateDataWithID:key andName:name andPhone:phone andEmail:email];
            [self->cManager updataContact:contact];
            [self->cManager saveData];
        }
        
        
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"Dismiss completed");
            
        
        }];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"saveSetting" object:self];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name is empty" message:@"Enter the name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

-(void) cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"Dismiss completed");}];
}

-(void) getContact: (NSDictionary *)data
{
    if(!contact)
        contact = [[Contact alloc] init];
    self.contact.personID = [data objectForKey:@"personID"];
    self.contact.name= [data objectForKey:@"name"];
    self.contact.phone= [data objectForKey:@"phone"];
    self.contact.email= [data objectForKey:@"email"];
    self.contact.photo= [data objectForKey:@"photo"];
    self.contact.photoURL= [data objectForKey:@"photoURL"];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint coord = [touch locationInView:self.view];
    
    //if touches within image, access photo library
    if (CGRectContainsPoint(imgView.frame, coord)) {
        [self presentViewController:self.imgPickerCtrller animated:YES completion:^{
            NSLog(@"");
        }];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
    //imageView.image = img;
    [imgView setImage:img];    
    [picker dismissModalViewControllerAnimated:YES];
    NSData *data = [[NSData alloc]init];
    if (UIImagePNGRepresentation(img) == nil) {
        
        data = UIImageJPEGRepresentation(img, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(img);
        
    }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //plistPath = [documentsDirectory stringByAppendingPathComponent:@"Contacts.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableString *imageName;
    if (!contact.personID) {
        contact.personID = [CreateViewController GenerateID];
    }
    imageName =[NSMutableString stringWithString:contact.personID];
    [imageName appendString:@".jpg"];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    //[fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    NSLog(@"%@", filePath);
    
    [fileManager createFileAtPath:filePath contents:data attributes:nil];

    contact.photo = imageName;
    contact.photoURL = filePath;
}

+(NSString *) GenerateID
{
    NSString *key;
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    key = [dateFormatter stringFromDate:now];
    NSLog(@"personID is %@",key);
    return key;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = self.view.frame;    
    frame.origin.y -=120;
    self.view.frame = frame;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    CGRect frame = self.view.frame;
    frame.origin.y +=120;
    self.view.frame = frame;
    return YES;
}
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{    
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{    
    self.navigationController.navigationBar.frame = CGRectMake(0,0,320,44);
    [textField resignFirstResponder];    
    return YES;
}

- (BOOL)endEditing:(BOOL)force
{
    CGRect frame = self.view.frame;
    frame.origin.y +=120;
    self.view.frame = frame;
    return YES;

}

- (void)dealloc {
    [txtName release];
    [txtPhone release];
    [txtEmail release];
    [imgPickerCtrller release];
    [super dealloc];
}

@end
