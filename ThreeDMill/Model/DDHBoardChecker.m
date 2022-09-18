//  Created by Dominik Hauser on 09.09.22.
//  
//

#import "DDHBoardChecker.h"
#import "DDHPole.h"
#import "DDHMill.h"
#import "DDHBoard.h"
#import "DDHCheckResult.h"

@implementation DDHBoardChecker

+ (DDHSphereColor)sphereColorOnPoles:(NSArray<NSArray<DDHPole *> *> *)poles atColumn:(int)column row:(int)row andFloor:(int)floor {

    DDHPole *pole = poles[column][row];
    DDHSphere *sphere = [pole sphereAtFloor:floor];
    return sphere.colorType;
}

+ (DDHSphereColor)sphereColorOnPoles:(NSArray<NSArray<DDHPole *> *> *)poles atColumn:(int)column row:(int)row andFloor:(int)floor whenSameAsColor:(DDHSphereColor)inputColor {

    DDHSphereColor color = [self sphereColorOnPoles:poles atColumn:column row:row andFloor:floor];

    if (inputColor == DDHSphereColorNone || color == inputColor) {
        return color;
    }
    return DDHSphereColorNone;
}

+ (DDHSphereColor)sphereColorOnPoles:(NSArray<NSArray<DDHPole *> *> *)poles atPosition:(DDHPosition *)position whenSameAsColor:(DDHSphereColor)inputColor {

    return [self sphereColorOnPoles:poles atColumn:position.column row:position.row andFloor:position.floor whenSameAsColor:inputColor];
}

+ (DDHCheckResult *)checkForMatchOnPoles:(NSArray<NSArray<DDHPole *> *> *)poles knownMills:(NSArray<DDHMill *> *)knownMills {

    NSMutableArray<DDHMill *> *discoveredMills = [self partialMillsOnPoles:poles];

    [discoveredMills filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DDHMill *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return evaluatedObject.positions.count == countToWin && NO == [knownMills containsObject:evaluatedObject];
    }]];

    knownMills = [knownMills arrayByAddingObjectsFromArray:discoveredMills];

    return [[DDHCheckResult alloc] initWithDiscoveredMill:discoveredMills.firstObject knownMills:knownMills];
}

+ (NSMutableArray<DDHMill *> *)partialMillsOnPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    NSMutableArray<DDHMill *> *discoveredPartialMills = [[NSMutableArray alloc] init];

    [discoveredPartialMills addObjectsFromArray:[self checkForPoleInPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForColumnInPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForRowInPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForFloorDiagonal1InPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForFloorDiagonal2InPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForColumnDiagonal1InPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForColumnDiagonal2InPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForRowDiagonal1InPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForRowDiagonal2InPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForRoomDiagonal1InPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForRoomDiagonal2InPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForRoomDiagonal3InPoles:poles]];
    [discoveredPartialMills addObjectsFromArray:[self checkForRoomDiagonal4InPoles:poles]];

    return discoveredPartialMills;
}

+ (NSArray<NSNumber *> *)runCountsOnPoles:(NSArray<NSArray<DDHPole *> *> *)poles forPlayerWithColor:(DDHSphereColor)color {

    NSMutableArray<NSNumber *> *counts = [[NSMutableArray alloc] init];
    NSArray<DDHMill *> *discoveredMills = [self partialMillsOnPoles:poles];

    [discoveredMills enumerateObjectsUsingBlock:^(DDHMill * _Nonnull partialMill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (partialMill.color == color) {
            [counts addObject:@(partialMill.positions.count)];
        }
    }];

    return [counts copy];
}

+ (NSArray<DDHMill *> *)checkForPoleInPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    NSMutableArray<DDHMill *> *allResults = [[NSMutableArray alloc] init];

    for (int row = 0; row < numberOfColumns; row++) {
        for (int column = 0; column < numberOfColumns; column++) {

            DDHMill *possibleMill = [[DDHMill alloc] init];
            DDHSphereColor millColor = DDHSphereColorNone;

            for (int floor = 0; floor < numberOfColumns; floor++) {
                DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:floor];
                millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
                if (millColor == DDHSphereColorNone) {
                    if ([possibleMill.positions count] < 2) {
                        possibleMill = nil;
                    }
                    break;
                }
                [possibleMill addPosition:position];
                possibleMill.color = millColor;
            }

            if (possibleMill != nil) {
                [allResults addObject:possibleMill];
            }
        }
    }

    return [allResults copy];
}

