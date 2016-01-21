//
//  headerAndFooterView.m
//  collapseTableView
//
//  Created by Gopal Rao Gurram on 1/17/16.
//  Copyright © 2016 Gopal Rao Gurram. All rights reserved.
//

#import "headerAndFooterView.h"

@implementation headerAndFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)expandOrCollapseBtnClicked:(UIButton *)sender {
//        NSLog(@"headerAndFooterCell, expandOrCollapseBtnClicked with Tag: %ld",sender.tag);
    [self.headerAndFooterViewdelegate expandCellButtonTappedForHeaderView:sender.tag];
}


- (void) modifyViewWithVM: (BOOL)isCellExpanded;
{
    self.expandOrCollapseImgVwHeightConstraint.constant = isCellExpanded ? 0 : 44;
    self.expandOrCollapseButton.userInteractionEnabled = isCellExpanded ? NO : YES;
}


@end
