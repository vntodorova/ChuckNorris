//
//  CNJokeArray.h
//  ChuckNorris
//
//  Created by VCS on 3/7/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "CNJoke.h"



@interface CNJokeArray : JSONModel
@property NSString *total;
@property NSArray<CNJoke*> *result;
-(void) populateResultWithJokes;

@end
