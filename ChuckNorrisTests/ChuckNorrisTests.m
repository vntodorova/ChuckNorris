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

-(void)testRetrieveCategories{
    ViewController *testClass = [[ViewController alloc] init];
    NSArray* result = [testClass retrieveCategories];
    XCTAssertNil(result,@"Categories not found");
}

-(void) testBuildURL {
    CNJokeDisplay *testClass = [[CNJokeDisplay alloc] init];
    
    //TEST 1
    NSMutableString *urlResult = [testClass buildURL:nil andCategory:@"animal"];
    NSString *str = [NSString stringWithString:urlResult];
    XCTAssertEqualObjects(str, @"https://api.chucknorris.io/jokes/random?category=animal", @"1. URL BUILD FAILED");
    
    //TEST 2
    urlResult = [testClass buildURL:@"bear" andCategory:@"animal"];
    str = [NSString stringWithString:urlResult];
    XCTAssertEqualObjects(str, @"https://api.chucknorris.io/jokes/search?query=bear", @"2. URL BUILD FAILED");
}

- (void)testGetCNJokeWithCategory {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    
    NSURL * url = [NSURL URLWithString:@"https://api.chucknorris.io/jokes/random?category=animal"];
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       XCTAssertNil(error, @"Error occured : %@", error);
                                                       
                                                       if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                           XCTAssertNotNil(data, "Data returned is nill");
                                                       }
                                                       [expectation fulfill];
                                                   }];
    [dataTask resume];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testGetCNJokeWithQuery {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
//    [CNJokeDisplay asyncMethodWithCompletionBlock:^(NSError *error, NSHTTPURLResponse *httpResponse, NSData *data) {
//        
//        if(error)
//        {
//            NSLog(@"error is: %@", error);
//        }else{
//            NSInteger statusCode = [httpResponse statusCode];
//            XCTAssertEqual(statusCode, 200);
//            [expectation fulfill];
//        }
//        
//    }];
    
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
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
