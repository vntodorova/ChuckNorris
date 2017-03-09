//
//  CNJokeArray.m
//  ChuckNorris
//
//  Created by VCS on 3/7/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "CNJokeArray.h"
#import "CNJoke.h"
@implementation CNJokeArray

-(void) populateResultWithJokes
{
    NSMutableArray<CNJoke*> *tempArray = [[NSMutableArray alloc] init];
    for (NSDictionary* jokeDictionary in self.result) {
        CNJoke *temp = [[CNJoke alloc] initWithDictionary:jokeDictionary];
        [tempArray addObject:temp];
    }
    self.result = tempArray;
}

@end
