//
//  headerAndFooterCell.h
//  collapseTableView
//
//  Created by Gopal Rao Gurram on 1/15/16.
//  Copyright © 2016 Gopal Rao Gurram. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderAndFooterCellDelegate <NSObject>

@optional
//- (void) expandCellButtonTappedForHeaderCellWithSubView:(UITableViewCell *)cell;

- (void) expandCellButtonTappedForHeaderCellWithSubView:(NSInteger)cellTag;

@end


@interface headerAndFooterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *headerAndFooterCellTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *expandOrCollapseButton;
@property (weak, nonatomic) IBOutlet UIImageView *expandOrCollapseImgVw;

@property (weak, nonatomic) id<HeaderAndFooterCellDelegate> headerAndFooterCelldelegate;

@end
