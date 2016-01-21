//
//  headerAndFooterCell.m
//  collapseTableView
//
//  Created by Gopal Rao Gurram on 1/15/16.
//  Copyright © 2016 Gopal Rao Gurram. All rights reserved.
//

#import "headerAndFooterCell.h"

@implementation headerAndFooterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)expandOrCollapseBtnClicked:(UIButton *)sender {
//    NSLog(@"headerAndFooterCell, expandOrCollapseBtnClicked with Tag: %ld",sender.tag);
    [self.headerAndFooterCelldelegate expandCellButtonTappedForHeaderCellWithSubView:sender.tag];
}


@end
