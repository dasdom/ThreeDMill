//  Created by Dominik Hauser on 04.09.22.
//  
//

#import <XCTest/XCTest.h>
#import "Board.h"
#import "Sphere.h"

@interface BoardTests : XCTestCase
@property Board *sut;
@end

@implementation BoardTests

- (void)setUp {
    _sut = [[Board alloc] init];
}

- (void)tearDown {
    _sut = nil;
}

- (void)test_init_shouldSetMode {
    XCTAssertEqual(self.sut.mode, DDHBoardModeAddSpheres);
}

- (void)test_addSphere_returnsYES {
    Sphere *sphere = [[Sphere alloc] initWithColorType:DDHSphereColorWhite];
    int column = 1;
    int row = 2;

    BOOL didAddSphere = [self.sut addSphere:sphere column:column row:row];

    XCTAssertEqual(didAddSphere, YES);
}

- (void)test_canAddSphere_whenPoleIsFull_shouldReturnFalse {
    Sphere *sphere = [[Sphere alloc] initWithColorType:DDHSphereColorWhite];
    int column = 1;
    int row = 2;
    int numberOfSpheres = numberOfColumns;
    for (int i = 0; i < numberOfSpheres; i++) {
        [self.sut addSphere:sphere column:column row:row];
    }

    BOOL canAddSphere = [self.sut canAddSphereAtColumn:column row:row];

    XCTAssertEqual(canAddSphere, NO);
}

- (void)test_canAddSphere_whenPoleHas0Spheres_shouldReturnTrue {
    int column = 1;
    int row = 2;

    BOOL canAddSphere = [self.sut canAddSphereAtColumn:column row:row];

    XCTAssertEqual(canAddSphere, YES);
}

- (void)test_canAddSphere_whenPoleHas3Spheres_shouldReturnTrue {
    Sphere *sphere = [[Sphere alloc] initWithColorType:DDHSphereColorWhite];
    int column = 1;
    int row = 2;
    int numberOfSpheres = numberOfColumns-1;
    for (int i = 0; i < numberOfSpheres; i++) {
        [self.sut addSphere:sphere column:column row:row];
    }

    BOOL canAddSphere = [self.sut canAddSphereAtColumn:column row:row];

    XCTAssertEqual(canAddSphere, YES);
}

@end
