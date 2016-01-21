//
//  ExpandCollapseViewModel.h
//  collapseTableView
//
//  Created by Gopal Rao Gurram on 1/16/16.
//  Copyright © 2016 Gopal Rao Gurram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ExpandCollapseViewModel : NSObject

@property (assign, nonatomic) BOOL isCellTypeDummyHeader;
@property (assign, nonatomic) BOOL isCellTypeCell;
@property (assign, nonatomic) BOOL isCellTypeHeader;//
@property (assign, nonatomic) BOOL isCellTypeHeaderWithSubView;
@property (assign, nonatomic) BOOL isCellExpanded;
@property (assign, nonatomic) BOOL isSectionExpanded;
@property (assign, nonatomic) BOOL isCellTypeDynamic;
@property (assign, nonatomic) BOOL willExpandHeader;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic) CGFloat cellExpandedHeight;

@property (nonatomic, retain) NSString *cellTitle;
@property (nonatomic, retain) NSString *imgTitleForCell;
@property (nonatomic, assign) int cellSectionType;
@property (nonatomic, assign) int itemType; // cell Type
@property (nonatomic, assign) BOOL hasData;

@property (nonatomic, strong) NSArray *sectionDataArray;


typedef enum{
    None,
    Crew_Data,
    Flight_Details,
    Crew_Messages_And_PA_Announcements,
    Amenities,
    PassengersOfInterest,
    Maintainance_Information,
    Final_Customer_Count
}CellSectionType;


@end
