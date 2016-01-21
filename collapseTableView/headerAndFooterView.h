//
//  headerAndFooterView.h
//  collapseTableView
//
//  Created by Gopal Rao Gurram on 1/17/16.
//  Copyright © 2016 Gopal Rao Gurram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandCollapseViewModel.h"

@protocol HeaderAndFooterViewDelegate <NSObject>

@optional

- (void) expandCellButtonTappedForHeaderView:(NSInteger)cellTag;

@end


@interface headerAndFooterView : UITableViewHeaderFooterView


@property (weak, nonatomic) IBOutlet UILabel *headerAndFooterCellTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *expandOrCollapseButton;
@property (weak, nonatomic) IBOutlet UIImageView *expandOrCollapseImgVw;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *expandOrCollapseImgVwHeightConstraint;

@property (weak, nonatomic) id<HeaderAndFooterViewDelegate> headerAndFooterViewdelegate;


- (void) modifyViewWithVM: (BOOL)isCellExpanded;

@end
