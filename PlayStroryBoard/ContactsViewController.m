//
//  ContactsViewController.m
//  PlayStroryBoard
//
//  Created by Gao Kevin on 1/5/13.
//  Copyright (c) 2013 Gao Kevin. All rights reserved.
//

#import "ContactsViewController.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"
@interface ContactsViewController ()

@end

@implementation ContactsViewController

@synthesize  contactList;

@synthesize addButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void) viewWillAppear:(BOOL)animated
{
    [self loadData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
	NSDictionary *contact = nil;
    if ([segue.identifier isEqualToString:@"SegueDetailView"]){	
        contact = [self.contactList objectAtIndex:indexPath.row];
        [segue.destinationViewController getContact:contact];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [contactList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * tableIdentifier=@"ContactCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if(cell==nil)
    {
        //当没有可复用的空闲的cell资源时(第一次载入,没翻页)
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        
    }
    NSUInteger row=[indexPath row];
    NSDictionary *contact = [contactList objectAtIndex:row];
    //cell.textLabel.text=[contact objectForKey:@"name"];//设置文字
    UIImage *image;//读取图片,无需扩展名
    

    if([[contact objectForKey:@"photo"] length]!=0){
        image = [UIImage imageWithContentsOfFile:[contact objectForKey:@"photoURL"]];
    }else{
        image = [UIImage imageNamed:@"Avatar1"];
    }
   
    UIImageView *photoImageView = (UIImageView *)[cell viewWithTag:1];
    UILabel *name = (UILabel *)[cell viewWithTag:2];
    UILabel *phone = (UILabel *)[cell viewWithTag:3];
    UILabel *email = (UILabel *)[cell viewWithTag:4];
    UILabel *phoneIconLabel = (UILabel *)[cell viewWithTag:5];
    UILabel *emailIconLabel = (UILabel *)[cell viewWithTag:6];
    
    phoneIconLabel.font = [UIFont fontAwesomeOfSize:12];
    phoneIconLabel.text = FontAwesomeIconPhone;
    emailIconLabel.font = [UIFont fontAwesomeOfSize:12];
    emailIconLabel.text = FontAwesomeIconEnvelope;

    photoImageView.image = image;
    name.text = [contact objectForKey:@"name"];
    phone.text = [contact objectForKey:@"phone"];
    email.text = [contact objectForKey:@"email"];
    
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(!indexPath)
        return;
    [self loadData];
    NSUInteger row = [indexPath row];
    NSDictionary *detail = [[NSDictionary alloc]initWithDictionary:[contactList objectAtIndex:row]];
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    DetailViewController* detailViewController = (DetailViewController *)[sb instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    [detailViewController getContact:detail];
    
    NSLog(@"contact is %@", detail);
    //[self.view addSubview:detailViewController.view];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"viewReload" object:self];
    
    //[self.navigationController pushViewController:detailViewController animated:YES];
    //[detailViewController release];
    // Navigation logic may go here. Create and push another view controller.
    /*
         
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (IBAction)addNewContact:(id)sender
{
   
}

-(void) loadData
{
    ContactManager *cManager = [[ContactManager alloc] initWithDataSource];
    [cManager connectDataSource];
    contactList = [cManager getContactList];
    
}

-(void) dealloc
{
    [contactList release];
    [addButton release];
    [super dealloc];
}

@end
