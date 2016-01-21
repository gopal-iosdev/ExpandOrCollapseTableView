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

@property BOOL expandFooterViewFlag;

@property ExpandCollapseViewModel *currentExpandOrCollapseCellVM;


@end

@implementation ViewController

static NSString *tableViewCellIdentifier = @"TableViewCell";
static NSString *headerAndFooterCellIdentifier = @"headerAndFooterCell";
static NSString *headerAndFooterViewIdentifier = @"headerAndFooterView";
static NSString *sectionHeaderAndFooterViewIdentifier = @"SectionHeaderAndFooterView";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self registerNibs];
    self.initialLoadingFlag = YES;
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
    ExpandCollapseViewModel *vm;
    vm = [self.flightInfoTableDataArray objectAtIndex:section];
    return vm.isCellExpanded ? [[self returnArrayBasedOnSection:section] count] : 0;
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
    vm = [self.flightInfoTableDataArray objectAtIndex:section];
//    if (vm.isCellExpanded) {
//        NSLog(@"heightForFooterInSection %ld For Cell: %@", section, vm.cellTitle);
//    }
    return vm.isCellExpanded ? vm.cellHeight : 0;//FLT_MIN
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [self doHeaderAndFooterViewFor: NO forSection: section];
    return footerView;
}


//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//{
//    ExpandCollapseViewModel *vm;
//    vm = [self.flightInfoTableDataArray objectAtIndex:section];
//    NSLog(@"didEndDisplayingHeaderView %@ For Section: %ld", vm.cellTitle, section);
//}
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//{
//    ExpandCollapseViewModel *vm;
//    vm = [self.flightInfoTableDataArray objectAtIndex:section];
//    NSLog(@"didEndDisplayingFooterView %@ For Section: %ld", vm.cellTitle, section);
//}

- (UIView *) doHeaderAndFooterViewFor:(BOOL) headerView forSection: (NSInteger)section
{
    ExpandCollapseViewModel *vm;
    vm = [self.flightInfoTableDataArray objectAtIndex:section];
//    headerAndFooterView *headerFooterView = [[[NSBundle mainBundle] loadNibNamed:@"headerAndFooterView" owner:self options:nil] objectAtIndex:0];
//    headerAndFooterView *headerFooterView = (headerAndFooterView *)[self.mainTableView dequeueReusableHeaderFooterViewWithIdentifier:headerAndFooterViewIdentifier];
//    
//    if (headerView) {
//        headerFooterView.headerAndFooterCellTitleLabel.text = [NSString stringWithFormat:@"%@ Header", vm.cellTitle];;
//        headerFooterView.expandOrCollapseImgVw.image = [UIImage imageNamed:@"Expand"];
//        headerFooterView.expandOrCollapseImgVwHeightConstraint.constant = vm.isCellExpanded ? 0 : 44;
//        headerFooterView.expandOrCollapseButton.userInteractionEnabled = vm.isCellExpanded ? NO : YES;
//    }
//    else
//    {
//        headerFooterView.headerAndFooterCellTitleLabel.text = [NSString stringWithFormat:@"%@ Footer", vm.cellTitle];
//        headerFooterView.expandOrCollapseImgVw.image = [UIImage imageNamed:@"Collapse"];
//        NSLog(@"viewForFooterInSection, FOOTER: %ld",section);
//        if (self.expandFooterViewFlag) {
//            self.expandFooterViewFlag = NO;
//        }
//    }
//    headerFooterView.tag = section;
//    headerFooterView.expandOrCollapseButton.tag = section;
//    headerFooterView.headerAndFooterViewdelegate = self;
//    return headerFooterView;
    
    SectionHeaderAndFooterView *sectionheaderAndFooterView = [self.mainTableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderAndFooterViewIdentifier];
    
    if (headerView) {
        sectionheaderAndFooterView.titleLabel.text = [NSString stringWithFormat:@"%@ Header", vm.cellTitle];;
        sectionheaderAndFooterView.expandOrCollapseImgVw.image = [UIImage imageNamed:@"Expand"];
//        sectionheaderAndFooterView.expandOrCollapseImgVwHeightConstraint.constant = vm.isCellExpanded ? 0 : 44;
//        sectionheaderAndFooterView.expandOrCollapseBtn.userInteractionEnabled = vm.isCellExpanded ? NO : YES;
    }
    else
    {
        sectionheaderAndFooterView.titleLabel.text = [NSString stringWithFormat:@"%@ Footer", vm.cellTitle];
        sectionheaderAndFooterView.expandOrCollapseImgVw.image = [UIImage imageNamed:@"Collapse"];
//        NSLog(@"viewForFooterInSection, FOOTER: %ld",section);
    }
    sectionheaderAndFooterView.tag = section;
    sectionheaderAndFooterView.expandOrCollapseBtn.tag = section;
    sectionheaderAndFooterView.sectionHeaderAndFooterViewdelegate = self;
    return sectionheaderAndFooterView;
}