+ (NSArray<DDHMill *> *)checkForColumnInPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    NSMutableArray<DDHMill *> *allResults = [[NSMutableArray alloc] init];

    for (int floor = 0; floor < numberOfColumns; floor++) {
        for (int column = 0; column < numberOfColumns; column++) {

            DDHMill *possibleMill = [[DDHMill alloc] init];
            DDHSphereColor millColor = DDHSphereColorNone;

            for (int row = 0; row < numberOfColumns; row++) {
                DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:floor];
                millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
                if (millColor == DDHSphereColorNone) {
                    if ([possibleMill.positions count] == 1) {
                        possibleMill = nil;
                        break;
                    }
                } else {
                    [possibleMill addPosition:position];
                    possibleMill.color = millColor;
                }
            }

            if (possibleMill != nil) {
                [allResults addObject:possibleMill];
            }
        }
    }

    return [allResults copy];
}

+ (NSArray<DDHMill *> *)checkForRowInPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    NSMutableArray<DDHMill *> *allResults = [[NSMutableArray alloc] init];

    for (int floor = 0; floor < numberOfColumns; floor++) {
        for (int row = 0; row < numberOfColumns; row++) {

            DDHMill *possibleMill = [[DDHMill alloc] init];
            DDHSphereColor millColor = DDHSphereColorNone;

            for (int column = 0; column < numberOfColumns; column++) {
                DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:floor];
                millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
                if (millColor == DDHSphereColorNone) {
                    if ([possibleMill.positions count] == 1) {
                        possibleMill = nil;
                        break;
                    }
                } else {
                    [possibleMill addPosition:position];
                    possibleMill.color = millColor;
                }
            }

            if (possibleMill != nil) {
                [allResults addObject:possibleMill];
            }
        }
    }

    return [allResults copy];
}

+ (NSArray<DDHMill *> *)checkForFloorDiagonal1InPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    NSMutableArray<DDHMill *> *allResults = [[NSMutableArray alloc] init];

    for (int floor = 0; floor < numberOfColumns; floor++) {

        DDHMill *possibleMill = [[DDHMill alloc] init];
        DDHSphereColor millColor = DDHSphereColorNone;

        for (int row = 0; row < numberOfColumns; row++) {

            DDHPosition *position = [[DDHPosition alloc] initWithColumn:row row:row andFloor:floor];
            millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
            if (millColor == DDHSphereColorNone) {
                if ([possibleMill.positions count] < 2) {
                        possibleMill = nil;
                    }
                break;
            }
            [possibleMill addPosition:position];
            possibleMill.color = millColor;
        }

        if (possibleMill != nil) {
            [allResults addObject:possibleMill];
        }
    }

    return [allResults copy];
}

+ (NSArray<DDHMill *> *)checkForFloorDiagonal2InPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    NSMutableArray<DDHMill *> *allResults = [[NSMutableArray alloc] init];

    for (int floor = 0; floor < numberOfColumns; floor++) {

        DDHMill *possibleMill = [[DDHMill alloc] init];
        DDHSphereColor millColor = DDHSphereColorNone;

        for (int column = 0; column < numberOfColumns; column++) {

            int row = numberOfColumns - 1 - column;

            DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:floor];
            millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
            if (millColor == DDHSphereColorNone) {
                if ([possibleMill.positions count] < 2) {
                        possibleMill = nil;
                    }
                break;
            }
            [possibleMill addPosition:position];
            possibleMill.color = millColor;
        }

        if (possibleMill != nil) {
            [allResults addObject:possibleMill];
        }
    }

    return [allResults copy];
}

+ (NSArray<DDHMill *> *)checkForColumnDiagonal1InPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    NSMutableArray<DDHMill *> *allResults = [[NSMutableArray alloc] init];

    for (int column = 0; column < numberOfColumns; column++) {

        DDHMill *possibleMill = [[DDHMill alloc] init];
        DDHSphereColor millColor = DDHSphereColorNone;

        for (int row = 0; row < numberOfColumns; row++) {

            DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:row];
            millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
            if (millColor == DDHSphereColorNone) {
                if ([possibleMill.positions count] < 2) {
                        possibleMill = nil;
                    }
                break;
            }
            [possibleMill addPosition:position];
            possibleMill.color = millColor;
        }

        if (possibleMill != nil) {
            [allResults addObject:possibleMill];
        }
    }

    return [allResults copy];
}

+ (NSArray<DDHMill *> *)checkForColumnDiagonal2InPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    NSMutableArray<DDHMill *> *allResults = [[NSMutableArray alloc] init];

    for (int column = 0; column < numberOfColumns; column++) {

        DDHMill *possibleMill = [[DDHMill alloc] init];
        DDHSphereColor millColor = DDHSphereColorNone;

        for (int floor = 0; floor < numberOfColumns; floor++) {

            int row = numberOfColumns - 1 - floor;

            DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:floor];
            millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
            if (millColor == DDHSphereColorNone) {
                if ([possibleMill.positions count] < 2) {
                        possibleMill = nil;
                    }
                break;
            }
            [possibleMill addPosition:position];
            possibleMill.color = millColor;
        }

        if (possibleMill != nil) {
            [allResults addObject:possibleMill];
        }
    }

    return [allResults copy];
}

