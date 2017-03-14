//
//  ExpandedCell.h
//  ChuckNorris
//
//  Created by VCS on 3/13/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNJoke.h"
@class ExpandedCell;

@protocol cellDelagate <NSObject>

-(void) onHideClicked:(ExpandedCell *) cell joke:(CNJoke *) joke;
-(void) onDeleteClicked:(ExpandedCell *) cell joke:(CNJoke *) joke;
-(void) onEmailClicked:(ExpandedCell *) cell joke:(CNJoke *) joke;
-(void) onSMSClicked:(ExpandedCell *) cell joke:(CNJoke *) joke;

@end

@interface ExpandedCell : UICollectionViewCell
@property CNJoke *cellJoke;
@property (nonatomic , weak) id<cellDelagate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *jokeTextField;

- (IBAction)onDeleteClick:(id)sender;
- (IBAction)onSMSClick:(id)sender;
- (IBAction)onEmailClick:(id)sender;
- (IBAction)onHideClick:(id)sender;

@end