#pragma mark UITableView Data Source Methods


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    ExpandCollapseViewModel *vm;
    NSMutableArray *array = [self returnArrayBasedOnSection:indexPath.section];
    vm = [array objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.tag = indexPath.row;
    cell.textLabel.text = vm.cellTitle;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark UITableView heightForRowAtIndexPath delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    ExpandCollapseViewModel *vm;
    NSMutableArray *array = [self returnArrayBasedOnSection:indexPath.section];
    vm = [array objectAtIndex:indexPath.row];
    return vm.isCellExpanded ? vm.cellHeight : 0;
}

- (void) registerNibs
{
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:tableViewCellIdentifier];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"headerAndFooterCell" bundle:nil] forCellReuseIdentifier:headerAndFooterCellIdentifier];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"headerAndFooterView" bundle:nil] forHeaderFooterViewReuseIdentifier:headerAndFooterViewIdentifier];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SectionHeaderAndFooterView" bundle:nil] forHeaderFooterViewReuseIdentifier:sectionHeaderAndFooterViewIdentifier];
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
        vm.cellTitle = [NSString stringWithFormat:@"Section 0 Cell: %d",i];//Crew Data
        [self.crewDataTableDataArray addObject:vm];
        totalHeightForCrewData += vm.cellHeight;
    }
    
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"Section 0";//@"Crew Data"
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Crew_Data;
    vm.cellHeight = 44;
    vm.sectionDataArray = [self.crewDataTableDataArray mutableCopy];
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
        vm.cellTitle = [NSString stringWithFormat:@"Section 1 Cell: %d",i];//Flight Details
        [self.flightDetailsTableDataArray addObject:vm];
        totalHeightForFlightDetails += vm.cellHeight;
    }
    
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"Section 1";//@"Flight Details"
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Flight_Details;
    vm.cellHeight = 44;
    vm.sectionDataArray = [self.flightDetailsTableDataArray mutableCopy];
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
        vm.cellTitle = [NSString stringWithFormat:@"Section 2 Cell: %d",i];//Crew Messages
        [self.crewMessagesTableDataArray addObject:vm];
        totalHeightForCrewMessages += vm.cellHeight;
    }
    
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"Section 2";//@"Crew Messages"
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Crew_Messages_And_PA_Announcements;
    vm.cellHeight = 44;
    vm.sectionDataArray = [self.crewMessagesTableDataArray mutableCopy];
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
        vm.cellTitle = [NSString stringWithFormat:@"Section 3 Cell: %d",i];
        [self.amenitiesTableDataArray addObject:vm];
        totalHeightForAmenities += vm.cellHeight;
    }
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"Section 3";
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Amenities;
    vm.cellHeight = 44;
    vm.sectionDataArray = [self.amenitiesTableDataArray mutableCopy];
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
        vm.cellTitle = [NSString stringWithFormat:@"Section 4 Cell: %d",i];
        [self.passengersOfInterestTableDataArray addObject:vm];
        totalHeightForPOI += vm.cellHeight;
    }
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"Section 4";
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = PassengersOfInterest;
    vm.cellHeight = 44;
    vm.sectionDataArray = [self.passengersOfInterestTableDataArray mutableCopy];
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
        vm.cellTitle = [NSString stringWithFormat:@"Section 5 Cell: %d",i];
        [self.maintainanceInformationTableDataArray addObject:vm];
        totalHeightForMI += vm.cellHeight;
    }
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"Section 5";
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Maintainance_Information;
    vm.cellHeight = 44;
    vm.sectionDataArray = [self.maintainanceInformationTableDataArray mutableCopy];
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
        vm.cellTitle = [NSString stringWithFormat:@"Section 6 Cell: %d",i];
        [self.finalCustCountTableDataArray addObject:vm];
        totalHeightForFCC += vm.cellHeight;
    }
    vm = [ExpandCollapseViewModel new];
    vm.cellTitle = @"Section 6";
    vm.isCellTypeHeaderWithSubView = YES;
    vm.isCellExpanded = NO;
    vm.isSectionExpanded = NO;
    vm.cellSectionType = Final_Customer_Count;
    vm.cellHeight = 44;
    vm.sectionDataArray = [self.finalCustCountTableDataArray mutableCopy];
    vm.cellExpandedHeight = totalHeightForFCC + 44 + 44;// header + footer heights
    [self.flightInfoTableDataArray addObject:vm];
}


