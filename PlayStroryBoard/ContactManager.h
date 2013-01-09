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
    NSArray *contactsData;
    NSMutableArray *dataList;
    NSMutableDictionary *tempDict;
}

@property (strong, nonatomic) NSMutableArray *contactList;
@property (strong, nonatomic) NSMutableDictionary *contactIndexDict;
@property (strong, nonatomic) NSArray *sortedIndexList;

@property(retain,atomic) NSArray *contactsData;
@property(retain,atomic) NSMutableArray *dataList;
@property(retain,atomic) NSString *plistPath;
@property(retain,atomic) NSMutableDictionary *tempDict;

@property(retain, atomic) NSMutableDictionary *Data;

-(ContactManager *) initWithDataSource;
-(void) setDataSource;
-(void) getData;
-(void) saveData;

-(NSMutableArray *) getContactList;
-(void) connectDataSource;
-(void) updataContact:(Contact *)contact;
-(void) createContact: (Contact *) contact;

@end