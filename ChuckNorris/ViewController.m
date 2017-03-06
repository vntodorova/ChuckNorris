//
//  ViewController.m
//  ChuckNorris
//
//  Created by Veneta on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "ViewController.h"
#import "CNJokeDisplay.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"First Controller";
    [self retrieveCategories];
        // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)getResults:(UIButton *)sender {
    self.searchString = _textField.text;
    NSLog(@"%@", self.searchString);
    CNJokeDisplay *secondController = [[CNJokeDisplay alloc] initWithNibName:nil bundle:nil];
    secondController.category = self.chosenCategory;
    secondController.searchedString = self.searchString;
    [self.navigationController pushViewController:secondController animated:YES];
}

- (void)retrieveCategories{
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:@"https://api.chucknorris.io/jokes/categories"];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if(error == nil) {
                                                            NSError *error;
                                                            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                            self.allCategories = (NSArray *) jsonObject;
                                                            
                                                        }
                                                    }];
    [dataTask resume];
}

- (IBAction)chooseCategory:(UIButton *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Categories"
                                                                   message:@"Choose category"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString* currentCategory in self.allCategories) {
        [alert addAction:[UIAlertAction actionWithTitle:currentCategory style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.chosenCategory = currentCategory;
            NSLog(@"%@", _chosenCategory);
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
