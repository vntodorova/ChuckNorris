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

#define CELL_IDENTIFIER @"CVCell"

@implementation CNJokeDisplay

static const int STATUS_SEARCH_BY_QUERY = 1;
static const int STATUS_SEARCH_BY_CATEGORY = 2;

typedef void (^ RequstHandleBlock)(NSData*, NSURLResponse*, NSError*);


- (void)viewDidLoad {
    //[super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NibCell" bundle:nil] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    
    self.jokeList = [[NSMutableArray alloc] init];
    
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
        [self getCNJoke:urlToApi withResponseBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
            [self responseHandler:data withResponse:response andError:error];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableString *)buildURL:(NSString *) searchString andCategory:(NSString*) category{
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString: @"https://api.chucknorris.io/jokes/"];
    
    if (searchString != nil) {
        [result appendString:@"search?query="];
        [result appendString: searchString];
        
    } else if(category != nil) {
        [result appendString: @"random?category="];
        [result appendString: category];
    }
    return result;
}

-(void) getCNJoke: (NSMutableString *) providedUrl withResponseBlock:(void (^)(NSData *, NSURLResponse *, NSError *))respBlock {
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:providedUrl];
    
    self.dataTask = [defaultSession dataTaskWithURL:url
                                  completionHandler:respBlock];
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
            NSLog(@"%@", requestResult.result);
            [self.jokeList addObjectsFromArray:requestResult.result];
            dispatch_async(dispatch_get_main_queue(),^{
                [self.collectionView reloadData];
            });
            
        } else {
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
        [self.collectionView reloadData];
    });
}

-(void) onTick {
    NSMutableString *urlToApi = [self buildURL:self.searchedString andCategory:self.category];
    [self getCNJoke:urlToApi withResponseBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self responseHandler:data withResponse:response andError:error];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.jokeList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    CNJoke * joke = [self.jokeList objectAtIndex:indexPath.row];
    cell.jokeLabel.text = joke.value;

    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenWidth;
    if(_switchView.isOn){
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        screenWidth = screenRect.size.width;
    } else {
        screenWidth = 50;
    }
    return CGSizeMake(screenWidth,50);
}

- (IBAction)switchToggle:(UISwitch *)sender {
    dispatch_async(dispatch_get_main_queue(),^{
        [self.collectionView reloadData];
    });
}
@end
