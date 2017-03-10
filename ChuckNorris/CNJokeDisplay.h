//
//  CNJokeDisplay.h
//  ChuckNorris
//
//  Created by VCS on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#include <JSONModel/JSONModel.h>

#import "CollectionViewCell.h"
#import "CNJokeDisplay.h"
#import "CNJoke.h"
#import "CNJokeArray.h"


@class CNJoke;

@interface CNJokeDisplay : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UISwitch *timerPauseSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)switchToggle:(UISwitch *)sender;
- (IBAction)stopTimerSwitch:(UISwitch *)sender;

@property NSInteger currentStatus;
@property NSString *category;
@property NSString *searchedString;
@property NSURLSessionDataTask *dataTask;
@property NSMutableArray<CNJoke*> *jokeList;

-(void) getCNJoke: (NSMutableString *) providedUrl withResponseBlock: (void(^)(NSData*,NSURLResponse*, NSError*))respBlock;

- (void)responseHandler: (NSData *) data withResponse:(NSURLResponse *) response andError:(NSError *) error;

- (NSMutableString *)buildURL:(NSString *) searchString andCategory:(NSString*) category;


@end

