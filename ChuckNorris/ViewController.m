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

- (IBAction)chooseCategory:(UIButton *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Categories"
                                                                   message:@"Choose category"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *categories = [NSArray arrayWithObjects:@"Explicit", @"Dev", @"Movie", @"Food", @"Celebrity", @"Science", @"Political", @"Sport", @"Religion", @"Animal", @"Music", @"History", @"Travel", @"Career", @"Money", @"Fashion",nil];
    
    for (NSString* currentCategory in categories) {
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
