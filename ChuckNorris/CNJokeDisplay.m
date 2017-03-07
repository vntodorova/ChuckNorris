//
//  CNJokeDisplay.m
//  ChuckNorris
//
//  Created by VCS on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#include <JSONModel/JSONModel.h>

#import "CNJokeDisplay.h"
#import "CNJoke.h"

NSString *jokeValue;
NSString *urlToImage;
@implementation CNJokeDisplay

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Second controller";
        NSLog(@"------------------------------");
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval: 2.0
                                                  target: self
                                                selector:@selector(onTick:)
                                                userInfo: nil repeats:YES];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getCNJoke {
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSMutableString *urlToApi = [[NSMutableString alloc] init];
    
    self.searchedString = @"Chuck";
    
    [urlToApi appendString: @"https://api.chucknorris.io/jokes/random"];
    
    if (![self.searchedString isEqualToString: @""]) {
        [urlToApi appendString:@"?query="];
        [urlToApi appendString: self.searchedString];
        
    } else if(![self.category isEqualToString: @""]) {
        [urlToApi appendString: @"?category="];
        [urlToApi appendString: self.category];
    }
    
    NSURL * url = [NSURL URLWithString:urlToApi];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if(error == nil) {
                                                            NSError *error;
                                                            CNJoke *requestResult = [[CNJoke alloc] initWithData:data error:&error];
//                                                            NSLog(@"%@", );
                                                            urlToImage = requestResult.icon_url;
                                                            NSLog(@"%@", urlToImage);
                                                            jokeValue = requestResult.value;
                                                        }
                                                    }];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: urlToImage]];
    
    self.imageView.image = [UIImage imageWithData: imageData];
    //[imageData release];
    self.jokeField.text = jokeValue;
    [dataTask resume];
}

-(void)onTick:(NSTimer *)timer {
  [self getCNJoke];
}
@end
