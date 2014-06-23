//
//  WaterfallLayout.m
//
//  Copyright (c) 2014, Russell D. Mitchell
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//------------------------------------------------------------------------------

#import "WaterfallLayout.h"

@interface WaterfallLayout () {
    
    float mMaxY;
    float mPortraitScreenWidth;
    float mLandscapeScreenWidth;
    NSMutableArray *mAttributeList;
    NSMutableArray *mPortraitFrameList;
    NSMutableArray *mLandscapeFrameList;
    
}

@end

@implementation WaterfallLayout

//------------------------------------------------------------------------------
- (id)initWithSizeList:(NSMutableArray *)sizeList numColumns:(NSInteger)numColumns isPortrait:(BOOL)isPortrait
//------------------------------------------------------------------------------
{
    if (!(self = [super init]))
        return nil;
    
    // numColumns is the same for both orientations!
    
    self.numColumns= numColumns;

    // compute screen size
    
    CGRect rect= [[UIScreen mainScreen] bounds];
    
    mPortraitScreenWidth= (rect.size.width<rect.size.height)?rect.size.width:rect.size.height;
    mLandscapeScreenWidth= (rect.size.width>rect.size.height)?rect.size.width:rect.size.height;

    // compute cell sizes
    
    self.portraitCellSize= mPortraitScreenWidth / self.numColumns;
    self.landscapeCellSize= mLandscapeScreenWidth / self.numColumns;

    mPortraitFrameList= [[NSMutableArray alloc] init];
    mLandscapeFrameList= [[NSMutableArray alloc] init];

    // create layout frames for portrait mode
    
    [self layoutFramesWithSizes:sizeList isPortrait:YES];
    
    // create layout frames for landscape mode
    
    [self layoutFramesWithSizes:sizeList isPortrait:NO];

    // self.frameList points to the layout of the current orientation
    
    if (isPortrait)
        self.frameList= mPortraitFrameList;
    
    return self;
}

// kX0 contains half the slop created by layouts that do not divide evenly.
// i.e. 1024 / 12 = 85.3, rounding down to 85, 85 * 12 = 1020, which leaves
// a 4 pixel slop.  We divide the slop by 2, and split it between the left
// and right edges, hence for the 12 column layout, xK0 equals 2.

#define kX0 (isPortrait)?((mPortraitScreenWidth-(self.numColumns*self.portraitCellSize))/2):((mLandscapeScreenWidth-(self.numColumns*self.landscapeCellSize))/2)

//------------------------------------------------------------------------------
- (void)layoutFramesWithSizes:(NSArray *)sizeList isPortrait:(BOOL)isPortrait
//------------------------------------------------------------------------------
{
    float x= kX0;
    
    self.frameList= (isPortrait)?mPortraitFrameList:mLandscapeFrameList;
    
    // compute the frame for each widget
    
    for (NSValue *value in sizeList) {
        
        CGSize size= [value CGSizeValue];
        
        float width= size.width;
        float height= size.height;

        if ((width < 1)||(width > self.numColumns)||(height<1))  // toss out illegal sizes
            continue;

        float cellSize= (isPortrait)?self.portraitCellSize:self.landscapeCellSize;
        
        width*= cellSize;
        height*= cellSize;
        
        float xOffset= kX0;
        
        float maxX= (isPortrait)?(mPortraitScreenWidth-xOffset):(mLandscapeScreenWidth-xOffset);

        // if new frame extends beyond the width of the screen, then move to the next row
        
        if ((x+width)>maxX)
            x= kX0;
        
        float y= 0;
        
        CGRect frame= CGRectMake( x, y, width, height );
        
        // starting at the top (y=0), loop through each previously defined frame. If the new frame
        // intesects with a previous frame, then we move this frame below the intersected frame by
        // adjusting the y offset appropriately.  The x offset will remain the same.
        
        for (NSValue *value=[self intersectsWith:frame];value!=nil;value=[self intersectsWith:frame]) {
            CGRect rect= [value CGRectValue];
            y= rect.origin.y + rect.size.height;
            frame= CGRectMake( x, y, width, height );
        }
        
        [self.frameList addObject:[NSValue valueWithCGRect:frame]];
        
        x+= width;
        
        if (x>=maxX) {
            x= kX0;
        }
    }
}

//------------------------------------------------------------------------------
- (NSValue *)intersectsWith:(CGRect)frame
//------------------------------------------------------------------------------
{
    for (NSValue *value in self.frameList) {
        CGRect rect= [value CGRectValue];
        if (CGRectIntersectsRect( rect, frame )) {
            return value;
        }
    }
    return nil;
}

//------------------------------------------------------------------------------
- (void)prepareLayout
//------------------------------------------------------------------------------
{
    [super prepareLayout];
    
    if (![self.collectionView numberOfSections])
        return;
    
    mAttributeList= [[NSMutableArray alloc] init];

    // maxY is used to compute the contentSize of the collectionView
    
    mMaxY= 0;
    
    for (int i= 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attribute= [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        attribute.frame = [self.frameList[i] CGRectValue];
        
        if ((attribute.frame.origin.y + attribute.frame.size.height) > mMaxY)
            mMaxY= attribute.frame.origin.y + attribute.frame.size.height;
        
        [mAttributeList addObject:attribute];
        
    }
}

//------------------------------------------------------------------------------
- (CGSize)collectionViewContentSize
//------------------------------------------------------------------------------
{
    if (![self.collectionView numberOfSections])
        return CGSizeZero;
    
    CGSize contentSize = self.collectionView.bounds.size;
    
    contentSize.height= mMaxY;
    
    return contentSize;
}

//------------------------------------------------------------------------------
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//------------------------------------------------------------------------------
{
    return mAttributeList[indexPath.row];
}

//------------------------------------------------------------------------------
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//------------------------------------------------------------------------------
{
    NSMutableArray *attributes= [[NSMutableArray alloc] init];

    // loop through our attributeList, and if the rect intersects with any frame
    // in the attributeList, then add that to the list of attributes to be returned
    
    for (UICollectionViewLayoutAttributes *attribute in mAttributeList) {
        
        if (CGRectIntersectsRect( rect, attribute.frame )) {
            [attributes addObject:attribute];
        }        
    }
    
    return attributes;
}

//------------------------------------------------------------------------------
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//------------------------------------------------------------------------------
{
    if (CGRectGetWidth( newBounds ) != CGRectGetWidth( self.collectionView.bounds )) {

        // set the frameList pointer to the correct orientation based frame list
        
        if (newBounds.size.width > self.collectionView.frame.size.width) {
            
            self.frameList= mLandscapeFrameList;
            
        } else {
            
            self.frameList= mPortraitFrameList;
            
        }
        
        return YES;
        
    }
    
    return NO;
}

@end
