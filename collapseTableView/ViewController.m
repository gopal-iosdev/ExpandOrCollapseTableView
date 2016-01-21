//
//  ViewController.m
//  collapseTableView
//
//  Created by Gopal Rao Gurram on 1/15/16.
//  Copyright © 2016 Gopal Rao Gurram. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property BOOL reloadFlag;

@property BOOL initialLoadingFlag;


@property (nonatomic, strong) NSMutableArray *flightInfoTableDataArray;
@property (nonatomic, strong) NSMutableArray *crewDataTableDataArray;
@property (nonatomic, strong) NSMutableArray *flightDetailsTableDataArray;
@property (nonatomic, strong) NSMutableArray *crewMessagesTableDataArray;
@property (nonatomic, strong) NSMutableArray *amenitiesTableDataArray;
@property (nonatomic, strong) NSMutableArray *passengersOfInterestTableDataArray;
@property (nonatomic, strong) NSMutableArray *maintainanceInformationTableDataArray;
@property (nonatomic, strong) NSMutableArray *finalCustCountTableDataArray;

@property BOOL loadData;


@end

@implementation ViewController

static NSString *tableViewCellIdentifier = @"TableViewCell";
static NSString *headerAndFooterCellIdentifier = @"headerAndFooterCell";

static NSString *headerAndFooterViewIdentifier = @"headerAndFooterView";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self registerNibs];
    self.initialLoadingFlag = YES;
//    self.mainTableView.scrollEnabled = NO;
  
    if (!self.loadData)
        [self loadDataIntoArrays];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
//    return 20;
    NSInteger count = 0;
    
    count = [[self returnArrayBasedOnSection:section] count];
    
    return count;
}

#pragma mark UITableView View Header Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [self doHeaderAndFooterViewFor: YES forSection:section];
    return headerView;
}

# pragma mark - UITableView Footer

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    ExpandCollapseViewModel *vm;
    
    if (!self.loadData)
        [self loadDataIntoArrays];
    vm = [self.flightInfoTableDataArray objectAtIndex:section];
//    if (vm.isCellExpanded) {
//        NSLog(@"heightForFooterInSection isCellExpanded For Cell: %@",vm.cellTitle);
//    }
    return vm.isCellExpanded ? vm.cellHeight : 0;
    
//    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [self doHeaderAndFooterViewFor: NO forSection: section];
    
    return footerView;
}

