//  Created by Dominik Hauser on 11.09.22.
//  
//

#import <XCTest/XCTest.h>
#import "DDHBoardChecker.h"
#import "DDHBoard.h"
#import "DDHPole.h"
#import "DDHSphere.h"
#import "DDHCheckResult.h"
#import "DDHMill.h"

@interface DDHBoardCheckerTests : XCTestCase
@property NSArray<NSArray<DDHPole *> *> *poles;
@end

@implementation DDHBoardCheckerTests

- (void)setUp {
    NSMutableArray *poles = [[NSMutableArray alloc] init];
    for (int i = 0; i < numberOfColumns; i++) {
        NSMutableArray<DDHPole *> *column = [[NSMutableArray alloc] init];
        for (int j = 0; j < numberOfColumns; j++) {
            [column addObject:[[DDHPole alloc] init]];
        }
        [poles addObject:column];
    }
    self.poles = poles;
}

- (void)tearDown {
    self.poles = nil;
}

- (void)test_checkForMatchOnPoles_whenMillOnPole1 {
    [self.poles[0][0] addSphere:[self redSphere]];
    [self.poles[0][0] addSphere:[self redSphere]];
    [self.poles[0][0] addSphere:[self redSphere]];
    [self.poles[0][0] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"000.001.002.003,red");
}

- (void)test_checkForMatchOnPoles_whenMillOnPole2 {
    [self.poles[1][2] addSphere:[self redSphere]];
    [self.poles[1][2] addSphere:[self redSphere]];
    [self.poles[1][2] addSphere:[self redSphere]];
    [self.poles[1][2] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"120.121.122.123,red");
}

- (void)test_checkForMatchOnPoles_whenMillInColumn1 {
    [self.poles[0][0] addSphere:[self redSphere]];
    [self.poles[0][1] addSphere:[self redSphere]];
    [self.poles[0][2] addSphere:[self redSphere]];
    [self.poles[0][3] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"000.010.020.030,red");
}

- (void)test_checkForMatchOnPoles_whenMillInColumn2 {
    [self.poles[2][0] addSphere:[self whiteSphere]];
    [self.poles[2][0] addSphere:[self redSphere]];
    [self.poles[2][1] addSphere:[self whiteSphere]];
    [self.poles[2][1] addSphere:[self redSphere]];
    [self.poles[2][2] addSphere:[self whiteSphere]];
    [self.poles[2][2] addSphere:[self redSphere]];
    [self.poles[2][3] addSphere:[self whiteSphere]];
    [self.poles[2][3] addSphere:[self redSphere]];
    NSArray *knownMills = @[[[DDHMill alloc] initWithString:@"200.210.220.230,white"]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:knownMills];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"201.211.221.231,red");
}

- (void)test_checkForMatchOnPoles_whenMillInRow1 {
    [self.poles[0][0] addSphere:[self redSphere]];
    [self.poles[1][0] addSphere:[self redSphere]];
    [self.poles[2][0] addSphere:[self redSphere]];
    [self.poles[3][0] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"000.100.200.300,red");
}

- (void)test_checkForMatchOnPoles_whenMillInRow2 {
    [self.poles[0][2] addSphere:[self whiteSphere]];
    [self.poles[0][2] addSphere:[self redSphere]];
    [self.poles[1][2] addSphere:[self whiteSphere]];
    [self.poles[1][2] addSphere:[self redSphere]];
    [self.poles[2][2] addSphere:[self whiteSphere]];
    [self.poles[2][2] addSphere:[self redSphere]];
    [self.poles[3][2] addSphere:[self whiteSphere]];
    [self.poles[3][2] addSphere:[self redSphere]];
    NSArray *knownMills = @[[[DDHMill alloc] initWithString:@"020.120.220.320,white"]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:knownMills];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"021.121.221.321,red");
    knownMills = [knownMills arrayByAddingObject:[[DDHMill alloc] initWithString:@"021.121.221.321,red"]];
    XCTAssertEqualObjects(checkResult.knownMills, knownMills);
}

- (void)test_checkForMatchOnPoles_whenMillInFloorDiagonal1_1 {
    [self.poles[0][0] addSphere:[self redSphere]];
    [self.poles[1][1] addSphere:[self redSphere]];
    [self.poles[2][2] addSphere:[self redSphere]];
    [self.poles[3][3] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"000.110.220.330,red");
}

