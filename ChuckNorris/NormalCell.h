//
//  NormalCell.h
//  ChuckNorris
//
//  Created by Nemetschek A-Team on 3/9/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNJoke.h"

@interface NormalCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *jokeLabel;

-(void)setupCellWithJoke:(CNJoke*)joke;

@end
