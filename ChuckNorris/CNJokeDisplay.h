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
@property NSString *category;
@property NSString *searchedString;
@property NSURLSessionDataTask *dataTask;
@property NSMutableArray *jokeList;
- (void)getCNJoke;
- (void)responseHandler: (NSData *) data withResponse:(NSURLResponse *) response andError:(NSError *) error;
- (NSMutableString *)buildURL:(NSString *) searchString andCategory:(NSString*) category;


@end

