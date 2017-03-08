//
//  ChuckNorrisTests.m
//  ChuckNorrisTests
//
//  Created by Veneta on 3/7/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "CNJokeDisplay.h"

@interface ChuckNorrisTests : XCTestCase

@end

@implementation ChuckNorrisTests

-(void) testBuildURLWithCategory {
    CNJokeDisplay *testClass = [[CNJokeDisplay alloc] init];
    NSMutableString *urlResult = [testClass buildURL:nil andCategory:@"animal"];
    NSString *str = [NSString stringWithString:urlResult];
    XCTAssertEqualObjects(str, @"https://api.chucknorris.io/jokes/random?category=animal", @"1. URL BUILD FAILED");
}

-(void) testBuildURLWithQuery {
    CNJokeDisplay *testClass = [[CNJokeDisplay alloc] init];
    NSMutableString *urlResult = [testClass buildURL:@"bear" andCategory:@"animal"];
    NSString *str = [NSString stringWithString:urlResult];
    XCTAssertEqualObjects(str, @"https://api.chucknorris.io/jokes/search?query=bear", @"2. URL BUILD FAILED");
}

-(void) testResponseHandlerDataNil{
    CNJokeDisplay *testClass = [[CNJokeDisplay alloc] init];
    
    XCTAssertThrows([testClass responseHandler:nil withResponse:[[NSURLResponse alloc] init] andError:nil], "Data is nil");
    
    XCTAssertThrows([testClass responseHandler:[[NSData alloc] init] withResponse:nil andError:nil], "Response is nil");
}

-(void) testResposeHandlerWithError{
    CNJokeDisplay *testClass = [[CNJokeDisplay alloc] init];
    
    XCTAssertThrows([testClass responseHandler:[[NSData alloc] init] withResponse:[[NSURLResponse alloc] init] andError:[[NSError alloc] init]], "Error is not nil");
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
