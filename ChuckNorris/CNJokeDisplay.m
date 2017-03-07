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

@implementation CNJokeDisplay

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Second controller";
        NSLog(@"------------------------------");
    [NSTimer scheduledTimerWithTimeInterval: 2.0
                                                  target: self
                                                selector:@selector(getCNJoke)
                                                userInfo: nil repeats:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableString *)buildURL:(NSString *) searchString andCategory:(NSString*) category{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString: @"https://api.chucknorris.io/jokes/random"];
    
    if (!(searchString == nil)) {
        [result appendString:@"?query="];
        [result appendString: searchString];
        
    } else if(!(category == nil)) {
        [result appendString: @"?category="];
        [result appendString: category];
    }
    
    return result;
}

-(void) getCNJoke {
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSMutableString *urlToApi = [self buildURL:self.searchedString andCategory:self.category];
    
    NSURL * url = [NSURL URLWithString:urlToApi];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if(error == nil) {
                                                            NSError *error;
                                                            CNJoke *requestResult = [[CNJoke alloc] initWithData:data error:&error];
                                                            [self updateUI:requestResult];
                                                        }
                                                    }];
    [dataTask resume];
}

-(void)updateUI:(CNJoke *) joke{
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: joke.icon_url]];
    dispatch_async(dispatch_get_main_queue(),^{
        self.imageView.image = [UIImage imageWithData: imageData];
        self.jokeField.text = joke.value;
    });
}
@end
