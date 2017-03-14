//
//  LayoutProvider.m
//  ChuckNorris
//
//  Created by Nemetschek A-Team on 3/10/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "LayoutProvider.h"

#define SPACE_BETWEEN_CELLS_IPHONE 5;
#define SPACE_BETWEEN_CELLS_IPAD 10;

@interface LayoutProvider()
@property (strong , nonatomic) NSMutableDictionary *cellsForModelRegister;

@end

@implementation LayoutProvider

- (void) initialize
{
    self.cellsForModelRegister = [[NSMutableDictionary alloc] init];
    [self.cellsForModelRegister setObject:[CollectionViewCell class] forKey:[[CNJoke class] description]];
    [self.cellsForModelRegister setObject:[ExpandedCell class] forKey:[[CNTrimmedJoke class] description]];
    
    NSString *currentDeviceType = [UIDevice currentDevice].model;
    if([currentDeviceType isEqualToString:@"iPhone"])
    {
        _deviceType = IPHONE;
    } else {
        _deviceType = IPAD;
    }
    
    _cvLayout = LIST;
    numberOfColumnsIpad = 3;
}

- (CGSize)getCellSize
{
    if(_deviceType == IPHONE)
    {
        return self.getIPhoneCellSize;
    }
    return self.getIPadCellSize;
}

- (CGSize)getIPhoneCellSize
{
    CGFloat width;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if(self.cvLayout == GRID)
    {
        width = screenRect.size.width/2.0 - SPACE_BETWEEN_CELLS_IPHONE;
        return CGSizeMake(width,70);
    }
    
    width = screenRect.size.width;
    return CGSizeMake(width,50);
}

- (CGSize)getIPadCellSize
{
    CGFloat width;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if(self.cvLayout == GRID)
    {
        width = screenRect.size.width/numberOfColumnsIpad - SPACE_BETWEEN_CELLS_IPAD;
        return CGSizeMake(width,100);
    }
    
    width = screenRect.size.width;
    return CGSizeMake(width,70);
}

-(CollectionViewCell *)getNewCell:(UICollectionView *) collectionView
                      atIndexPath:(NSIndexPath *)indexPath
                         withJoke:(CNJoke *) joke
{
    NSString* cellIdentifier = [joke.class identifierForCell];
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell setupCellWithJoke:joke];
    
    return cell;
}

- (void)changeCVLayout: (CollectionViewLayout) layout
{
    self.cvLayout = layout;
}

- (void)switchNumberOfColumnsIpad
{
    if(numberOfColumnsIpad == 3){
        numberOfColumnsIpad = 4;
    } else {
        numberOfColumnsIpad = 3;
    }
}

@end
