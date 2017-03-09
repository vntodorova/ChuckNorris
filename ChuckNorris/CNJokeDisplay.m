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
#import "CNJokeArray.h"

@implementation CNJokeDisplay

static const int STATUS_SEARCH_BY_QUERY = 1;
static const int STATUS_SEARCH_BY_CATEGORY = 2;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    if(self.searchedString == nil) {
        self.currentStatus = STATUS_SEARCH_BY_CATEGORY;
        self.title = [NSString stringWithFormat:@"Category : %@", self.category];
        
        [NSTimer scheduledTimerWithTimeInterval: 2.0
                                         target: self
                                       selector:@selector(onTick)
                                       userInfo: nil repeats:YES];
    } else {
        self.currentStatus = STATUS_SEARCH_BY_QUERY;
        self.title = [NSString stringWithFormat:@"Searched word : %@", self.searchedString];
        NSMutableString *urlToApi = [self buildURL:self.searchedString andCategory:self.category];
        [self getCNJoke:urlToApi];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableString *)buildURL:(NSString *) searchString andCategory:(NSString*) category{
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString: @"https://api.chucknorris.io/jokes/"];
    
    if (self.currentStatus == STATUS_SEARCH_BY_QUERY) {
        [result appendString:@"search?query="];
        [result appendString: searchString];
        
    } else if(self.currentStatus == STATUS_SEARCH_BY_CATEGORY) {
        [result appendString: @"random?category="];
        [result appendString: category];
    }
//    NSLog(@"%@",result);
    return result;
}

-(void) getCNJoke: (NSMutableString *) providedUrl {
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:providedUrl];
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
        
        if(self.currentStatus == STATUS_SEARCH_BY_QUERY){
            CNJokeArray *requestResult = [[CNJokeArray alloc] initWithData:data error:&error];
            [self.jokeList addObjectsFromArray:requestResult.result];
            
        } else{
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
        //self.jokeField.text = joke.value;
    });
}

-(void) onTick {
    NSMutableString *urlToApi = [self buildURL:self.searchedString andCategory:self.category];
    [self getCNJoke:urlToApi];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *sectionArray = [self.jokeList objectAtIndex:section];
    return [sectionArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CollectionViewCell";
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSMutableArray *data = [self.jokeList objectAtIndex:indexPath.section];
    NSString *cellData = [data objectAtIndex:indexPath.row];
    [cell.joke setText:cellData];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [[self jokeList] count];
}
@end
