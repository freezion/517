//
//  SearchViewController.m
//  OrderAssistant
//
//  Created by Li Feng on 13-6-5.
//
//

#import "SearchViewController.h"

@implementation SearchViewController
@synthesize searchBar;
@synthesize searchStr;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //改变SearchBar的默认yanse
    UIView *segment=[searchBar.subviews objectAtIndex:0];
    [segment removeFromSuperview];
    searchBar.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    searchBar.delegate=self;
   
    UIImage *buttonImage = [[UIImage imageNamed:@"trip_bar_right"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    UIButton *backBtn=[[UIButton alloc] init];
    [backBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    CGRect buttonFrame1 = [backBtn frame];
    buttonFrame1.size.width = buttonImage.size.width;
    buttonFrame1.size.height = buttonImage.size.height;
    [backBtn setFrame:buttonFrame1];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    backBtn.titleLabel.font=[UIFont fontWithName:@"Kailasa" size:13];
    [backBtn addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:backBarButton];
    
    self.navigationItem.title=@"搜索";
    
}

- (void)turnBack{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UISearchBarDelegate Methods
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    [self.searchBar setShowsCancelButton:YES animated:YES];
    
    
    
    return YES;
}

//UiSearchBar里面text内容改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

//点击UISearchBar时
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    
    [self.searchBar setShowsCancelButton:YES animated:YES];
    //修改取消按钮字体
    for(id cc in [self.searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *sbtn = (UIButton *)cc;
            [sbtn setTitle:@"取消" forState:UIControlStateNormal];
            [sbtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
            //[sbtn setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.searchBar.text=@"";
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    
}

//输入完毕  点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    searchStr=self.searchBar.text;
    NSLog(@"%@",searchStr);
    [self dismissModalViewControllerAnimated:YES];
    
//    resentities= [WebServices getShopsBySDName:self.searchBar.text];
//    NSLog(@"%d",[resentities count]);
//    //
//    [self.searchBar resignFirstResponder];
//    [self.searchBar setShowsCancelButton:NO animated:YES];
//    
//    //
//    //    [self.tableData removeAllObjects];
//    //    [self.tableData addObjectsFromArray:results];
//    [self.tableviewCustom reloadData];
}

@end