- (void)test_checkForMatchOnPoles_whenMillInFloorDiagonal1_2 {
    [self.poles[0][0] addSphere:[self whiteSphere]];
    [self.poles[0][0] addSphere:[self redSphere]];
    [self.poles[1][1] addSphere:[self whiteSphere]];
    [self.poles[1][1] addSphere:[self redSphere]];
    [self.poles[2][2] addSphere:[self whiteSphere]];
    [self.poles[2][2] addSphere:[self redSphere]];
    [self.poles[3][3] addSphere:[self whiteSphere]];
    [self.poles[3][3] addSphere:[self redSphere]];
    NSArray *knownMills = @[[[DDHMill alloc] initWithString:@"000.110.220.330,white"]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:knownMills];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"001.111.221.331,red");
}

- (void)test_checkForMatchOnPoles_whenMillInFloorDiagonal2_1 {
    [self.poles[0][3] addSphere:[self redSphere]];
    [self.poles[1][2] addSphere:[self redSphere]];
    [self.poles[2][1] addSphere:[self redSphere]];
    [self.poles[3][0] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"030.120.210.300,red");
}

- (void)test_checkForMatchOnPoles_whenMillInFloorDiagonal2_2 {
    [self.poles[0][3] addSphere:[self whiteSphere]];
    [self.poles[0][3] addSphere:[self redSphere]];
    [self.poles[1][2] addSphere:[self whiteSphere]];
    [self.poles[1][2] addSphere:[self redSphere]];
    [self.poles[2][1] addSphere:[self whiteSphere]];
    [self.poles[2][1] addSphere:[self redSphere]];
    [self.poles[3][0] addSphere:[self whiteSphere]];
    [self.poles[3][0] addSphere:[self redSphere]];
    NSArray *knownMills = @[[[DDHMill alloc] initWithString:@"030.120.210.300,white"]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:knownMills];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"031.121.211.301,red");
}

- (void)test_checkForMatchOnPoles_whenMillInColumnDiagonal1 {
    [self.poles[0][0] addSphere:[self redSphere]];

    [self.poles[0][1] addSphere:[self whiteSphere]];
    [self.poles[0][1] addSphere:[self redSphere]];

    [self.poles[0][2] addSphere:[self whiteSphere]];
    [self.poles[0][2] addSphere:[self whiteSphere]];
    [self.poles[0][2] addSphere:[self redSphere]];

    [self.poles[0][3] addSphere:[self whiteSphere]];
    [self.poles[0][3] addSphere:[self whiteSphere]];
    [self.poles[0][3] addSphere:[self whiteSphere]];
    [self.poles[0][3] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"000.011.022.033,red");
}

- (void)test_checkForMatchOnPoles_whenMillInColumnDiagonal2 {
    [self.poles[0][3] addSphere:[self redSphere]];

    [self.poles[0][2] addSphere:[self whiteSphere]];
    [self.poles[0][2] addSphere:[self redSphere]];

    [self.poles[0][1] addSphere:[self whiteSphere]];
    [self.poles[0][1] addSphere:[self whiteSphere]];
    [self.poles[0][1] addSphere:[self redSphere]];

    [self.poles[0][0] addSphere:[self whiteSphere]];
    [self.poles[0][0] addSphere:[self whiteSphere]];
    [self.poles[0][0] addSphere:[self whiteSphere]];
    [self.poles[0][0] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"030.021.012.003,red");
}

- (void)test_checkForMatchOnPoles_whenMillInRowDiagonal1 {
    [self.poles[0][0] addSphere:[self redSphere]];

    [self.poles[1][0] addSphere:[self whiteSphere]];
    [self.poles[1][0] addSphere:[self redSphere]];

    [self.poles[2][0] addSphere:[self whiteSphere]];
    [self.poles[2][0] addSphere:[self whiteSphere]];
    [self.poles[2][0] addSphere:[self redSphere]];

    [self.poles[3][0] addSphere:[self whiteSphere]];
    [self.poles[3][0] addSphere:[self whiteSphere]];
    [self.poles[3][0] addSphere:[self whiteSphere]];
    [self.poles[3][0] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"000.101.202.303,red");
}

