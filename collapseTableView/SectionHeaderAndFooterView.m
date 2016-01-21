//
//  SectionHeaderAndFooterView.m
//  collapseTableView
//
//  Created by Gopal Rao Gurram on 1/21/16.
//  Copyright © 2016 Gopal Rao Gurram. All rights reserved.
//

#import "SectionHeaderAndFooterView.h"

@implementation SectionHeaderAndFooterView
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
////    NSLog(@"SectionHeaderAndFooterView, drawRect For Cell: %@",self.titleLabel.text);
//}

- (IBAction)expandOrCollapseBtnClicked:(UIButton *)sender {
    [self.sectionHeaderAndFooterViewdelegate expandOrCollapseButtonTappedForHeaderOrFooterView:sender.tag];
}


@end
