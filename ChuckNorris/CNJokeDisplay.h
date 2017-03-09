//
//  CNJokeDisplay.h
//  ChuckNorris
//
//  Created by VCS on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"

@interface CNJokeDisplay : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSInteger currentStatus;
@property NSString *category;
@property NSString *searchedString;
@property NSURLSessionDataTask *dataTask;
@property NSMutableArray *jokeList;
-(void) getCNJoke: (NSMutableString *) providedUrl;
- (void)responseHandler: (NSData *) data withResponse:(NSURLResponse *) response andError:(NSError *) error;
- (NSMutableString *)buildURL:(NSString *) searchString andCategory:(NSString*) category;


@end

