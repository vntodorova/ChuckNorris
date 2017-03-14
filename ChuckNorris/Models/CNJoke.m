//
//  CNJoke.m
//  ChuckNorris
//
//  Created by VCS on 3/6/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "CNJoke.h"
#define CELL_IDENTIFIER @"NormalCell"


@implementation CNJoke

+(NSString *)identifierForCell
{
    return CELL_IDENTIFIER;
}

-(NSString*)getJoke
{
    return self.value;
}

@end
