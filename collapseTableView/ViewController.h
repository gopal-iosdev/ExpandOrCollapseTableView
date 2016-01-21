//
//  ViewController.h
//  collapseTableView
//
//  Created by Gopal Rao Gurram on 1/15/16.
//  Copyright © 2016 Gopal Rao Gurram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "headerAndFooterCell.h"
#import "ExpandCollapseViewModel.h"

#import "headerAndFooterView.h"

@protocol MainTableViewDelegate <NSObject>

- (void) mainTableViewScrollViewDidEndScrolling: (BOOL)flag;

@end

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate, HeaderAndFooterCellDelegate, HeaderAndFooterViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (weak, nonatomic) id<MainTableViewDelegate> mainTableViewDelegate;

@end

