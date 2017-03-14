//
//  ExpandedCell.h
//  ChuckNorris
//
//  Created by VCS on 3/13/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandedCell : UICollectionViewCell
- (IBAction)onSMSClick:(id)sender;
- (IBAction)onEmailClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *jokeTextField;

@end
