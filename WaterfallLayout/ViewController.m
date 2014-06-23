//
//  ViewController.m
//  WaterfallLayout
//
//  Created by Russell on 6/23/14.
//  Copyright (c) 2014 Russell Research Corporation. All rights reserved.
//
//------------------------------------------------------------------------------

#import "ViewController.h"
#import "WaterfallLayout.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate> {
    
    BOOL mIsPortrait;
    WaterfallLayout *mWaterfallLayout;
    UICollectionView *mCollectionView;
    
}

@end

@implementation ViewController

#define kReuseIdentifier @"WaterfallLayoutIdentifier"

//------------------------------------------------------------------------------
- (CGRect)kFrame
//------------------------------------------------------------------------------
{
    if (mIsPortrait) {
        
        return CGRectMake( 0, 0, 768, 1024);
        
    } else {
        
        return CGRectMake( 0, 0, 1024, 768 );
        
    }
}

//------------------------------------------------------------------------------
- (void)loadView
//------------------------------------------------------------------------------
{
    mIsPortrait= [self isPortrait:self.interfaceOrientation];
    self.view= [[UIView alloc] initWithFrame:[self kFrame]];
}

//------------------------------------------------------------------------------
- (id)init
//------------------------------------------------------------------------------
{
    if (!(self=[super init]))
        return nil;
    
    return self;
}

//------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//------------------------------------------------------------------------------
{
    [super viewDidAppear:animated];
    
    UIAlertView *alertView= [[UIAlertView alloc] initWithTitle:nil message:@"Select column count"  delegate:self cancelButtonTitle:@"8 Columns" otherButtonTitles:@"12 columns", nil];
    [alertView show];
}

//------------------------------------------------------------------------------
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//------------------------------------------------------------------------------
{
    if (buttonIndex==0) {

        [self layout8ColumnView];
        
    } else {

        [self layout12ColumnView];
        
    }
}

//------------------------------------------------------------------------------
- (void)layout12ColumnView
//------------------------------------------------------------------------------
{
    NSMutableArray *sizeList= [[NSMutableArray alloc] init];
    
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 6 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 6 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 6 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 12, 8 )]];
    
    for (int i=0;i<2;i++)
        [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 6, 6 )]];
    
    for (int i=0;i<3;i++)
        [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
    
    for (int i=0;i<4;i++)
        [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 3, 3 )]];
    
    for (int i=0;i<6;i++)
        [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 2, 2 )]];
    
    for (int i=0;i<12;i++)
        [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 1, 1 )]];
    
    mWaterfallLayout= [[WaterfallLayout alloc] initWithSizeList:sizeList numColumns:12 isPortrait:mIsPortrait];
    
    mCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:mWaterfallLayout];
    [mCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReuseIdentifier];
    mCollectionView.alwaysBounceVertical = YES;
    
    mCollectionView.delegate = self;
    mCollectionView.dataSource = self;
    mCollectionView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:mCollectionView];
}

//------------------------------------------------------------------------------
- (void)layout8ColumnView
//------------------------------------------------------------------------------
{
    NSMutableArray *sizeList= [[NSMutableArray alloc] init];
    
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 6 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 6 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 8, 4 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 2, 2 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 2, 2 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 2, 2 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 2, 2 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 1, 1 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 1, 1 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 1, 1 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 1, 1 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 1, 1 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 1, 1 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 1, 1 )]];
    [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 1, 1 )]];
    
    mWaterfallLayout= [[WaterfallLayout alloc] initWithSizeList:sizeList numColumns:8 isPortrait:mIsPortrait];
    
    mCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:mWaterfallLayout];
    [mCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReuseIdentifier];
    mCollectionView.alwaysBounceVertical = YES;
    
    mCollectionView.delegate = self;
    mCollectionView.dataSource = self;
    mCollectionView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:mCollectionView];
}

#pragma mark - UICollectionViewDataSource methods

//------------------------------------------------------------------------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//------------------------------------------------------------------------------
{
    return [mWaterfallLayout.frameList count];
}

//------------------------------------------------------------------------------
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//------------------------------------------------------------------------------
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    cell.frame= [mWaterfallLayout.frameList[indexPath.row] CGRectValue];
    
    cell.contentView.backgroundColor= [UIColor whiteColor];
    cell.contentView.layer.borderColor= [[UIColor lightGrayColor] CGColor];
    cell.contentView.layer.borderWidth= 1;
    
    UILabel *label= (UILabel *)[cell.contentView viewWithTag:1];
    
    if (!label) {
        label= [[UILabel alloc] initWithFrame:cell.contentView.bounds];
        label.tag= 1;
        label.textAlignment= NSTextAlignmentCenter;
        label.font= [UIFont systemFontOfSize:20];
        label.numberOfLines= 2;
        [cell.contentView addSubview:label];
    }
    
    float cellSize= (mIsPortrait)?mWaterfallLayout.portraitCellSize:mWaterfallLayout.landscapeCellSize;
    
    label.frame= cell.contentView.bounds;
    label.text= [NSString stringWithFormat:@"(%d)\n%d x %d", (int)indexPath.row, (int)(cell.frame.size.width/cellSize), (int)(cell.frame.size.height/cellSize)];
    
    return cell;
}

//------------------------------------------------------------------------------
- (BOOL)isPortrait:(int)orientation
//------------------------------------------------------------------------------
{
    BOOL isPortrait= YES;
    
    switch (orientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            isPortrait= YES;
            break;
        case UIDeviceOrientationLandscapeRight:
        case UIDeviceOrientationLandscapeLeft:
            isPortrait= NO;
            break;
        default:
            break;
    }
    
    return isPortrait;
}

//------------------------------------------------------------------------------
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//------------------------------------------------------------------------------
{
    mIsPortrait= [self isPortrait:toInterfaceOrientation];
    
    self.view.frame= [self kFrame];
    
    mCollectionView.frame= [self kFrame];
    
    [mCollectionView reloadData];
}

@end
