//
//  ViewController.h
//  ChuckNorris
//
//  Created by Veneta on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic , strong) NSArray *allCategories;

- (NSArray*)retrieveCategories;
- (IBAction)chooseCategoryButtonClicked:(UIButton *)sender;

@end

