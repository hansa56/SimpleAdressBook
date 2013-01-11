//
//  ContactManager.m
//  PlayStroryBoard
//
//  Created by Gao Kevin on 1/7/13.
//  Copyright (c) 2013 Gao Kevin. All rights reserved.
//

#import "ContactManager.h"

@implementation ContactManager

@synthesize plistPath;


-(id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

-(ContactManager *)initWithDataSource
{
    self = [super init];
    if (self) {
        self.plistPath = [[NSString alloc] init];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        self.plistPath = [documentsDirectory stringByAppendingPathComponent:@"Contacts.plist"];
        
        self.contacts = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    }
    return self;
}


-(void) saveData
{    
    [self.contacts writeToFile:self.plistPath atomically:YES];    
}


-(NSMutableArray *) getContactList
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (id obj in self.contacts) {
        NSDictionary *subObj= [[NSDictionary alloc] initWithDictionary:[self.contacts objectForKey:obj]];
        [list addObject:subObj];
    }
    return list;
}

-(void) createContact:(Contact *)person
{
    NSDictionary *contact = [[NSDictionary alloc] initWithObjectsAndKeys:person.personID,@"personID",person.name,@"name",person.phone,@"phone",person.email,@"email",person.photo,@"photo",person.photoURL,@"photoURL", nil];

    if (!self.contacts) {
        self.contacts = [[NSMutableDictionary alloc] init]; //when contact.plist is empty, the contacts is nil;
    }
    [self.contacts setObject:contact forKey:person.personID];

}

-(void) updataContact:(Contact *)person
{    
    if(person.personID){
        NSMutableDictionary *contact= [self.contacts objectForKey:person.personID];

        [contact setValue:person.name forKey:@"name"];
        [contact setValue:person.phone forKey:@"phone"];
        [contact setValue:person.email forKey:@"email"];
        [contact setValue:person.photo forKey:@"photo"];
        [contact setValue:person.photoURL forKey:@"photoURL"];
    }
}

- (void) dealloc
{
    [plistPath release];
    [super dealloc];
}

@end
