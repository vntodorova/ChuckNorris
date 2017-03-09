//
//  CNJoke.m
//  ChuckNorris
//
//  Created by VCS on 3/6/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "CNJoke.h"

@implementation CNJoke

-(instancetype)initWithDictionary:(NSDictionary *) dictionary
{
    self = [super init];
    if (self)
    {
        self.id = [dictionary valueForKey:@"id"];
        self.icon_url = [dictionary valueForKey:@"icon_url"];
        self.value = [dictionary valueForKey:@"value"];
        self.url = [dictionary valueForKey:@"url"];
        self.category = [dictionary valueForKey:@"category"];
    }
    
    return self;
}



@end
