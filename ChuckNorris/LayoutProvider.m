//
//  LayoutProvider.m
//  ChuckNorris
//
//  Created by Nemetschek A-Team on 3/10/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import "LayoutProvider.h"
#import <UIKit/UIKit.h>

@implementation LayoutProvider

- (CGSize)getCellSize:(NSInteger)columns
{
    CGFloat width;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    if(self.cvLayout == GRID){
        if(_deviceType == IPHONE){
            width = screenRect.size.width/2 - 5;
            return CGSizeMake(width,70);
        }
        
        if(_deviceType == IPAD){
            width = screenRect.size.width/(float)columns - 5;
            return CGSizeMake(width,70);
        }
    }
    
    width = screenRect.size.width;
    return CGSizeMake(width,50);
    
}

- (CollectionViewCell *)getNewCell:(CollectionViewCell *)cell withJoke:(CNJoke *)joke
{
    cell.jokeLabel.text = joke.value;
    cell.layer.cornerRadius = 5;
    cell.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 1.0f;
    cell.layer.masksToBounds = NO;
    
    return cell;
}

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
    
}

- (void)changeCVLayout: (CollectionViewLayout) layout
{
    self.cvLayout = layout;
}

@end
