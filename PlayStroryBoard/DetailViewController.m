//
//  DetailViewController.m
//  PlayStroryBoard
//
//  Created by Gao Kevin on 1/5/13.
//  Copyright (c) 2013 Gao Kevin. All rights reserved.
//

#import "DetailViewController.h"

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

    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(reloadData)
                                                name:@"viewReload"//消息名
                                              object:nil];
    
    
    
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
    }
}

-(void) getContact:(NSDictionary *)data
{
    self.contact = [[NSDictionary alloc] initWithDictionary:data];
}

-(void) loadData
{
    NSString *key = [contact objectForKey:@"personID"];
    if (key) {
        ContactManager *cManager= [[ContactManager alloc] initWithDataSource];
        [cManager getData];
        //NSMutableArray * contactList = [cManager getContactList];
        contact = [cManager.tempDict objectForKey:key];
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
