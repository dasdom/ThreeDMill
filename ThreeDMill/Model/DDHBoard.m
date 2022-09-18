//  Created by Dominik Hauser on 02.09.22.
//  
//

#import "DDHBoard.h"
#import "DDHPole.h"
#import "DDHSphere.h"
#import "DDHMill.h"
#import "DDHBoardChecker.h"
#import "DDHCheckResult.h"

@interface DDHBoard ()
@property (nonatomic, readwrite) NSArray<NSArray<DDHPole *> *> *poles;
@property (nonatomic, readwrite) NSArray<DDHMill *> *knownMills;
@end

@implementation DDHBoard

- (instancetype)init {
    if (self = [super init]) {

        _currentPlayer = [DDHPlayer whitePlayer];
        _mode = DDHBoardModeAddSpheres;

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
    return self;
}

- (void)updatePolesFromBoard:(DDHBoard *)otherBoard {
    self.poles = [otherBoard.poles copy];
    self.knownMills = [otherBoard.knownMills copy];
}

- (BOOL)addSphere:(DDHSphere *)sphere column:(int)column row:(int)row {
    if (NO == [self canAddSphereAtColumn:column row:row]) {
        return NO;
    }

    DDHPole *pole = [self poleAtColumn:column row:row];
    [pole addSphere:sphere];
    return true;
}

- (BOOL)canAddSphereAtColumn:(int)column row:(int)row {
    DDHPole *pole = [self poleAtColumn:column row:row];
    return [pole sphereCount] < numberOfColumns;
}

- (DDHPole *)poleAtColumn:(int)column row:(int)row {
    return self.poles[column][row];
}

- (int)numberOfSpheresAtColumn:(int)column andRow:(int)row {
    return self.poles[column][row].sphereCount;
}

- (DDHMill *)checkForNewMill {
    DDHCheckResult *checkResult = [DDHBoardChecker checkForMatchOnPoles:self.poles knownMills:self.knownMills];

    NSLog(@"checkResult: %@", checkResult);

    self.knownMills = [checkResult knownMills];

    return [checkResult discoveredMill];
}

@end