- (NSMutableArray *) returnArrayBasedOnSection: (NSInteger) section
{
    NSMutableArray *array;
    ExpandCollapseViewModel *vm;
    vm = [self.flightInfoTableDataArray objectAtIndex:section];
    array = [vm.sectionDataArray mutableCopy];
    return array;
}

# pragma mark - expand Cell Button Tapped
# pragma mark - Header and Footer Cell Delegate


- (void) expandCellButtonTappedForHeaderCellWithSubView:(NSInteger)cellTag;
{    
    ExpandCollapseViewModel *cellVM = [self.flightInfoTableDataArray objectAtIndex:cellTag];//[cell tag]
    cellVM.isCellExpanded = !cellVM.isCellExpanded;
    cellVM.isSectionExpanded = !cellVM.isSectionExpanded;
    
    self.currentExpandOrCollapseCellVM = cellVM;
    self.expandFooterViewFlag = cellVM.isCellExpanded;
//    NSLog(@"expandCellButtonTappedForHeaderCellWithSubView with Tag: %ld expandedFlag: %d", cellTag, cellVM.isCellExpanded);
    
    [self setExpandFlagsForCellSectionArray:cellVM];
    
//    if (cellVM.cellSectionType == Crew_Data) {
//         [self setExpandFlagsForSectionType:Crew_Data withSectionDataArray:self.crewDataTableDataArray];
//    }
//    else if (cellVM.cellSectionType == Flight_Details) {
//        [self setExpandFlagsForSectionType:Flight_Details withSectionDataArray:self.flightDetailsTableDataArray];
//    }
//    else if (cellVM.cellSectionType == Crew_Messages_And_PA_Announcements) {
//         [self setExpandFlagsForSectionType:Crew_Messages_And_PA_Announcements withSectionDataArray:self.crewMessagesTableDataArray];
//    }
//    else if (cellVM.cellSectionType == Amenities) {
//        [self setExpandFlagsForSectionType:Amenities withSectionDataArray:self.amenitiesTableDataArray];
//    }
//    else if (cellVM.cellSectionType == PassengersOfInterest) {
//        [self setExpandFlagsForSectionType:PassengersOfInterest withSectionDataArray:self.passengersOfInterestTableDataArray];
//    }
//    else if (cellVM.cellSectionType == Maintainance_Information) {
//        [self setExpandFlagsForSectionType:Maintainance_Information withSectionDataArray:self.maintainanceInformationTableDataArray];
//    }
//    else if (cellVM.cellSectionType == Final_Customer_Count) {
//        [self setExpandFlagsForSectionType:Final_Customer_Count withSectionDataArray:self.finalCustCountTableDataArray];
//    }
    
//    [UIView beginAnimations:@"cellExpandAnim" context:nil];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    
//    [UIView setAnimationDuration:0.5];
//    
//    /// use CATransaction so we can capture a CompletionBlock
//    //  after the UITableView animation is completed
//    
//    [CATransaction begin];
//    [CATransaction setCompletionBlock:^
//     {
//         NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellTag inSection:0];//[cell tag]
//         NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
//         NSRange range = NSMakeRange(cellTag, 1);
//         NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
//         NSLog(@"expandCellButtonTappedForHeaderCellWithSubView, Section: %@", section);
////         NSLog(@"expandCellButtonTappedForHeaderCellWithSubView, indexPaths: %@", indexPaths);
////         [self.mainTableView beginUpdates];
//         [self.mainTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
//        [self.mainTableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
////         [self.mainTableView endUpdates];
//     }];
//
//    // finally, do the update on the table - this animates our cell heights
//    [self.mainTableView beginUpdates];
//    [self.mainTableView endUpdates];
//    [CATransaction commit];
//    [UIView commitAnimations];
    
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:cellTag];
//    if (indexPath.row == 0) {
//        //reload specific section animated
//        NSRange range   = NSMakeRange(indexPath.section, 1);
//        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self performSelector:@selector(reloadSectionsWithcellTag:) withObject:sectionToReload afterDelay:0.2];
//    }
    