- (UIView *) doHeaderAndFooterViewFor:(BOOL) headerView forSection: (NSInteger)section
{
//    headerAndFooterCell *footerView = [self.mainTableView dequeueReusableCellWithIdentifier:headerAndFooterCellIdentifier];
//    
//    ExpandCollapseViewModel *vm;
//    vm = [self.flightInfoTableDataArray objectAtIndex:section];
//    
//    if (headerView) {
////        footerView.headerAndFooterCellTitleLabel.text = [NSString stringWithFormat:@"Header: %ld",section];
//        footerView.headerAndFooterCellTitleLabel.text = vm.cellTitle;
//        footerView.expandOrCollapseImgVw.image = [UIImage imageNamed:@"Expand"];
////        NSLog(@"viewForHeaderInSection, HEADER: %ld",section);
//    }
//    else
//    {
////        footerView.headerAndFooterCellTitleLabel.text = [NSString stringWithFormat:@"Footer: %ld",section];
//        footerView.headerAndFooterCellTitleLabel.text = vm.cellTitle;
//        footerView.expandOrCollapseImgVw.image = [UIImage imageNamed:@"Collapse"];
////        NSLog(@"viewForFooterInSection, FOOTER: %ld",section);
//    }
//    footerView.tag = section;
//    footerView.expandOrCollapseButton.tag = section;
//    footerView.headerAndFooterCelldelegate = self;
////    NSLog(@"doHeaderAndFooterViewFor, setting Tag: %ld",section);
//    return footerView;//contentView
    
    
    ExpandCollapseViewModel *vm;
    vm = [self.flightInfoTableDataArray objectAtIndex:section];
    headerAndFooterView *headerFooterView = [[[NSBundle mainBundle] loadNibNamed:@"headerAndFooterView" owner:self options:nil] objectAtIndex:0];
    if (headerView) {
        //        footerView.headerAndFooterCellTitleLabel.text = [NSString stringWithFormat:@"Header: %ld",section];
        headerFooterView.headerAndFooterCellTitleLabel.text = vm.cellTitle;
        headerFooterView.expandOrCollapseImgVw.image = [UIImage imageNamed:@"Expand"];
        headerFooterView.expandOrCollapseImgVwHeightConstraint.constant = vm.isCellExpanded ? 0 : 44;
        headerFooterView.expandOrCollapseButton.userInteractionEnabled = vm.isCellExpanded ? NO : YES;
        //        NSLog(@"viewForHeaderInSection, HEADER: %ld",section);
    }
    else
    {
        //        footerView.headerAndFooterCellTitleLabel.text = [NSString stringWithFormat:@"Footer: %ld",section];
        headerFooterView.headerAndFooterCellTitleLabel.text = vm.cellTitle;
        headerFooterView.expandOrCollapseImgVw.image = [UIImage imageNamed:@"Collapse"];
        //        NSLog(@"viewForFooterInSection, FOOTER: %ld",section);
    }
    headerFooterView.tag = section;
    headerFooterView.expandOrCollapseButton.tag = section;
    headerFooterView.headerAndFooterViewdelegate = self;

    //    [nibView setUserInteractionEnabled:YES];
    return headerFooterView;

}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
{
//    NSLog(@"didEndDisplayingHeaderView, header: %ld",section);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
{
//    NSLog(@"didEndDisplayingFooterView, footer: %ld",section);
//    self.mainTableView.scrollEnabled = NO;
//    [self.mainTableViewDelegate mainTableViewScrollViewDidEndScrolling:YES];
//    NSIndexPath *indexPath = [[self.mainTableView indexPathsForVisibleRows] objectAtIndex:([[self.mainTableView indexPathsForVisibleRows] count] - 1)];
//    [self.mainTableView reloadSections:(section + 1) withRowAnimation:UITableViewRowAnimationNone];
    
//    NSLog(@"IndexPaths Count for VisibleRows: %ld",[[self.mainTableView indexPathsForVisibleRows] count]);
//    NSLog(@"didEndDisplayingFooterView, footer: %ld, self.mainTableView.scrollEnabled: %d", section,self.mainTableView.scrollEnabled);
    self.reloadFlag = YES;
    [self.mainTableView reloadRowsAtIndexPaths:[self.mainTableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark UITableView Data Source Methods


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
//    TableViewCell *cell ;
//    
//    cell = [self.mainTableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
//    
//    if (self.reloadFlag)
//    {
//        NSLog(@"cellForRowAtIndexPath, reloadFlag: %d, self.mainTableView.scrollEnabled: %d", self.reloadFlag, self.mainTableView.scrollEnabled);
//        cell.reloadFlag = self.reloadFlag;
//        self.reloadFlag = NO;
//    }
//    
//    if (self.initialLoadingFlag)
//    {
//        cell.initialLoading = YES;
//        self.initialLoadingFlag = NO;
//    }
//    
//    [cell callCellTableView];
//    cell.cellTableViewHeightConstraint.constant = (self.view.frame.size.height - 80);
////    [cell.cellTableView reloadData];
//    
//    cell.cellDelegate = self;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    ExpandCollapseViewModel *vm;
    NSMutableArray *array = [self returnArrayBasedOnSection:indexPath.section];
    vm = [array objectAtIndex:indexPath.row];
    
//    if (vm.isCellExpanded) {
//        NSLog(@"Cell For Row isCellExpanded For Cell: %@",vm.cellTitle);
//    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
//    cell.textLabel.text = [NSString stringWithFormat:@"Section: %ld - Cell: %ld", indexPath.section, (long)indexPath.row];
    
    cell.tag = indexPath.row;
    
    cell.textLabel.text = vm.cellTitle;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    //     self.cellTableView.scrollEnabled = YES;
    
    return cell;
}

#pragma mark UITableView heightForRowAtIndexPath delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

{
//    return self.view.frame.size.height - 88;
//    return 44;
    ExpandCollapseViewModel *vm;
    if (!self.loadData)
        [self loadDataIntoArrays];
    NSMutableArray *array = [self returnArrayBasedOnSection:indexPath.section];
    vm = [array objectAtIndex:indexPath.row];
    return vm.isCellExpanded ? vm.cellHeight : 0;
}

- (void) registerNibs
{
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:tableViewCellIdentifier];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"headerAndFooterCell" bundle:nil] forCellReuseIdentifier:headerAndFooterCellIdentifier];
}

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
    
