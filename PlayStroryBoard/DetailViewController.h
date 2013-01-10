//
//  DetailViewController.h
//  PlayStroryBoard
//
//  Created by Gao Kevin on 1/5/13.
//  Copyright (c) 2013 Gao Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateViewController.h"
#import "Contact.h"
#import "ContactManager.h"

@interface DetailViewController : UIViewController
{
    NSDictionary *contact;
    bool *isEdited;
}
@property(retain, nonatomic) NSDictionary *contact;

@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *phone;
@property (retain, nonatomic) IBOutlet UILabel *email;

@property (retain, nonatomic) IBOutlet UIImageView *imgView;

-(void) getContact:(NSDictionary *) data;
-(void) loadData;

@end
