//
//  SectionHeaderAndFooterView.h
//  collapseTableView
//
//  Created by Gopal Rao Gurram on 1/21/16.
//  Copyright © 2016 Gopal Rao Gurram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandCollapseViewModel.h"

@protocol SectionHeaderAndFooterViewDelegate <NSObject>

@optional

- (void) expandOrCollapseButtonTappedForHeaderOrFooterView:(NSInteger)cellTag;

@end

@interface SectionHeaderAndFooterView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *expandOrCollapseBtn;
@property (weak, nonatomic) IBOutlet UIImageView *expandOrCollapseImgVw;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *expandOrCollapseImgVwHeightConstraint;

@property (weak, nonatomic) id<SectionHeaderAndFooterViewDelegate> sectionHeaderAndFooterViewdelegate;

@end
