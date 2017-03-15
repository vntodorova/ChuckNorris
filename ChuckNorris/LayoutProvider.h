//
//  LayoutProvider.h
//  ChuckNorris
//
//  Created by Nemetschek A-Team on 3/10/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NormalCell.h"
#import "CNJoke.h"
#import "ExpandedCell.h"
#import "CNTrimmedJoke.h"
#import "ExpandedCell.h"

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
{
    NSInteger numberOfColumnsIpad;
    id<cellDelagate> delegateObject;
}

- (void)initialize: (id<cellDelagate>) delegate;
- (void)changeCVLayout: (CollectionViewLayout) layout;
- (CGSize)getIPhoneCellSize;
- (CGSize)getIPadCellSize;
- (CGSize)getCellSize;
- (NormalCell *)getNewCell:(UICollectionView *) collectionView
                      atIndexPath: (NSIndexPath *)indexPath
                         withJoke:(CNJoke *) joke;

- (void)switchNumberOfColumnsIpad;

@property CollectionViewLayout cvLayout;
@property DeviceType deviceType;

@end
