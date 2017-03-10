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

#define KEYBOARD_HEIGHT 90.0

@implementation ViewController

BOOL keyboardIsShown = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chuck Norris Jokes";
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(dismissKeyboard)]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
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
                                                       [self responseHandler:data withResponse:response andError:error];
                                                   }];
    [dataTask resume];
}

- (void) dismissKeyboard
{
    // add self
    [self.searchBar resignFirstResponder];
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
        
        if(error == nil) {
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            self.allCategories = (NSArray *) jsonObject;
            
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


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
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

-(void)keyboardWillShow {
    if(keyboardIsShown == NO){
        keyboardIsShown = YES;
        [self moveUpView:YES];
    }
}

-(void)keyboardWillHide {
    if(keyboardIsShown == YES){
        keyboardIsShown = NO;
        [self moveUpView:NO];
    }
}

-(void)moveUpView:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        rect.origin.y -= KEYBOARD_HEIGHT;
        rect.size.height += KEYBOARD_HEIGHT;
    }
    else
    {
        rect.origin.y += KEYBOARD_HEIGHT;
        rect.size.height -= KEYBOARD_HEIGHT;
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}


@end
