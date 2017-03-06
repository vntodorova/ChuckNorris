//
//  ViewController.h
//  ChuckNorris
//
//  Created by Veneta on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)getResults:(UIButton *)sender;
- (IBAction)chooseCategory:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *textField;
@property(nonatomic , strong) NSString *chosenCategory;
@property(nonatomic , strong) NSString *searchString;
@end

