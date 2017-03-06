//
//  CNJoke.h
//  ChuckNorris
//
//  Created by VCS on 3/6/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface CNJoke : JSONModel

@property (nonatomic, strong) NSArray<NSString*><Optional> *category;
@property (nonatomic, strong) NSString *icon_url;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *value;

@end
