//
//  LayoutProvider.h
//  ChuckNorris
//
//  Created by Nemetschek A-Team on 3/10/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
#import "CNJoke.h"

typedef enum deviceTypes
{
    IPHONE,
    IPAD,
    
} DeviceType;

typedef enum collectionViewLayoutTypes
{
    LIST,
    GRID,
} CollectionViewLayout;

@interface LayoutProvider : NSObject

- (void)initialize;
- (void)changeCVLayout: (CollectionViewLayout) layout;
- (CGSize)getCellSize:(NSInteger)columns;
- (CollectionViewCell *)getNewCell:(CollectionViewCell *)cell withJoke:(CNJoke *)joke;

@property CollectionViewLayout cvLayout;
@property DeviceType deviceType;

@end
