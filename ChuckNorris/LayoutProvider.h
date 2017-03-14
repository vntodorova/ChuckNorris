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
#import "ExpandedCell.h"
#import "CNTrimmedJoke.h"

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
}

- (void)initialize;
- (void)changeCVLayout: (CollectionViewLayout) layout;
- (CGSize)getIPhoneCellSize;
- (CGSize)getIPadCellSize;
- (CGSize)getCellSize;
- (CollectionViewCell *)getNewCell:(UICollectionView *) collectionView
                      atIndexPath: (NSIndexPath *)indexPath
                         withJoke:(CNJoke *) joke;
- (void)switchNumberOfColumnsIpad;

@property CollectionViewLayout cvLayout;
@property DeviceType deviceType;

@end
