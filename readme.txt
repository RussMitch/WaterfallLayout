//
//  WaterfallLayout.h
//
//  Created by Russell on 6/22/14.
//  Copyright (c) 2014 Russell Research Corporation. All rights reserved.
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