//    [CATransaction begin];
//    {
//        [CATransaction setAnimationDuration:10];
//        [CATransaction setCompletionBlock:^{
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:cellTag];
//            NSRange range   = NSMakeRange(indexPath.section, 1);
//            NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
//            [self.mainTableView beginUpdates];
//            [self.mainTableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationNone];
//            [self.mainTableView endUpdates];
//        }];
//    }
////    [self.mainTableView beginUpdates];
////    [self.mainTableView endUpdates];
//    [CATransaction commit];
    
//    CATransition *animation = [CATransition animation];
////    [animation setType:nil];
//    [animation setDuration:1.0];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [animation setFillMode:@"extended"];
//    [[self.mainTableView layer] addAnimation:animation forKey:@"reloadAnimation"];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:cellTag];
//    NSRange range   = NSMakeRange(indexPath.section, 1);
//    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
////    [self.mainTableView beginUpdates];
//    [self.mainTableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationNone];
////    [self.mainTableView endUpdates];
    
//    [UIView animateWithDuration:0.8 animations:^{
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:cellTag];
//        NSRange range   = NSMakeRange(indexPath.section, 1);
//        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
//            [self.mainTableView beginUpdates];
//        [self.mainTableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationNone];
//            [self.mainTableView endUpdates];
//    }];
//    [self.mainTableView beginUpdates];
//    [self.mainTableView endUpdates];

//    [CATransaction begin];
//    {
//        [CATransaction setCompletionBlock:^{
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:cellTag];
//            NSRange range   = NSMakeRange(indexPath.section, 1);
//            NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
//            //    [self.mainTableView beginUpdates];
//            [self.mainTableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationNone];
//            //    [self.mainTableView endUpdates];
//        }];
//    }
//    [CATransaction commit];

    UITableViewRowAnimation rowAnimation = UITableViewRowAnimationBottom;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:cellTag];
    NSRange range   = NSMakeRange(indexPath.section, 1);
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.mainTableView beginUpdates];
    [self.mainTableView reloadSections:sectionToReload withRowAnimation:rowAnimation];
//    [self.mainTableView reloadData];
    [self.mainTableView endUpdates];
    
//    NSInteger countOfRowsToInsert = [cellVM.sectionDataArray count];
//    NSMutableArray *indexPathsToInsertOrDelete = [[NSMutableArray alloc] init];
//    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
//        [indexPathsToInsertOrDelete addObject:[NSIndexPath indexPathForRow:i inSection:cellTag]];
//    }
//    
//    UITableViewRowAnimation insertRowAnimation = UITableViewRowAnimationBottom;
//    UITableViewRowAnimation deleteRowAnimation = UITableViewRowAnimationTop;
    
//    [self.mainTableView reloadRowsAtIndexPaths:indexPathsToInsertOrDelete withRowAnimation:insertRowAnimation];
    
