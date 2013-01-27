//
//  NTTableViewCell.h
//  StackedTableView
//
//  Created by Navi Singh on 1/26/13.
//  Copyright (c) 2013 Navi Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
         frameWidth:(CGFloat)width;

-(void) order:(int)order;
-(void) redrawShadow;
+(CGFloat) height;
@end
