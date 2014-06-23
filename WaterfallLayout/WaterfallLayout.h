//
//  WaterfallLayout.h
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
//
//  The WaterfallLayout class is a concrete layout object that organizes items
//  into a waterfall based grid system.  The grid system is based on a fixed
//  number of columns for both orientations and the width of the associated
//  UICollectionView is assumed to be the full screen width of the device,
//  i.e. 768 or 1024 for the iPad and 320 or 480 for the iPhone. Since the
//  column count is the same, the cell size will change based on the orientation.
//
//  Item width is based on the column count and can be anything between 1..n,
//  where n = column count.
//
//  Item height is also based on column count, amd cam be anthing greater than 1.
//
//  For example, using a 12 column layout, the following example can easily be
//  defined as follows:
//
//  +-----+-----+-----+
//  | 4x4 | 4x6 | 4x4 |
//  |     |     |     |
//  +-----+     +-----+
//  | 4x6 |     | 4x6 |
//  |     +-----+     |
//  |     | 4x4 |     |
//  |     |     |     |
//  +-----+-----+-----+
//
//  NSMutableArray *sizeList= [[NSMutableArray alloc] init];
//
//  [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
//  [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 6 )]];
//  [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
//  [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 6 )]];
//  [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 4 )]];
//  [sizeList addObject:[NSValue valueWithCGSize:CGSizeMake( 4, 6 )]];
//
//  WaterfallLayout *waterfallLayout= [[WaterfallLayout alloc] initWithSizeList:sizeList numColumns:12 isPortrait:YES];
//
//  Note that for the above 12 column layout, the minimum item width for each orientation would be:
//
//  Portrait  : 768 / 12 = 64px
//  Landscape : 1024 / 12 = 85.3 or 85px (rounding down)
//
//  Therefore, for the first 4x4 item in the example, the computed frame would be:
//
//  Portrait  : CGRectMake( 0, 0, 4*64, 4*64 )
//  Landscape : CGRectMake( 0, 0, 4*85, 4*85 )
//
//  Note also that if the screen width does not divide evenly, as in the the
//  example above for landscape mode, then the 'slop' will be split between the
//  left and right edges of the view.  For example since 85 * 12 = 1020, there is
//  a 4 pixel slop, therefore the layout will skip the first two pixels and the
//  last two, i.e. x=2 for the first item, instead of x=0.
//------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

@interface WaterfallLayout : UICollectionViewLayout

//------------------------------------------------------------------------------
- (id)initWithSizeList:(NSMutableArray *)sizeList numColumns:(NSInteger)numColumns isPortrait:(BOOL)isPortrait;
//------------------------------------------------------------------------------
// sizeList   : array of CGSize values which define the size of each item, in terms of columns
// numColumns : number of columns for this layout
// isPortrait : initial device orientation
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
@property NSInteger numColumns;
//------------------------------------------------------------------------------
// numColumns : number of columns for this layout
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
@property( nonatomic, strong ) NSMutableArray *frameList;
//------------------------------------------------------------------------------
// frameList : contains the actual computed frames for each item based on the current orientation.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
@property NSInteger portraitCellSize;
//------------------------------------------------------------------------------
// portraitCellSize : portraitScreenWidth / numColumns
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
@property NSInteger landscapeCellSize;
//------------------------------------------------------------------------------
// landscapeCellSize : landscapeScreenWidth / numColumns
//------------------------------------------------------------------------------

@end
