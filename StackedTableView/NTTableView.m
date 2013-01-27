//
//  NTTableView.m
//  StackedTableView
//
//  Created by Navi Singh on 1/26/13.
//  Copyright (c) 2013 Navi Singh. All rights reserved.
//

#import "NTTableView.h"
#import "NTTableViewCell.h"

@implementation NTTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor whiteColor];
        
        //To scroll to the bottom of the table.
        [self setContentOffset:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)layoutSubviews
{
    [super layoutSubviews];
  
    NSArray *visibleCells = [self indexPathsForVisibleRows];
    visibleCells = [visibleCells sortedArrayUsingSelector:@selector(compare:)]; //fwd sort

    int n = 0;
    for (NSIndexPath *ip in [visibleCells reverseObjectEnumerator]) {
        NTTableViewCell *cell = (NTTableViewCell *)[self cellForRowAtIndexPath:ip];
        [self sendSubviewToBack:cell];
        [cell order:n++];
    }
}

@end
