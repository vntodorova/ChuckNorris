//
//  CNJokeDisplay.h
//  ChuckNorris
//
//  Created by VCS on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNJokeDisplay : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *jokeField;


-(void)getCNJoke;

@property NSString *category;
@property NSString *searchedString;

@end

