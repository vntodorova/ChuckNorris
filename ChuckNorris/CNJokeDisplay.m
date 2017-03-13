//
//  CNJokeDisplay.m
//  ChuckNorris
//
//  Created by VCS on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "LayoutProvider.h"
#import "CNJokeDisplay.h"
#import <MessageUI/MessageUI.h>
#define CELL_IDENTIFIER @"CVCell"

@implementation CNJokeDisplay

BOOL isPaused = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.layoutProvider = [[LayoutProvider alloc] init];
    [[self layoutProvider] initialize];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NibCell" bundle:nil] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    self.jokeList = [[NSMutableArray alloc] init];
    
    if(self.searchedString == nil) {
        searchStatus = SEARCH_BY_CATEGORY;
        self.title = [NSString stringWithFormat:@"Category : %@", self.category];
        
    [NSTimer scheduledTimerWithTimeInterval: 2.0
                                    target: self
                                    selector:@selector(onTick)
                                    userInfo: nil repeats:YES];
        
    } else {
        searchStatus = SEARCH_BY_QUERY;
        self.title = [NSString stringWithFormat:@"Searched word : %@", self.searchedString];
        NSMutableString *urlToApi = [self buildURL:self.searchedString andCategory:self.category];
        [self getCNJoke:urlToApi withResponseBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
            [self responseHandler:data withResponse:response andError:error];
        }];
    }
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.delegate = self;
    [self.collectionView addGestureRecognizer:lpgr];
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
    [self verifyResponse:response andData:data];
    if(responseError == nil ) {
        if(searchStatus == SEARCH_BY_QUERY){
            [self addFoundJokesToArray:data];
        } else {
            [self addCurrentJokeToArray:data];
        }
    } else {
        @throw [NSException
                exceptionWithName:@"Exception"
                reason:[NSString stringWithFormat:@"Error recived %@", [responseError description]]
                userInfo:nil];
    }
}

-(void)verifyResponse:(NSURLResponse *) response
              andData:(NSData *) data
{
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
}

-(void)addCurrentJokeToArray: (NSData *) data
{
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
}

-(void)addFoundJokesToArray: (NSData*) data
{
    NSError *error;
    CNJokeArray *requestResult = [[CNJokeArray alloc] initWithData:data error:&error];
    if(error == nil) {
        [self.jokeList addObjectsFromArray:requestResult.result];
        dispatch_async(dispatch_get_main_queue(),^{
            [self.collectionView reloadData];
        });
    } else {
        @throw[NSException
               exceptionWithName:@"Exception"
               reason:[NSString stringWithFormat:@"Data is invalid format :%@",[data description]]
               userInfo: nil];
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
    if(!isPaused){
        NSMutableString *urlToApi = [self buildURL:self.searchedString andCategory:self.category];
        [self getCNJoke:urlToApi withResponseBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self responseHandler:data withResponse:response andError:error];
        }];
    }
}

- (IBAction)switchToggle:(UISwitch *)sender {
    if(self.layoutProvider.cvLayout == GRID){
        [[self layoutProvider] setCvLayout:LIST];
    } else {
        [[self layoutProvider] setCvLayout:GRID];
    }
    
    dispatch_async(dispatch_get_main_queue(),^{
        [self.collectionView reloadData];
    });
}

- (IBAction)stopTimerSwitch:(UISwitch *)sender {
    isPaused = !isPaused;
}

- (IBAction)changeColumnsNumber:(UIButton *)sender
{
    [[self layoutProvider] switchNumberOfColumnsIpad];
    dispatch_async(dispatch_get_main_queue(),^{
        [self.collectionView reloadData];
    });
}

#pragma mark - CollectionView delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.jokeList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CNJoke *joke = [self.jokeList objectAtIndex:indexPath.row];
    return [[self layoutProvider] getNewCell:collectionView atIndexPath:indexPath withJoke:joke];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [[self layoutProvider] getCellSize];
    return size;
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    if (indexPath != nil && [MFMailComposeViewController canSendMail])
    {
        [self sendMailWithJoke:[_jokeList objectAtIndex:indexPath.row]];
    } else
    {
        UIAlertController * alert=[UIAlertController
                                   alertControllerWithTitle:@"Error"
                                   message:@"Device is not able to send email."
                                   preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* close = [UIAlertAction
                                actionWithTitle:@"Close"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                }];
        [alert addAction:close];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)sendMailWithJoke: (CNJoke *) joke
{
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    mailController.mailComposeDelegate = self;
    [mailController setMessageBody:[joke value] isHTML:NO];
    [self presentViewController:mailController animated:YES completion:NULL];

}
@end
