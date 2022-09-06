//  Created by Dominik Hauser on 02.09.22.
//  
//

#import "Board.h"
#import "Pole.h"
#import "Sphere.h"

const int numberOfColumns = 4;

@interface Board ()
@property NSArray<NSArray<Pole *> *> *poles;
@end

@implementation Board

- (instancetype)init {
    if (self = [super init]) {
        _mode = DDHBoardModeAddSpheres;

        NSMutableArray *poles = [[NSMutableArray alloc] init];
        for (int i = 0; i < numberOfColumns; i++) {
            NSMutableArray<Pole *> *column = [[NSMutableArray alloc] init];
            for (int j = 0; j < numberOfColumns; j++) {
                [column addObject:[[Pole alloc] init]];
            }
            [poles addObject:column];
        }
        self.poles = poles;
    }
    return self;
}

- (BOOL)addSphere:(Sphere *)sphere column:(int)column row:(int)row {
    if (NO == [self canAddSphereAtColumn:column row:row]) {
        return NO;
    }

    Pole *pole = [self poleAtColumn:column row:row];
    [pole addSphere:sphere];
    return true;
}

- (BOOL)canAddSphereAtColumn:(int)column row:(int)row {
    Pole *pole = [self poleAtColumn:column row:row];
    return [pole sphereCount] < numberOfColumns;
}

- (Pole *)poleAtColumn:(int)column row:(int)row {
    return self.poles[column][row];
}

- (int)numberOfSpheresAtColumn:(int)column andRow:(int)row {
    return self.poles[column][row].sphereCount;
}

@end
