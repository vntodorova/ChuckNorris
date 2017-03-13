//
//  LayoutProvider.m
//  ChuckNorris
//
//  Created by Nemetschek A-Team on 3/10/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "LayoutProvider.h"
#import <UIKit/UIKit.h>
#define CELL_IDENTIFIER @"CVCell"
#define SPACE_BETWEEN_CELLS_IPHONE 5;
#define SPACE_BETWEEN_CELLS_IPAD 10;

@implementation LayoutProvider

- (void) initialize
{
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
                      atIndexPath: (NSIndexPath *)indexPath
                         withJoke:(CNJoke *) joke
{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    
    cell.jokeLabel.text = joke.value;
    cell.layer.cornerRadius = 5;
    cell.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 1.0f;
    cell.layer.masksToBounds = NO;
    
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
