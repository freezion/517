//
//  OtherViewController.m
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-3-27.
//
//

#import "OtherViewController.h"
#define CELLHEIGHT 44.0
#define UILABELWIDTH 166.0
#define X_FLOAT 114.0
#define Y_FLOAT 12.0

@interface OtherViewController ()

@end

@implementation OtherViewController
@synthesize resEntity;

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
    UIFont *font = [UIFont systemFontOfSize:16];
    CGSize size = CGSizeMake(UILABELWIDTH, 2000);
    
    NameLabel.text = resEntity.resNameTxt;
    NameLabel.textAlignment = UITextAlignmentLeft;
    NameLabel.numberOfLines = 0;
    NameLabel.lineBreakMode = UILineBreakModeWordWrap;
    CGSize NameLabelSize = [NameLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    NSLog(@"NameLabelSize.height = %f",NameLabelSize.height);
    [NameLabel setFrame:CGRectMake(X_FLOAT, Y_FLOAT, UILABELWIDTH,NameLabelSize.height)];
    
    OpenTimeLabel.text = resEntity.workTime;
    OpenTimeLabel.textAlignment = UITextAlignmentLeft;
    OpenTimeLabel.numberOfLines = 0;
    OpenTimeLabel.lineBreakMode = UILineBreakModeWordWrap;
    CGSize OpenTimeSize = [OpenTimeLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [OpenTimeLabel setFrame:CGRectMake(X_FLOAT, Y_FLOAT, OpenTimeSize.width,OpenTimeSize.height)];
    
    
    AddressLabel.text = resEntity.ResAddressTxt;
    AddressLabel.textAlignment = UITextAlignmentLeft;
    CGSize AddressLabelSize = [AddressLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [AddressLabel setFrame:CGRectMake(114, Y_FLOAT, UILABELWIDTH,AddressLabelSize.height)];
    AddressLabel.lineBreakMode = UILineBreakModeWordWrap;
    AddressLabel.numberOfLines = 0;
    NSLog(@"AddressLabelSize.height = %f",AddressLabelSize.height);
    
    TransportLabel.text = resEntity.resBusRoute;
//    DiningPurposeLabel.text = resEntity;
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//    
//     */
//
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0)
    {
        return NameLabel.frame.size.height + 24;
    }
    else if (indexPath.row == 1)
    {
       // return OpenTimeLabel.frame.size.height;
        return CELLHEIGHT;
    }
    else if (indexPath.row == 2)
    {
     //   return SpecialServiceLabel.frame.size.height;
        return CELLHEIGHT;
    }
    else if (indexPath.row == 3)
    {
        return AddressLabel.frame.size.height+24;
    }
    else
    {
        return CELLHEIGHT;
    }

}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    CGFloat contentWidth = cell.textLabel.frame.size.width;
//    UIFont *font = [UIFont systemFontOfSize:17];
//    NSString *content = cell.textLabel.text;
//    CGSize size = [content sizeWithFont:font constrainedToSize:(contentWidth,1000) lineBreakMode:UILineBreakModeCharacterWrap];
//   return size.height;
//    
//}

- (void)viewDidUnload {
    NameLabel = nil;
    OpenTimeLabel = nil;
    OpenTimeLabel = nil;
    SpecialServiceLabel = nil;
    AddressLabel = nil;
    TransportLabel = nil;
    DiningPurposeLabel = nil;
    [super viewDidUnload];
}
@end
