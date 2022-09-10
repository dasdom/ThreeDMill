//  Created by Dominik Hauser on 02.09.22.
//  
//

#import <SceneKit/SceneKit.h>
#import "DDHSphereNode.h"

struct PoleCoordinate {
    int column;
    int row;
};

@class DDHMill;
@class DDHBoard;

NS_ASSUME_NONNULL_BEGIN

@interface GameBaseView : SCNView
- (struct PoleCoordinate)poleForNode:(SCNNode *)node;
- (DDHSphereNode *)removeTopSphereAtColumn:(NSInteger)column row:(NSInteger)row;
- (DDHSphereNode *)insertSphereWithColor:(DDHSphereColor)color;
- (DDHSphereNode *)firstMovingSphereNode;
- (void)reset;
- (void)fadeAllButSpheresInMill:(DDHMill *)mill toOpacity:(CGFloat)opacity;
//- (void)updateUIWithBoard:(DDHBoard *)board;
- (void)addSphereNode:(DDHSphereNode *)sphereNode toColumn:(int)column andRow:(int)row;
@end

NS_ASSUME_NONNULL_END