+ (NSArray<DDHMill *> *)checkForRowDiagonal1InPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    NSMutableArray<DDHMill *> *allResults = [[NSMutableArray alloc] init];

    for (int row = 0; row < numberOfColumns; row++) {

        DDHMill *possibleMill = [[DDHMill alloc] init];
        DDHSphereColor millColor = DDHSphereColorNone;

        for (int column = 0; column < numberOfColumns; column++) {

            DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:column];
            millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
            if (millColor == DDHSphereColorNone) {
                if ([possibleMill.positions count] < 2) {
                        possibleMill = nil;
                    }
                break;
            }
            [possibleMill addPosition:position];
            possibleMill.color = millColor;
        }

        if (possibleMill != nil) {
            [allResults addObject:possibleMill];
        }
    }

    return [allResults copy];
}

+ (NSArray<DDHMill *> *)checkForRowDiagonal2InPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    NSMutableArray<DDHMill *> *allResults = [[NSMutableArray alloc] init];

    for (int row = 0; row < numberOfColumns; row++) {

        DDHMill *possibleMill = [[DDHMill alloc] init];
        DDHSphereColor millColor = DDHSphereColorNone;

        for (int floor = 0; floor < numberOfColumns; floor++) {

            int column = numberOfColumns - 1 - floor;

            DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:floor];
            millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
            if (millColor == DDHSphereColorNone) {
                if ([possibleMill.positions count] < 2) {
                        possibleMill = nil;
                    }
                break;
            }
            [possibleMill addPosition:position];
            possibleMill.color = millColor;

        }

        if (possibleMill != nil) {
            [allResults addObject:possibleMill];
        }
    }

    return [allResults copy];
}

+ (NSArray<DDHMill *> *)checkForRoomDiagonal1InPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    DDHMill *possibleMill = [[DDHMill alloc] init];
    DDHSphereColor millColor = DDHSphereColorNone;

    for (int column = 0; column < numberOfColumns; column++) {

        DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:column andFloor:column];
        millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
        if (millColor == DDHSphereColorNone) {
            if ([possibleMill.positions count] < 2) {
                        possibleMill = nil;
                    }
            break;
        }
        [possibleMill addPosition:position];
        possibleMill.color = millColor;

    }

    if (possibleMill != nil) {
        return @[possibleMill];
    }

    return @[];
}

+ (NSArray<DDHMill *> *)checkForRoomDiagonal2InPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    DDHMill *possibleMill = [[DDHMill alloc] init];
    DDHSphereColor millColor = DDHSphereColorNone;

    for (int column = 0; column < numberOfColumns; column++) {

        int row = numberOfColumns - 1 - column;

        DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:column];
        millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
        if (millColor == DDHSphereColorNone) {
            if ([possibleMill.positions count] < 2) {
                        possibleMill = nil;
                    }
            break;
        }
        [possibleMill addPosition:position];
        possibleMill.color = millColor;

    }

    if (possibleMill != nil) {
        return @[possibleMill];
    }

    return @[];
}

+ (NSArray<DDHMill *> *)checkForRoomDiagonal3InPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    DDHMill *possibleMill = [[DDHMill alloc] init];
    DDHSphereColor millColor = DDHSphereColorNone;

    for (int row = 0; row < numberOfColumns; row++) {

        int column = numberOfColumns - 1 - row;

        DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:row];
        millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
        if (millColor == DDHSphereColorNone) {
            if ([possibleMill.positions count] < 2) {
                        possibleMill = nil;
                    }
            break;
        }
        [possibleMill addPosition:position];
        possibleMill.color = millColor;
    }

    if (possibleMill != nil) {
        return @[possibleMill];
    }

    return @[];
}

+ (NSArray<DDHMill *> *)checkForRoomDiagonal4InPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    DDHMill *possibleMill = [[DDHMill alloc] init];
    DDHSphereColor millColor = DDHSphereColorNone;

    for (int floor = 0; floor < numberOfColumns; floor++) {

        int column = numberOfColumns - 1 - floor;

        DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:column andFloor:floor];
        millColor = [self sphereColorOnPoles:poles atPosition:position whenSameAsColor:millColor];
        if (millColor == DDHSphereColorNone) {
            if ([possibleMill.positions count] < 2) {
                        possibleMill = nil;
                    }
            break;
        }
        [possibleMill addPosition:position];
        possibleMill.color = millColor;
    }

    if (possibleMill != nil) {
        return @[possibleMill];
    }

    return @[];
}

@end
