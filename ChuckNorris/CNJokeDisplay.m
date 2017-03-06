//
//  CNJokeDisplay.m
//  ChuckNorris
//
//  Created by VCS on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#include <JSONModel/JSONModel.h>

#import "CNJokeDisplay.h"
#import "CNJokeReqeustResult.h"

@implementation CNJokeDisplay

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Second controller";
        NSLog(@"------------------------------");
    [self getCNJoke];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getCNJoke {
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:@"https://api.chucknorris.io/jokes/random"];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if(error == nil) {
                                                            NSError *error;
                                                            CNJoke *requestResult = [[CNJoke alloc] initWithData:data error:&error];
                                                            
                                                            NSLog(@"%@", requestResult.value);
                                                        }
                                                    }];
    [dataTask resume];
}
@end
