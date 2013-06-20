//
//  SearchViewController.h
//  OrderAssistant
//
//  Created by Li Feng on 13-6-5.
//
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchBarDelegate>{
   
    UISearchBar *searchBar;
    NSString *searchStr;
    
}

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) NSString *searchStr;

@end
