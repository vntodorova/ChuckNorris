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
    //self.jokeList = [[NSMutableArray init] alloc];
    self.title = @"Second controller";
    [NSTimer scheduledTimerWithTimeInterval: 2.0 target: self
                                   selector:@selector(getCNJoke)
                                   userInfo: nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableString *)buildURL:(NSString *) searchString andCategory:(NSString*) category{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString: @"https://api.chucknorris.io/jokes/"];
    
    if (!(searchString == nil)) {
        [result appendString:@"search?query="];
        [result appendString: searchString];
        
    } else if(!(category == nil)) {
        [result appendString: @"random?category="];
        [result appendString: category];
    }
    NSLog(@"%@",result);
    return result;
}

-(void) getCNJoke {
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSMutableString *urlToApi = [self buildURL:self.searchedString andCategory:self.category];
    
    NSURL * url = [NSURL URLWithString:urlToApi];
    self.dataTask = [defaultSession dataTaskWithURL:url
                                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                      @try {
                                           [self responseHandler:data withResponse:response andError:error];
                                      } @catch (NSException *exception) {
                                          NSLog(@"OPS %@", [exception description]);
                                      }
                                  }];
    [self.dataTask resume];
}

-(void) responseHandler:(NSData * _Nonnull) data withResponse:(NSURLResponse *) response andError:(NSError *) responseError {
    if (data == nil || data.length == 0) {
        @throw [NSException
                exceptionWithName:@"Exception"
                reason:@"Data empty"
                userInfo:nil];
    }
    
    if (response == nil) {
        @throw [NSException
                exceptionWithName:@"Exception"
                reason:@"Response is nil"
                userInfo:nil];
    }
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    
    if([httpResponse statusCode] != 200) {
        @throw [NSException
                exceptionWithName:@"Exception"
                reason:[NSString stringWithFormat:@"Response code %ld", (long)[httpResponse statusCode]]
                userInfo:nil];
    }
    
    if(responseError == nil ) {
        NSError *error;
        CNJoke *requestResult = [[CNJoke alloc] initWithData:data error:&error];
        
        if(error == nil) {
            [self.jokeList addObject:requestResult];
            [self updateUI:requestResult];
            
        } else {
            @throw[NSException
                   exceptionWithName:@"Exception"
                   reason:[NSString stringWithFormat:@"Data is invalid format :%@",[data description]]
                   userInfo: nil];
        }
    } else {
        @throw [NSException
                exceptionWithName:@"Exception"
                reason:[NSString stringWithFormat:@"Error recived %@", [responseError description]]
                userInfo:nil];
    }
}



-(void)updateUI:(CNJoke *) joke{
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: joke.icon_url]];
    dispatch_async(dispatch_get_main_queue(),^{
        self.imageView.image = [UIImage imageWithData: imageData];
        self.jokeField.text = joke.value;
    });
}
@end
