//
//  CNJokeArray.h
//  ChuckNorris
//
//  Created by VCS on 3/7/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNJoke.h"

@interface CNJokeArray : JSONModel
@property NSString *total;
@property (strong, nonatomic) NSArray<CNJoke*> <CNJoke> *result;

@end
