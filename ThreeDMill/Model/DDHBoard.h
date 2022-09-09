//  Created by Dominik Hauser on 02.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "DDHMove.h"

extern const int numberOfColumns;

typedef NS_ENUM(NSInteger, DDHBoardMode) {
    DDHBoardModeAddSpheres,
    DDHBoardModeShowMill,
    DDHBoardModeRemoveSphere,
    DDHBoardModeMoveSphere,
    DDHBoardModeSurrender,
    DDHBoardModeFinish
};

@class DDHSphere;

NS_ASSUME_NONNULL_BEGIN

@interface DDHBoard : NSObject
@property DDHBoardMode mode;
@property NSArray<DDHMove *> *lastMoves;
- (BOOL)addSphere:(DDHSphere *)sphere column:(int)column row:(int)row;
- (BOOL)canAddSphereAtColumn:(int)column row:(int)row;
- (int)numberOfSpheresAtColumn:(int)column andRow:(int)row;
@end

NS_ASSUME_NONNULL_END
