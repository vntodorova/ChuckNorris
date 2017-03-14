//
//  ExpandedCell.h
//  ChuckNorris
//
//  Created by VCS on 3/13/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExpandedCell;

@protocol cellDelagate <NSObject>

-(void) onDeleteClicked:(ExpandedCell *) cell joke:(NSString *) joke;
-(void) onEmailClicked:(ExpandedCell *) cell joke:(NSString *) joke;
-(void) onSMSClicked:(ExpandedCell *) cell joke:(NSString *) joke;
-(void) onHideClicked:(ExpandedCell *) cell joke:(NSString *) joke;
@end
@interface ExpandedCell : UICollectionViewCell

@property (nonatomic , weak) id<cellDelagate> delegate;

- (IBAction)onDeleteClick:(id)sender;
- (IBAction)onSMSClick:(id)sender;
- (IBAction)onEmailClick:(id)sender;
- (IBAction)onHideClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *jokeTextField;

@end
