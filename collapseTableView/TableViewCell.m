//
//  TableViewCell.m
//  collapseTableView
//
//  Created by Gopal Rao Gurram on 1/15/16.
//  Copyright © 2016 Gopal Rao Gurram. All rights reserved.
//

#import "TableViewCell.h"
#import "ViewController.h"

@interface TableViewCell()



@end

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) callCellTableView
{
    NSLog(@"TableViewCell, callCellTableView, reloadFlag: %d, initialLoadingFlag: %d", self.reloadFlag, self.initialLoading);
    self.cellTableView.scrollEnabled = NO;
    if (self.reloadFlag || self.initialLoading)
    {
        self.cellTableView.scrollEnabled = YES;
        if (self.initialLoading)
            self.initialLoading = NO;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell: %ld",(long)indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//     self.cellTableView.scrollEnabled = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44.0;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    self.cellTableView.scrollEnabled = YES;
//}

# pragma mark Scroll View Delegate Methods

-(void)scrollViewDidScroll: (UIScrollView*)scrollView
{
//    self.cellTableView.scrollEnabled = YES;
    [self updateScrollView:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    if (!decelerate)
    {
        //        NSLog(@"scrollViewDidEndDragging, visible cells count: %d, Current Visible Cell Title: %@", [[self.ualFlightInfoMainVCTableVw indexPathsForVisibleRows] count], [[self returnCurrentVisibleCellVM] cellTitle]);
//        [self updateScrollView:scrollView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;      // called when scroll view grinds to a halt
{
    //    NSLog(@"scrollViewDidEndDecelerating, visible cells count: %d, Current Visible Cell Title: %@", [[self.ualFlightInfoMainVCTableVw indexPathsForVisibleRows] count], [[self returnCurrentVisibleCellVM] cellTitle]);
//    [self updateScrollView:scrollView];
}

- (void) updateScrollView: (UIScrollView *)scrollView
{
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
//    self.cellTableView.scrollEnabled = YES;
//    NSLog(@"updateScrollView");
    if (scrollOffset == 0)
    {
        // then we are at the top
 //       NSLog(@"ScrollView Reaches TOP");
        self.cellTableView.scrollEnabled = NO;
        [self firecellDelegateMethodWithFlag:YES];
        
    }
    else if ((scrollViewHeight + scrollOffset) >= (scrollContentSizeHeight - 5))
    {
        // then we are at the end
//        NSIndexPath *indexPath = [[self.cellTableView indexPathsForVisibleRows] objectAtIndex:([[self.cellTableView indexPathsForVisibleRows] count] - 1)];
//        NSLog(@"ScrollView Reaches End, row: %ld",indexPath.row);
        self.cellTableView.scrollEnabled = NO;
        [self firecellDelegateMethodWithFlag:YES];
    }
    
}

- (void) firecellDelegateMethodWithFlag: (BOOL) flag
{
    [self.cellDelegate cellScrollViewDidEndScrolling:flag];
}


@end
