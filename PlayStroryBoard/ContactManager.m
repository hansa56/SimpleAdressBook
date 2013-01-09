//
//  ContactManager.m
//  PlayStroryBoard
//
//  Created by Gao Kevin on 1/7/13.
//  Copyright (c) 2013 Gao Kevin. All rights reserved.
//

#import "ContactManager.h"

@implementation ContactManager

@synthesize contactsData;
@synthesize dataList;
@synthesize plistPath;
@synthesize tempDict;

-(ContactManager *)initWithDataSource
{
    [self setDataSource];
    return self;
    
}

-(void) setDataSource
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    plistPath = [documentsDirectory stringByAppendingPathComponent:@"Contacts.plist"];
    
    NSLog(@"derectory is %@",plistPath);
    
    
}

-(void) getData
{
    // NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
    tempDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    dataList = [[NSMutableArray alloc] init];
    
    for (id obj in tempDict) {
        NSDictionary *subObj= [[NSDictionary alloc] initWithDictionary:[tempDict objectForKey:obj]];
        [dataList addObject:subObj];
    }
    
    NSLog(@"datalist is %@", dataList);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (id obj in dataList) {
        [array addObject:[obj objectForKey:@"name"]];
        
    }
    
    contactsData = [NSArray arrayWithArray:array];
    [array release];
    NSLog(@"contactsData is %@", contactsData);
}


-(void) saveData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    plistPath = [documentsDirectory stringByAppendingPathComponent:@"Contacts.plist"];
    
    
    [self.Data writeToFile:plistPath atomically:YES];
    
}


-(void) connectDataSource
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    plistPath = [documentsDirectory stringByAppendingPathComponent:@"Contacts.plist"];
    self.Data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSLog(@"derectory is %@",plistPath);
    NSLog(@"Contacts is %@",self.Data);
}

-(NSMutableArray *) getContactList
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (id obj in self.Data) {
        NSDictionary *subObj= [[NSDictionary alloc] initWithDictionary:[self.Data objectForKey:obj]];
        [list addObject:subObj];
    }
    
    NSLog(@"datalist is %@", list);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (id obj in list) {
        [array addObject:[obj objectForKey:@"name"]];
        
    }
    
    //contactsData = [NSArray arrayWithArray:array];
    [array release];
    //NSLog(@"contactsData is %@", contactsData);
    return list;
}

-(void) createContact:(Contact *)person
{
    NSDictionary *contact = [[NSDictionary alloc] initWithObjectsAndKeys:person.personID,@"personID",person.name,@"name",person.phone,@"phone",person.email,@"email",person.photo,@"photo",person.photoURL,@"photoURL", nil];
    //[dataList addObject:contact];
    [self.Data setObject:contact forKey:person.personID];
    
    NSLog(@"Contacts is %@",self.Data);
}

-(void) updataContact:(Contact *)person
{
    if (!self.Data) {
        self.Data = [NSMutableDictionary dictionary];
    }
    
    if(person.personID){
        NSMutableDictionary *contact= [self.Data objectForKey:person.personID];
        NSLog(@"%@", contact);
        //[contact setValue:person. forKey:(NSString *)]
        [contact setValue:person.name forKey:@"name"];
        [contact setValue:person.phone forKey:@"phone"];
        [contact setValue:person.email forKey:@"email"];
        [contact setValue:person.photo forKey:@"photo"];
        [contact setValue:person.photoURL forKey:@"photoURL"];
        
        NSLog(@"Contacts is %@",self.Data);
    }
}

@end