- (void)test_checkForMatchOnPoles_whenMillInRowDiagonal2 {
    [self.poles[3][0] addSphere:[self redSphere]];

    [self.poles[2][0] addSphere:[self whiteSphere]];
    [self.poles[2][0] addSphere:[self redSphere]];

    [self.poles[1][0] addSphere:[self whiteSphere]];
    [self.poles[1][0] addSphere:[self whiteSphere]];
    [self.poles[1][0] addSphere:[self redSphere]];

    [self.poles[0][0] addSphere:[self whiteSphere]];
    [self.poles[0][0] addSphere:[self whiteSphere]];
    [self.poles[0][0] addSphere:[self whiteSphere]];
    [self.poles[0][0] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"300.201.102.003,red");
}

- (void)test_checkForMatchOnPoles_whenMillInRoomDiagonal1 {
    [self.poles[0][0] addSphere:[self redSphere]];

    [self.poles[1][1] addSphere:[self whiteSphere]];
    [self.poles[1][1] addSphere:[self redSphere]];

    [self.poles[2][2] addSphere:[self whiteSphere]];
    [self.poles[2][2] addSphere:[self whiteSphere]];
    [self.poles[2][2] addSphere:[self redSphere]];

    [self.poles[3][3] addSphere:[self whiteSphere]];
    [self.poles[3][3] addSphere:[self whiteSphere]];
    [self.poles[3][3] addSphere:[self whiteSphere]];
    [self.poles[3][3] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"000.111.222.333,red");
}

- (void)test_checkForMatchOnPoles_whenMillInRoomDiagonal2 {
    [self.poles[0][3] addSphere:[self redSphere]];

    [self.poles[1][2] addSphere:[self whiteSphere]];
    [self.poles[1][2] addSphere:[self redSphere]];

    [self.poles[2][1] addSphere:[self whiteSphere]];
    [self.poles[2][1] addSphere:[self whiteSphere]];
    [self.poles[2][1] addSphere:[self redSphere]];

    [self.poles[3][0] addSphere:[self whiteSphere]];
    [self.poles[3][0] addSphere:[self whiteSphere]];
    [self.poles[3][0] addSphere:[self whiteSphere]];
    [self.poles[3][0] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"030.121.212.303,red");
}

- (void)test_checkForMatchOnPoles_whenMillInRoomDiagonal3 {
    [self.poles[3][0] addSphere:[self redSphere]];

    [self.poles[2][1] addSphere:[self whiteSphere]];
    [self.poles[2][1] addSphere:[self redSphere]];

    [self.poles[1][2] addSphere:[self whiteSphere]];
    [self.poles[1][2] addSphere:[self whiteSphere]];
    [self.poles[1][2] addSphere:[self redSphere]];

    [self.poles[0][3] addSphere:[self whiteSphere]];
    [self.poles[0][3] addSphere:[self whiteSphere]];
    [self.poles[0][3] addSphere:[self whiteSphere]];
    [self.poles[0][3] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"300.211.122.033,red");
}

- (void)test_checkForMatchOnPoles_whenMillInRoomDiagonal4 {
    [self.poles[3][3] addSphere:[self redSphere]];

    [self.poles[2][2] addSphere:[self whiteSphere]];
    [self.poles[2][2] addSphere:[self redSphere]];

    [self.poles[1][1] addSphere:[self whiteSphere]];
    [self.poles[1][1] addSphere:[self whiteSphere]];
    [self.poles[1][1] addSphere:[self redSphere]];

    [self.poles[0][0] addSphere:[self whiteSphere]];
    [self.poles[0][0] addSphere:[self whiteSphere]];
    [self.poles[0][0] addSphere:[self whiteSphere]];
    [self.poles[0][0] addSphere:[self redSphere]];

    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:@[]];

    XCTAssertEqualObjects(checkResult.discoveredMill.description, @"330.221.112.003,red");
}

- (void)test_runCountsOnPoles_whenDifferentColor_twoOnAPole {
    [self.poles[0][0] addSphere:[self redSphere]];
    [self.poles[0][0] addSphere:[self redSphere]];

    NSArray<NSNumber *> *result = [DDHBoardChecker runCountsOnPoles:self.poles forPlayerWithColor:DDHSphereColorWhite];

    XCTAssertEqualObjects(result, @[]);
}

- (void)test_runCountsOnPoles_twoOnAPole_1 {
    [self.poles[0][0] addSphere:[self redSphere]];
    [self.poles[0][0] addSphere:[self redSphere]];

    NSArray<NSNumber *> *result = [DDHBoardChecker runCountsOnPoles:self.poles forPlayerWithColor:DDHSphereColorRed];

    XCTAssertEqualObjects(result, @[@2]);
}

