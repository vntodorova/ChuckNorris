//
//  CNTrimmedJoke.m
//  ChuckNorris
//
//  Created by VCS on 3/13/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "CNTrimmedJoke.h"

@implementation CNTrimmedJoke
#define TRIM_CELL_IDENTIFIER @"TrimmedCell"

+(NSString *)identifierForCell
{
    return TRIM_CELL_IDENTIFIER;
}

-(NSString*)getJoke
{
    NSString* result = self.value;
    if(self.value.length >= 50)
    {
        result = [self.value substringToIndex:50];
    }
    return result;
}

@end
