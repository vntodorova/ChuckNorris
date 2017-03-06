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


- (IBAction)button:(id)sender {
}
- (IBAction)onButtonPressed:(id)sender {
    CNJokeDisplay *secondController = [[CNJokeDisplay alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:secondController animated:YES];
}
@end
