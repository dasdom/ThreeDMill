//  Created by Dominik Hauser on 02.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "DDHMove.h"
#import "DDHPlayer.h"

const static int numberOfColumns = 4;
const static int countToWin = 4;

typedef NS_ENUM(NSInteger, DDHBoardMode) {
    DDHBoardModeAddSpheres,
    DDHBoardModeShowMill,
    DDHBoardModeRemoveSphere,
    DDHBoardModeMoveSphere,
    DDHBoardModeSurrender,
    DDHBoardModeFinish
};

@class DDHSphere;
@class DDHMill;
@class DDHPole;

NS_ASSUME_NONNULL_BEGIN

@interface DDHBoard : NSObject
@property (nonatomic, readonly) NSArray<NSArray<DDHPole *> *> *poles;
@property (nonatomic, readonly) NSArray<DDHMill *> *knownMills;
@property (nonatomic) DDHPlayer *currentPlayer;
@property (nonatomic) DDHBoardMode mode;
//@property (nonatomic) NSArray<DDHMove *> *lastMoves;
- (void)updatePolesFromBoard:(DDHBoard *)otherBoard;
- (BOOL)addSphere:(DDHSphere *)sphere column:(int)column row:(int)row;
- (BOOL)canAddSphereAtColumn:(int)column row:(int)row;
- (int)numberOfSpheresAtColumn:(int)column andRow:(int)row;
- (DDHMill *)checkForNewMill;
- (DDHPole *)poleAtColumn:(int)column row:(int)row;
@end

NS_ASSUME_NONNULL_END
