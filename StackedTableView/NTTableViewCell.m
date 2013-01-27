//
//  NTTableViewCell.m
//  StackedTableView
//
//  Created by Navi Singh on 1/26/13.
//  Copyright (c) 2013 Navi Singh. All rights reserved.
//

#import "NTTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

//Corner radius properties
#define kDefaultCornerRadius 10.0
#define kShrinkage 5.0f
#define kOverlap 20.0f

//Shadow Properties - Note : Disabling shadows greatly improves performance and fluidity of animations
#define kDefaultShadowEnabled YES
#define kDefaultShadowColor [UIColor blackColor]
#define kDefaultShadowOffset CGSizeMake(0, -5)
#define kDefaultShadowRadius kDefaultCornerRadius
#define kDefaultShadowOpacity 0.60

@interface NTTableViewCell()
@property (nonatomic, assign, readonly) CGFloat width;
@end
@implementation NTTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
         frameWidth:(CGFloat)width
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _width = width;

        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.contentView.backgroundColor = [UIColor yellowColor];
//        self.contentView.layer.masksToBounds = YES;
//        self.contentView.clipsToBounds = YES;
       
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                self.width,
                                self.frame.size.height);
        
#if 0
//        CGRect frame = self.frame;
        CGRect bounds = CGRectMake(0,
                                   0,
                                   width,
                                   self.frame.size.height);
//        bounds = self.bounds;
//        NSLog(@"frame: %f, %f, %f, %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
//        NSLog(@"bounds: %f, %f, %f, %f", bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
        // Create the path (with only the top corners rounded)
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                       byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                             cornerRadii:CGSizeMake(30.0, 30.0)];
        // Create the shape layer and set its path
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = bounds;
        maskLayer.path = maskPath.CGPath;
        self.contentView.layer.mask = maskLayer;
//        self.layer.mask = maskLayer;
#else
        self.layer.cornerRadius = kDefaultCornerRadius;
        self.contentView.layer.cornerRadius = kDefaultCornerRadius;
#endif
        
        
        [self redrawShadow];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) redrawShadow
{
    if (kDefaultShadowEnabled) {
        UIBezierPath *path  =  [UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:kDefaultCornerRadius];
        
        [self.layer setShadowOpacity: kDefaultShadowOpacity];
        [self.layer setShadowOffset: kDefaultShadowOffset];
        [self.layer setShadowRadius: kDefaultShadowRadius];
        [self.layer setShadowColor: [kDefaultShadowColor CGColor]];
        [self.layer setShadowPath: [path CGPath]];
    }
}

-(void) order:(int)n
{
    self.frame = CGRectMake(n * kShrinkage,
                            self.frame.origin.y,
                            self.width - n * kShrinkage * 2,
                            self.class.height + (n ? kOverlap : 0));
    [self redrawShadow];
}

+(CGFloat) height
{
    return 100.0f;
}

@end
