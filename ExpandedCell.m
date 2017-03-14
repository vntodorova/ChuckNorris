//
//  ExpandedCell.m
//  ChuckNorris
//
//  Created by VCS on 3/13/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "ExpandedCell.h"
#import "CNJoke.h"

@implementation ExpandedCell

- (IBAction)onSMSClick:(id)sender {
}

- (IBAction)onEmailClick:(id)sender {
}

- (IBAction)onDeleteClick:(id)sender {
}

- (IBAction)onHideClick:(id)sender {
}

-(void)setupCellWithJoke:(CNJoke*)joke
{
    self.jokeTextField.text = joke.getJoke;
    self.layer.cornerRadius = 5;
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2.0f);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 1.0f;
    self.layer.masksToBounds = NO;
}
@end
