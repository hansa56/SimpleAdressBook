//
//  ContactManager.h
//  PlayStroryBoard
//
//  Created by Gao Kevin on 1/7/13.
//  Copyright (c) 2013 Gao Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface ContactManager : NSObject
{
    NSString * plistPath;
}

@property(retain,atomic) NSString *plistPath;


@property(retain, atomic) NSMutableDictionary *contacts;

-(ContactManager *) initWithDataSource;
-(void) saveData;

-(NSMutableArray *) getContactList;
-(void) updataContact:(Contact *)contact;
-(void) createContact: (Contact *) contact;

@end
