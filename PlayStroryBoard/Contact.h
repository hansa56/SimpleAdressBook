//
//  Contact.h
//  PlayStroryBoard
//
//  Created by Gao Kevin on 1/5/13.
//  Copyright (c) 2013 Gao Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, retain) NSString * personID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSString * photoURL;

-(id)init;
@end