//    if (cellVM.isCellExpanded) {
//        [self.mainTableView beginUpdates];
//        [self.mainTableView insertRowsAtIndexPaths:indexPathsToInsertOrDelete withRowAnimation:insertRowAnimation];
//        [self.mainTableView endUpdates];
//    }
//    else
//    {
//        [self.mainTableView beginUpdates];
//        [self.mainTableView deleteRowsAtIndexPaths:indexPathsToInsertOrDelete withRowAnimation:deleteRowAnimation];
//        [self.mainTableView endUpdates];
//    }
    
//    [UIView beginAnimations:@"cellExpandAnim" context:nil];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.5];
//    [CATransaction begin];
//    [CATransaction setCompletionBlock:^
//     {
//         [self.mainTableView beginUpdates];
//         if (cellVM.isCellExpanded)
//             [self.mainTableView insertRowsAtIndexPaths:indexPathsToInsertOrDelete withRowAnimation:UITableViewRowAnimationNone];
//         else
//             [self.mainTableView deleteRowsAtIndexPaths:indexPathsToInsertOrDelete withRowAnimation:UITableViewRowAnimationNone];
//         [self.mainTableView endUpdates];
//     }];
////    [self.mainTableView beginUpdates];
////    [self.mainTableView endUpdates];
//    [CATransaction commit];
//    [UIView commitAnimations];

}

//- (void) reloadSectionsWithcellTag:(NSIndexSet *)sectionToReload
//{
//    
//    [CATransaction begin];
//    [CATransaction setCompletionBlock:^
//     {
//         [self.mainTableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];//
//    }];
//    [CATransaction commit];
//}

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


- (void) setExpandFlagsForCellSectionArray : (ExpandCollapseViewModel *)cellVM
{
    ExpandCollapseViewModel *vm;
    for (int i =0; i < cellVM.sectionDataArray.count; i++) {
        vm = cellVM.sectionDataArray[i];
        if (vm.cellSectionType == cellVM.cellSectionType) {
            vm.isCellExpanded = !vm.isCellExpanded;
            if (vm.isCellTypeHeader) {
                break;
            }
        }
    }
}



- (void) expandCellButtonTappedForHeaderView: (NSInteger)cellTag;
{
    [self expandCellButtonTappedForHeaderCellWithSubView:cellTag];
}

- (void) expandOrCollapseButtonTappedForHeaderOrFooterView:(NSInteger)cellTag;
{
    ExpandCollapseViewModel *cellVM = [self.flightInfoTableDataArray objectAtIndex:cellTag];//[cell tag]
    cellVM.isCellExpanded = !cellVM.isCellExpanded;
    cellVM.isSectionExpanded = !cellVM.isSectionExpanded;
    
    self.currentExpandOrCollapseCellVM = cellVM;
    self.expandFooterViewFlag = cellVM.isCellExpanded;
//    NSLog(@"expandCellButtonTappedForHeaderCellWithSubView with Tag: %ld expandedFlag: %d", cellTag, cellVM.isCellExpanded);
    [self setExpandFlagsForCellSectionArray:cellVM];
    
//    UIView *footerView = [self.mainTableView footerViewForSection:cellTag];
//    NSLog(@"expandOrCollapseButtonTappedForHeaderOrFooterView, BEFORE RELOAD current footer view height for Section: %ld is %f", cellTag, self.mainTableView.sectionFooterHeight);
    
    UITableViewRowAnimation rowAnimation = UITableViewRowAnimationNone;//UITableViewRowAnimationBottom
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:cellTag];
    NSRange range   = NSMakeRange(indexPath.section, 1);
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.mainTableView beginUpdates];
    [self.mainTableView reloadSections:sectionToReload withRowAnimation:rowAnimation];
    [self.mainTableView endUpdates];
    
//    NSLog(@"expandOrCollapseButtonTappedForHeaderOrFooterView, AFTER RELOAD current footer view height for Section: %ld is %f", cellTag, self.mainTableView.sectionFooterHeight);
}



@end
