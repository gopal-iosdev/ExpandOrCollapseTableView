//
//  TableViewCell.h
//  collapseTableView
//
//  Created by Gopal Rao Gurram on 1/15/16.
//  Copyright © 2016 Gopal Rao Gurram. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ViewController.h"

@protocol TableViewCellDelegate <NSObject>

- (void) cellScrollViewDidEndScrolling: (BOOL)flag;

@end

@interface TableViewCell : UITableViewCell<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *cellTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTableViewHeightConstraint;

@property (weak, nonatomic) id<TableViewCellDelegate> cellDelegate;

//@property ViewController *vc;

- (void) callCellTableView;

@property BOOL reloadFlag;
@property BOOL initialLoading;

@end
