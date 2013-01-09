//
//  ContactsViewController.h
//  PlayStroryBoard
//
//  Created by Gao Kevin on 1/5/13.
//  Copyright (c) 2013 Gao Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "ContactManager.h"
#import "DetailViewController.h"

@interface ContactsViewController : UITableViewController
{
    UIBarButtonItem *addButton;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;

@property(retain, atomic) NSMutableArray *contactList;

- (IBAction)addNewContact:(id)sender;

@end