- (void)test_runCountsOnPoles_twoInColumn {
    [self.poles[0][0] addSphere:[self redSphere]];
    [self.poles[0][1] addSphere:[self redSphere]];

    [self.poles[1][0] addSphere:[self whiteSphere]];
    [self.poles[1][1] addSphere:[self whiteSphere]];

    [self.poles[2][0] addSphere:[self redSphere]];
    [self.poles[2][1] addSphere:[self redSphere]];
    [self.poles[2][2] addSphere:[self redSphere]];

    NSArray<NSNumber *> *result = [DDHBoardChecker runCountsOnPoles:self.poles forPlayerWithColor:DDHSphereColorWhite];

    NSArray<NSNumber *> *expected = @[@2];
    XCTAssertEqualObjects(result, expected);
}

- (void)test_runCountsOnPoles_twoAndThreeInColumn {
    [self.poles[0][0] addSphere:[self redSphere]];
    [self.poles[0][1] addSphere:[self redSphere]];

    [self.poles[1][0] addSphere:[self whiteSphere]];
    [self.poles[1][1] addSphere:[self whiteSphere]];

    [self.poles[2][0] addSphere:[self redSphere]];
    [self.poles[2][1] addSphere:[self redSphere]];
    [self.poles[2][2] addSphere:[self redSphere]];

    NSArray<NSNumber *> *result = [DDHBoardChecker runCountsOnPoles:self.poles forPlayerWithColor:DDHSphereColorRed];

    NSArray<NSNumber *> *expected = @[@2, @3];
    XCTAssertEqualObjects(result, expected);
}

- (void)test_runCountsOnPoles_fourInColumn {
    [self.poles[2][0] addSphere:[self redSphere]];
    [self.poles[2][1] addSphere:[self redSphere]];
    [self.poles[2][2] addSphere:[self redSphere]];
    [self.poles[2][3] addSphere:[self redSphere]];

    NSArray<NSNumber *> *result = [DDHBoardChecker runCountsOnPoles:self.poles forPlayerWithColor:DDHSphereColorRed];

    NSArray<NSNumber *> *expected = @[@4];
    XCTAssertEqualObjects(result, expected);
}

- (void)test_runCountsOnPoles_twoInMiddleColumn {
    [self.poles[2][1] addSphere:[self redSphere]];
    [self.poles[2][2] addSphere:[self redSphere]];

    NSArray<NSNumber *> *result = [DDHBoardChecker runCountsOnPoles:self.poles forPlayerWithColor:DDHSphereColorRed];

    NSArray<NSNumber *> *expected = @[@2];
    XCTAssertEqualObjects(result, expected);
}

- (void)test_runCountsOnPoles_twoAtEndOfColumn {
    [self.poles[2][2] addSphere:[self redSphere]];
    [self.poles[2][3] addSphere:[self redSphere]];

    NSArray<NSNumber *> *result = [DDHBoardChecker runCountsOnPoles:self.poles forPlayerWithColor:DDHSphereColorRed];

    NSArray<NSNumber *> *expected = @[@2];
    XCTAssertEqualObjects(result, expected);
}

- (void)test_runCountsOnPoles_twoInMiddleRow {
    [self.poles[1][1] addSphere:[self redSphere]];
    [self.poles[2][1] addSphere:[self redSphere]];

    NSArray<NSNumber *> *result = [DDHBoardChecker runCountsOnPoles:self.poles forPlayerWithColor:DDHSphereColorRed];

    NSArray<NSNumber *> *expected = @[@2];
    XCTAssertEqualObjects(result, expected);
}

- (void)test_runCountsOnPoles_twoAtEndOfRow {
    [self.poles[2][2] addSphere:[self redSphere]];
    [self.poles[3][2] addSphere:[self redSphere]];

    NSArray<NSNumber *> *result = [DDHBoardChecker runCountsOnPoles:self.poles forPlayerWithColor:DDHSphereColorRed];

    NSArray<NSNumber *> *expected = @[@2];
    XCTAssertEqualObjects(result, expected);
}

// MARK: - Helper
- (DDHSphere *)redSphere {
    return [[DDHSphere alloc] initWithColorType:DDHSphereColorRed];
}

- (DDHSphere *)whiteSphere {
    return [[DDHSphere alloc] initWithColorType:DDHSphereColorWhite];
}

@end
