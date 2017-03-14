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

- (IBAction)onDeleteClick:(id)sender {
    [self.delegate onDeleteClicked:self joke:self.jokeTextField.text];
}

- (IBAction)onSMSClick:(id)sender {
     [self.delegate onSMSClicked:self joke:self.jokeTextField.text];
}

- (IBAction)onEmailClick:(id)sender {
     [self.delegate onEmailClicked:self joke:self.jokeTextField.text];
}

- (IBAction)onHideClick:(id)sender {
     [self.delegate onHideClicked:self joke:self.jokeTextField.text];
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
