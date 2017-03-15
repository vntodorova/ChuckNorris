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

- (void)onDeleteClick:(id)sender {
    [self.delegate onDeleteClicked:self joke:self.cellJoke];
}

- (void)onSMSClick:(id)sender {
    [self.delegate onSMSClicked:self joke:self.cellJoke];
}

- (void)onEmailClick:(id)sender {
    [self.delegate onEmailClicked:self joke:self.cellJoke];
}

- (void)onHideClick:(id)sender {
    [self.delegate onHideClicked:self joke:self.cellJoke];
}

-(void)setupCellWithJoke:(CNJoke*)joke
{
    self.cellJoke = joke;
    self.jokeTextField.text = joke.getJoke;
    self.layer.cornerRadius = 5;
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2.0f);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 1.0f;
    self.layer.masksToBounds = NO;
}
@end
