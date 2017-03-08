//
//  ViewController.m
//  ChuckNorris
//
//  Created by Veneta on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "ViewController.h"
#import "CNJokeDisplay.h"
@interface ViewController () <UISearchBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chuck Norris Jokes";
    [self retrieveCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)retrieveCategories{
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"https://api.chucknorris.io/jokes/categories"];
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                                       [self handleCompletion:data andResponse:response andError:error];
                                                   }];
    [dataTask resume];
}

- (BOOL)handleCompletion:	(NSData *) data
             andResponse: (NSURLResponse *)response
                andError: (NSError *) error{
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *) response;
    if(error == nil && [resp statusCode] == 200) {
        NSError *error;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        self.allCategories = (NSArray *) jsonObject;
        return YES;
    }
    return NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"%@", searchBar.text);
    CNJokeDisplay *secondController = [[CNJokeDisplay alloc] initWithNibName:nil bundle:nil];
    secondController.searchedString = searchBar.text;
    [self.navigationController pushViewController:secondController animated:YES];
}

- (IBAction)chooseCategoryButtonClicked:(UIButton *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Categories"
                                                                   message:@"Choose category"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString* currentCategory in self.allCategories) {
        [alert addAction:[UIAlertAction actionWithTitle:currentCategory style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            CNJokeDisplay *secondController = [[CNJokeDisplay alloc] initWithNibName:nil bundle:nil];
            secondController.category = currentCategory;
            NSLog(@"%@", currentCategory);
            [self.navigationController pushViewController:secondController animated:YES];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
