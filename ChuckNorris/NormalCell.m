//
//  NormalCell.h
//  ChuckNorris
//
//  Created by Nemetschek A-Team on 3/9/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "NormalCell.h"

@implementation NormalCell

-(void)setupCellWithJoke:(CNJoke*)joke
{
    self.jokeLabel.text = joke.getJoke;
    self.layer.cornerRadius = 5;
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2.0f);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 1.0f;
    self.layer.masksToBounds = NO;
}

@end
