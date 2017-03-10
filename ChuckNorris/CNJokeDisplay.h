//
//  CNJokeDisplay.h
//  ChuckNorris
//
//  Created by VCS on 3/2/17.
//  Copyright © 2017 Veneta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CollectionViewCell.h"
#import "CNJokeDisplay.h"
#import "CNJokeArray.h"
#import "LayoutProvider.h"

@class CNJoke;

typedef enum searchStateTypes
{
    SEARCH_BY_CATEGORY,
    SEARCH_BY_QUERY,
    
} Status;

@interface CNJokeDisplay : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    Status searchStatus;
    NSInteger numberOfColumns;
}

@property (weak, nonatomic) IBOutlet UISwitch *timerPauseSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

-(IBAction)switchToggle:(UISwitch *)sender;
-(IBAction)stopTimerSwitch:(UISwitch *)sender;
-(IBAction)changeColumnsNumber:(UIButton *)sender;

@property NSString *category;
@property NSString *searchedString;
@property NSURLSessionDataTask *dataTask;
@property NSMutableArray<CNJoke*> *jokeList;
@property LayoutProvider *layoutProvider;

-(void) getCNJoke: (NSMutableString *) providedUrl withResponseBlock: (void(^)(NSData*,NSURLResponse*, NSError*))respBlock;

-(void)responseHandler: (NSData *) data withResponse:(NSURLResponse *) response andError:(NSError *) error;

-(NSMutableString *)buildURL:(NSString *) searchString andCategory:(NSString*) category;

-(void)addFoundJokesToArray: (NSData*) data;

-(void)verifyResponse:(NSURLResponse *) response andData:(NSData *) data;

-(void)addCurrentJokeToArray: (NSData *) data;



@end

