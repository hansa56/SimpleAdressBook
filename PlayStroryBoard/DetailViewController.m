//
//  DetailViewController.m
//  PlayStroryBoard
//
//  Created by Gao Kevin on 1/5/13.
//  Copyright (c) 2013 Gao Kevin. All rights reserved.
//

#import "DetailViewController.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize contact;
@synthesize name;
@synthesize phone;
@synthesize email;
@synthesize imgView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self->isEdited = false;
    
    UILabel *phoneIconLabel = (UILabel *)[self.view viewWithTag:11];
    UILabel *emailIconLabel = (UILabel *)[self.view viewWithTag:12];
    phoneIconLabel.font = [UIFont fontAwesomeOfSize:17];
    phoneIconLabel.text = FontAwesomeIconPhone;
    emailIconLabel.font = [UIFont fontAwesomeOfSize:17];
    emailIconLabel.text = FontAwesomeIconEnvelope;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self loadData];
}

- (void) viewDidDisappear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SegueContactEdit"]){
        [segue.destinationViewController setTitle:@"Edit Contact"];
        [segue.destinationViewController getContact:contact];
        self->isEdited  = (bool *)true;
    }
}

-(void) getContact:(NSDictionary *)data
{
   // if (!contact) {
    //
    //}
    self.contact = [[NSDictionary alloc] initWithDictionary:data];
}

-(void) loadData
{    
    if (self->isEdited) {
        NSString *key = [contact objectForKey:@"personID"];
        ContactManager *cManager= [[ContactManager alloc] initWithDataSource];
        NSMutableArray * contactList = [cManager getContactList];
        for (id dict in contactList) {
            if ([[dict objectForKey:@"personID"] isEqualToString:key]) {
                contact = dict;
                break;
            }
        }  
    }
    
    name.text = [contact objectForKey:@"name"];
    phone.text = [contact objectForKey:@"phone"];
    email.text = [contact objectForKey:@"email"];
    
    UIImage *image;
    if([[contact objectForKey:@"photo"] length]!=0){
        image = [UIImage imageWithContentsOfFile:[contact objectForKey:@"photoURL"]];
    }else{
        image = [UIImage imageNamed:@"Avatar1"];
    }    
    [imgView setImage: image];
}

-(void) resetUI
{
    
}

-(void) reloadData
{
    [self loadData];
}
- (void)dealloc {
    [name release];
    [phone release];
    [email release];
    [super dealloc];
}

@end
