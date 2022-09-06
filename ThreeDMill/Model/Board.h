//  Created by Dominik Hauser on 02.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "Move.h"

extern const int numberOfColumns;

typedef NS_ENUM(NSInteger, DDHBoardMode) {
    DDHBoardModeAddSpheres,
    DDHBoardModeShowMill,
    DDHBoardModeRemoveSphere,
    DDHBoardModeMoveSphere,
    DDHBoardModeSurrender,
    DDHBoardModeFinish
};

@class Sphere;

NS_ASSUME_NONNULL_BEGIN

@interface Board : NSObject
@property DDHBoardMode mode;
@property NSArray<Move *> *lastMoves;
- (BOOL)addSphere:(Sphere *)sphere column:(int)column row:(int)row;
- (BOOL)canAddSphereAtColumn:(int)column row:(int)row;
- (int)numberOfSpheresAtColumn:(int)column andRow:(int)row;
@end

NS_ASSUME_NONNULL_END
