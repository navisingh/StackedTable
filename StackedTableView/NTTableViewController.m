//
//  NTTableViewController.m
//  CollapsibleTableView
//
//  Created by Navi Singh on 1/20/13.
//  Copyright (c) 2013 Navi Singh. All rights reserved.
//

#import "NTTableViewController.h"
#import "NTTableView.h"
#import "NTTableViewCell.h"

@interface NTTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NTTableView *table;
@end

@implementation NTTableViewController

//#define ROTATE 1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.wantsFullScreenLayout = YES;
        
        CGRect frame = self.view.frame;
        NSLog(@"frame: %f, %f, %f, %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        self.view.backgroundColor  = [UIColor redColor];
        
        frame = UIEdgeInsetsInsetRect(frame,UIEdgeInsetsMake(0, 0, 20, 0));
        self.table = [[NTTableView alloc] initWithFrame:frame];
        
        //all this is doing is making a call to Core Graphic’s API in order to
        //rotate our view 90 degrees counter clockwise.
#ifdef ROTATE
        self.table.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
        //and now we need to give the new frame after tranformation.
        self.table.frame = self.view.frame;
#endif
        //we do not want to show a separator
        [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        //We change paging behavior so that the scrolling always shows a full page.
        self.table.pagingEnabled = YES;
        
        //And of course, we will handle the delegate/datasource.
        self.table.delegate = self;
        self.table.dataSource = self;
        
        //Finally, add our table to the view.
        [self.view addSubview:self.table];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //simply show some pages.
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return NTTableViewCell.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"cell";
    NTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NTTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier
                frameWidth:self.view.frame.size.width];
#ifdef ROTATE
        //Finally we just rotate the cell 90 degrees clockwise by using M_PI * 0.5.
        //If you find this a bit off then let’s remember a few things, these cells
        //will be inside the rotated table view so if we just pass them in as they
        //are, we will see them rotated 90 degrees counter clockwise.
        cell.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
#endif
    }
    
    //http://stackoverflow.com/questions/14039139/how-to-set-ios-uitableview-loop-scroll
    //https://github.com/bharath2020/UITableViewTricks/blob/master/CircleView/BBTableView/BBTableView.m
    //Loop through pages.
    
    cell.textLabel.text = [NSString stringWithFormat:@"row %d", indexPath.row];
    
    return cell;
}


@end