//    self.mainTableView.scrollEnabled = YES;
//    NSLog(@"mainTableView, updateScrollView");
    if (scrollOffset == 0)
    {
        // then we are at the top
//        NSLog(@"mainTableView, ScrollView Reaches TOP");
//        self.mainTableView.scrollEnabled = NO;
        
    }
    else if ((scrollViewHeight + scrollOffset) >= (scrollContentSizeHeight - 5))
    {
        // then we are at the end
//        NSIndexPath *indexPath = [[self.mainTableView indexPathsForVisibleRows] objectAtIndex:([[self.mainTableView indexPathsForVisibleRows] count] - 1)];
//        NSLog(@"mainTableView, ScrollView Reaches End, row: %ld",indexPath.row);
//        self.mainTableView.scrollEnabled = NO;
    }
    
}

# pragma mark - tableView Cell delegate
- (void) cellScrollViewDidEndScrolling: (BOOL)flag;
{
    self.mainTableView.scrollEnabled = flag;
//    NSLog(@"mainTableView, cellScrollViewDidEndScrolling DELEGATE Method with Flag: %d",flag);
}


# pragma mark - Load data into arrays

- (void) loadDataIntoArrays
{
    self.flightInfoTableDataArray = [[NSMutableArray alloc] init];
    [self loadCrewDataIntoArray];
    [self loadFlightDetailsIntoArray];
    [self loadCrewMessagesIntoArray];
    [self loadAmenitiesIntoArray];
    [self loadPOIIntoArray];
    [self loadMIIntoArray];
    [self loadFinalCustCountIntoArray];
    
    self.loadData = YES;
}

- (void) loadCrewDataIntoArray
{
    ExpandCollapseViewModel *vm;
    CGFloat totalHeightForCrewData = 0;
    self.crewDataTableDataArray = [[NSMutableArray alloc] init];
 
    for (int i = 0; i < 25; i++) {
        vm = [ExpandCollapseViewModel new];
        vm.isCellTypeCell = YES;
        vm.isCellExpanded = NO;
        vm.cellSectionType = Crew_Data;
        vm.cellHeight = 44;
        vm.cellTitle = [NSString stringWithFormat:@"Crew Data Cell: %d",i];
        [self.crewDataTableDataArray addObject:vm];
        totalHeightForCrewData += vm.cellHeight;
    }
    
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"Crew Data";
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Crew_Data;
    vm.cellHeight = 44;
    vm.cellExpandedHeight = totalHeightForCrewData + 44 + 44;// header + footer heights
    [self.flightInfoTableDataArray addObject:vm];
}


- (void) loadFlightDetailsIntoArray
{
    ExpandCollapseViewModel *vm;
    CGFloat totalHeightForFlightDetails = 0;
    self.flightDetailsTableDataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 20; i++) {
        vm = [ExpandCollapseViewModel new];
        vm.isCellTypeCell = YES;
        vm.isCellExpanded = NO;
        vm.cellSectionType = Flight_Details;
        vm.cellHeight = 44;
        vm.cellTitle = [NSString stringWithFormat:@"Flight Details Cell: %d",i];
        [self.flightDetailsTableDataArray addObject:vm];
        totalHeightForFlightDetails += vm.cellHeight;
    }
    
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"Flight Details";
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Flight_Details;
    vm.cellHeight = 44;
    vm.cellExpandedHeight = totalHeightForFlightDetails + 44 + 44;// header + footer heights
    [self.flightInfoTableDataArray addObject:vm];
}


- (void) loadCrewMessagesIntoArray
{
    ExpandCollapseViewModel *vm;
    CGFloat totalHeightForCrewMessages = 0;
    self.crewMessagesTableDataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 20; i++) {
        vm = [ExpandCollapseViewModel new];
        vm.isCellTypeCell = YES;
        vm.isCellExpanded = NO;
        vm.cellSectionType = Crew_Messages_And_PA_Announcements;
        vm.cellHeight = 44;
        vm.cellTitle = [NSString stringWithFormat:@"Crew Messages Cell: %d",i];
        [self.crewMessagesTableDataArray addObject:vm];
        totalHeightForCrewMessages += vm.cellHeight;
    }
    
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"Crew Messages";
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Crew_Messages_And_PA_Announcements;
    vm.cellHeight = 44;
    vm.cellExpandedHeight = totalHeightForCrewMessages + 44 + 44;// header + footer heights
    [self.flightInfoTableDataArray addObject:vm];
}


