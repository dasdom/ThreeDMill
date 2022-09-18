//  Created by Dominik Hauser on 13.09.22.
//  
//

#import "DDHBoard+MinmaxStrategy.h"
#import "DDHBoardChecker.h"

@interface DDHBoard ()
@property (nonatomic, readwrite, nullable) NSArray<DDHPlayer *> *players;
@property (nonatomic, readwrite, nullable) DDHPlayer *activePlayer;
@end

@implementation DDHBoard (MinmaxStrategy)

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    DDHBoard *copy = [[[self class] alloc] copyWithZone:zone];
    [copy setGameModel:self];
    return copy;
}

- (void)applyGameModelUpdate:(DDHMove *)gameModelUpdate {
    if (self.mode == DDHBoardModeAddSpheres) {
        DDHSphere *sphereToAdd = [[DDHSphere alloc] initWithColorType:gameModelUpdate.color];
        DDHPosition *to = gameModelUpdate.to;
        [self addSphere:sphereToAdd column:to.column row:to.row];
    }
    self.currentPlayer = self.currentPlayer.opponent;
}

- (nullable NSArray<DDHMove *> *)gameModelUpdatesForPlayer:(DDHPlayer *)player {
    NSMutableArray<DDHMove *> *moves = [NSMutableArray arrayWithCapacity:numberOfColumns * numberOfColumns];
    for (int column = 0; column < numberOfColumns; column++) {
        for (int row = 0; row < numberOfColumns; row++) {
            if (self.mode == DDHBoardModeAddSpheres) {
                if ([self canAddSphereAtColumn:column row:row]) {
                    DDHPosition *to = [[DDHPosition alloc] initWithColumn:column row:row andFloor:-1];
                    [moves addObject:[[DDHMove alloc] initWithTo:to sphereColor:self.currentPlayer.color]];
                }
            } else {
                NSAssert(NO, @"Not implemented yet");
            }
        }
    }

    return moves;
}

- (void)setGameModel:(DDHBoard *)gameModel {
    [self updatePolesFromBoard:gameModel];
    self.currentPlayer = gameModel.currentPlayer;
}

- (BOOL)isWinForPlayer:(DDHPlayer *)player {
    NSArray<NSNumber *> *runCounts = [DDHBoardChecker runCountsOnPoles:self.poles forPlayerWithColor:player.color];

    NSNumber *longestRun = [runCounts valueForKeyPath:@"@max.self"];
    return longestRun.intValue >= countToWin;
}

- (BOOL)isLossForPlayer:(DDHPlayer *)player {
    return [self isWinForPlayer:player.opponent];
}

@end
