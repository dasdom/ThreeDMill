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

+ (DDHCheckResult *)checkForMatchOnPoles:(NSArray<NSArray<DDHPole *> *> *)poles knownMills:(NSArray<DDHMill *> *)knownMills {

    NSMutableArray<DDHMill *> *tempMills = [[NSMutableArray alloc] init];
    __block DDHMill *discoveredMill;

    NSArray<DDHMill *> *millsInColumns = [self checkForColumnInPoles:poles];
    [millsInColumns enumerateObjectsUsingBlock:^(DDHMill * _Nonnull mill, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [knownMills containsObject:mill]) {
            discoveredMill = mill;
        }
        [tempMills addObject:mill];
    }];

    return [[DDHCheckResult alloc] initWithDiscoveredMill:discoveredMill knownMills:tempMills];
}

+ (NSArray<DDHMill *> *)checkForColumnInPoles:(NSArray<NSArray<DDHPole *> *> *)poles {

    NSMutableArray<DDHMill *> *allResults = [[NSMutableArray alloc] init];

    for (int floor = 0; floor < numberOfColumns; floor++) {
        for (int column = 0; column < numberOfColumns; column++) {

            DDHMill *possibleMill = [[DDHMill alloc] init];
            DDHSphereColor millColor = DDHSphereColorNone;

            for (int row = 0; row < numberOfColumns; row++) {
                millColor = [self sphereColorOnPoles:poles atColumn:column row:row andFloor:floor whenSameAsColor:millColor];
                if (millColor == DDHSphereColorNone) {
                    possibleMill = nil;
                    break;
                }
                DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:floor];
                [possibleMill addPosition:position];
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
                millColor = [self sphereColorOnPoles:poles atColumn:column row:row andFloor:floor whenSameAsColor:millColor];
                if (millColor == DDHSphereColorNone) {
                    possibleMill = nil;
                    break;
                }
                DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:floor];
                [possibleMill addPosition:position];
            }

            if (possibleMill != nil) {
                [allResults addObject:possibleMill];
            }
        }
    }

    return [allResults copy];
}


@end