- (void) loadAmenitiesIntoArray
{
    ExpandCollapseViewModel *vm;
    CGFloat totalHeightForAmenities = 0;
    self.amenitiesTableDataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        vm = [ExpandCollapseViewModel new];
        vm.isCellTypeCell = YES;
        vm.isCellExpanded = NO;
        vm.cellSectionType = Amenities;
        vm.cellHeight = 44;
        vm.cellTitle = [NSString stringWithFormat:@"Amenities Cell: %d",i];
        [self.amenitiesTableDataArray addObject:vm];
        totalHeightForAmenities += vm.cellHeight;
    }
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"Amenities";
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Amenities;
    vm.cellHeight = 44;
    vm.cellExpandedHeight = totalHeightForAmenities + 44 + 44;// header + footer heights
    [self.flightInfoTableDataArray addObject:vm];
}

- (void) loadPOIIntoArray
{
    ExpandCollapseViewModel *vm;
    CGFloat totalHeightForPOI = 0;
    self.passengersOfInterestTableDataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 12; i++) {
        vm = [ExpandCollapseViewModel new];
        vm.isCellTypeCell = YES;
        vm.isCellExpanded = NO;
        vm.cellSectionType = PassengersOfInterest;
        vm.cellHeight = 44;
        vm.cellTitle = [NSString stringWithFormat:@"POI Cell: %d",i];
        [self.passengersOfInterestTableDataArray addObject:vm];
        totalHeightForPOI += vm.cellHeight;
    }
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"POI";
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = PassengersOfInterest;
    vm.cellHeight = 44;
    vm.cellExpandedHeight = totalHeightForPOI + 44 + 44;// header + footer heights
    [self.flightInfoTableDataArray addObject:vm];
}


- (void) loadMIIntoArray
{
    ExpandCollapseViewModel *vm;
    CGFloat totalHeightForMI = 0;
    self.maintainanceInformationTableDataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 7; i++) {
        vm = [ExpandCollapseViewModel new];
        vm.isCellTypeCell = YES;
        vm.isCellExpanded = NO;
        vm.cellSectionType = Maintainance_Information;
        vm.cellHeight = 44;
        vm.cellTitle = [NSString stringWithFormat:@"MI Cell: %d",i];
        [self.maintainanceInformationTableDataArray addObject:vm];
        totalHeightForMI += vm.cellHeight;
    }
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"MI";
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Maintainance_Information;
    vm.cellHeight = 44;
    vm.cellExpandedHeight = totalHeightForMI + 44 + 44;// header + footer heights
    [self.flightInfoTableDataArray addObject:vm];
}


- (void) loadFinalCustCountIntoArray
{
    ExpandCollapseViewModel *vm;
    CGFloat totalHeightForFCC = 0;
    self.finalCustCountTableDataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 23; i++) {
        vm = [ExpandCollapseViewModel new];
        vm.isCellTypeCell = YES;
        vm.isCellExpanded = NO;
        vm.cellSectionType = Final_Customer_Count;
        vm.cellHeight = 44;
        vm.cellTitle = [NSString stringWithFormat:@"FCC Cell: %d",i];
        [self.finalCustCountTableDataArray addObject:vm];
        totalHeightForFCC += vm.cellHeight;
    }
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"FCC";
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Final_Customer_Count;
    vm.cellHeight = 44;
    vm.cellExpandedHeight = totalHeightForFCC + 44 + 44;// header + footer heights
    [self.flightInfoTableDataArray addObject:vm];
}


