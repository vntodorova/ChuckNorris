//
//  CNJokeDisplay.m
//  ChuckNorris
//
//  Created by VCS on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "CNJokeDisplay.h"

@implementation CNJokeDisplay

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Second controller";
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getCNJoke {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:@"http://api.icndb.com/jokes/random"];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if(error == nil)
                                                        {
                                                            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                            NSLog(@"Data = %@",text);
                                                        }
                                                    }];
    [dataTask resume];
}
@end
