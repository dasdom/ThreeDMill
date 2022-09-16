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

    NSMutableArray<DDHMill *> *tempMills = [[NSMutableArray alloc] init];
    NSMutableArray<DDHMill *> *discoveredMills = [[NSMutableArray alloc] init];

    NSArray<DDHMill *> *millsInPoles = [self checkForPoleInPoles:poles];
    [millsInPoles enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInColumns = [self checkForColumnInPoles:poles];
    [millsInColumns enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInRows = [self checkForRowInPoles:poles];
    [millsInRows enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInFloorDiagonal1 = [self checkForFloorDiagonal1InPoles:poles];
    [millsInFloorDiagonal1 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInFloorDiagonal2 = [self checkForFloorDiagonal2InPoles:poles];
    [millsInFloorDiagonal2 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInColumnDiagonal1 = [self checkForColumnDiagonal1InPoles:poles];
    [millsInColumnDiagonal1 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInColumnDiagonal2 = [self checkForColumnDiagonal2InPoles:poles];
    [millsInColumnDiagonal2 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInRowDiagonal1 = [self checkForRowDiagonal1InPoles:poles];
    [millsInRowDiagonal1 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInRowDiagonal2 = [self checkForRowDiagonal2InPoles:poles];
    [millsInRowDiagonal2 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInRoomDiagonal1 = [self checkForRoomDiagonal1InPoles:poles];
    [millsInRoomDiagonal1 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInRoomDiagonal2 = [self checkForRoomDiagonal2InPoles:poles];
    [millsInRoomDiagonal2 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInRoomDiagonal3 = [self checkForRoomDiagonal3InPoles:poles];
    [millsInRoomDiagonal3 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    NSArray<DDHMill *> *millsInRoomDiagonal4 = [self checkForRoomDiagonal4InPoles:poles];
    [millsInRoomDiagonal4 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredMills addObject:mill];
        }
        [tempMills addObject:mill];
    }];

    [discoveredMills filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DDHMill *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return evaluatedObject.positions.count == 4;
    }]];

    return [[DDHCheckResult alloc] initWithDiscoveredMill:discoveredMills.firstObject knownMills:tempMills];
}

+ (NSArray<DDHMill *> *)partialMillsOnPoles:(NSArray<NSArray<DDHPole *> *> *)poles ignoringMills:(NSArray<DDHMill *> *)knownMills {

    NSMutableArray<DDHMill *> *discoveredPartialMills = [[NSMutableArray alloc] init];

    NSArray<DDHMill *> *millsInPoles = [self checkForPoleInPoles:poles];
    [millsInPoles enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInColumns = [self checkForColumnInPoles:poles];
    [millsInColumns enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInRows = [self checkForRowInPoles:poles];
    [millsInRows enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInFloorDiagonal1 = [self checkForFloorDiagonal1InPoles:poles];
    [millsInFloorDiagonal1 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInFloorDiagonal2 = [self checkForFloorDiagonal2InPoles:poles];
    [millsInFloorDiagonal2 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInColumnDiagonal1 = [self checkForColumnDiagonal1InPoles:poles];
    [millsInColumnDiagonal1 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInColumnDiagonal2 = [self checkForColumnDiagonal2InPoles:poles];
    [millsInColumnDiagonal2 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInRowDiagonal1 = [self checkForRowDiagonal1InPoles:poles];
    [millsInRowDiagonal1 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInRowDiagonal2 = [self checkForRowDiagonal2InPoles:poles];
    [millsInRowDiagonal2 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInRoomDiagonal1 = [self checkForRoomDiagonal1InPoles:poles];
    [millsInRoomDiagonal1 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInRoomDiagonal2 = [self checkForRoomDiagonal2InPoles:poles];
    [millsInRoomDiagonal2 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInRoomDiagonal3 = [self checkForRoomDiagonal3InPoles:poles];
    [millsInRoomDiagonal3 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    NSArray<DDHMill *> *millsInRoomDiagonal4 = [self checkForRoomDiagonal4InPoles:poles];
    [millsInRoomDiagonal4 enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            [discoveredPartialMills addObject:mill];
        }
    }];

    return discoveredPartialMills;
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