- (NSMutableArray *) returnArrayBasedOnSection: (NSInteger) section
{
    NSMutableArray *array;
    switch (section) {
        case 0:
            array = self.crewDataTableDataArray;
            break;
        case 1:
            array = self.flightDetailsTableDataArray;
            break;
        case 2:
            array = self.crewMessagesTableDataArray;
            break;
        case 3:
            array = self.amenitiesTableDataArray;
            break;
        case 4:
            array = self.passengersOfInterestTableDataArray;
            break;
        case 5:
            array = self.maintainanceInformationTableDataArray;
            break;
        case 6:
            array = self.finalCustCountTableDataArray;
            break;
            
        default:
            break;
    }
    
    return array;
}

# pragma mark - expand Cell Button Tapped
# pragma mark - Header and Footer Cell Delegate


- (void) expandCellButtonTappedForHeaderCellWithSubView:(NSInteger)cellTag;
{
    NSMutableArray *array = [self returnArrayBasedOnSection:cellTag];
    
    ExpandCollapseViewModel *cellVM = [self.flightInfoTableDataArray objectAtIndex:cellTag];//[cell tag]
    
    cellVM.isCellExpanded = !cellVM.isCellExpanded;
    cellVM.isSectionExpanded = !cellVM.isSectionExpanded;
//    NSLog(@"expandCellButtonTappedForHeaderCellWithSubView with Tag: %ld expandedFlag: %d", cellTag, cellVM.isCellExpanded);
    
    if (cellVM.cellSectionType == Crew_Data) {
         [self setExpandFlagsForSectionType:Crew_Data withSectionDataArray:self.crewDataTableDataArray];
    }
    else if (cellVM.cellSectionType == Flight_Details) {
        [self setExpandFlagsForSectionType:Flight_Details withSectionDataArray:self.flightDetailsTableDataArray];
    }
    else if (cellVM.cellSectionType == Crew_Messages_And_PA_Announcements) {
         [self setExpandFlagsForSectionType:Crew_Messages_And_PA_Announcements withSectionDataArray:self.crewMessagesTableDataArray];
    }
    else if (cellVM.cellSectionType == Amenities) {
        [self setExpandFlagsForSectionType:Amenities withSectionDataArray:self.amenitiesTableDataArray];
    }
    else if (cellVM.cellSectionType == PassengersOfInterest) {
        [self setExpandFlagsForSectionType:PassengersOfInterest withSectionDataArray:self.passengersOfInterestTableDataArray];
    }
    else if (cellVM.cellSectionType == Maintainance_Information) {
        [self setExpandFlagsForSectionType:Maintainance_Information withSectionDataArray:self.maintainanceInformationTableDataArray];
    }
    else if (cellVM.cellSectionType == Final_Customer_Count) {
        [self setExpandFlagsForSectionType:Final_Customer_Count withSectionDataArray:self.finalCustCountTableDataArray];
    }
    
    [UIView beginAnimations:@"cellExpandAnim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationDuration:0.8];
    
    /// use CATransaction so we can capture a CompletionBlock
    //  after the UITableView animation is completed
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^
     {
//         NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellTag inSection:0];//[cell tag]
//         NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
         NSRange range = NSMakeRange(cellTag, 1);
         NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
         NSLog(@"expandCellButtonTappedForHeaderCellWithSubView, Section: %@", section);
         [self.mainTableView beginUpdates];
//         [self.mainTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        [self.mainTableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
         [self.mainTableView endUpdates];
     }];
    
    // finally, do the update on the table - this animates our cell heights
    [self.mainTableView beginUpdates];
    [self.mainTableView endUpdates];
    [CATransaction commit];
    [UIView commitAnimations];
}

#pragma mark - Method For Setting the isCellExpanded to YES for saving the User Defaults

- (void) setExpandFlagsForSectionType : (CellSectionType) cellSectionType withSectionDataArray : (NSMutableArray *) sectionDataArray
{
    ExpandCollapseViewModel *vm;
    for (int i =0; i < sectionDataArray.count; i++) {
        vm = sectionDataArray[i];
        if (vm.cellSectionType == cellSectionType) {
            vm.isCellExpanded = !vm.isCellExpanded;
            if (vm.isCellTypeHeader) {
                break;
            }
        }
    }
}

- (void) expandCellButtonTappedForHeaderView: (NSInteger)cellTag;
{
//    NSLog(@"expandCellButtonTappedForHeaderView with Tag: %ld", cellTag);
    [self expandCellButtonTappedForHeaderCellWithSubView:cellTag];
}

@end
