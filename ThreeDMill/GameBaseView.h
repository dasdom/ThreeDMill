//  Created by Dominik Hauser on 02.09.22.
//  
//

#import <SceneKit/SceneKit.h>
#import "SphereNode.h"

struct PoleCoordinate {
    int column;
    int row;
};

NS_ASSUME_NONNULL_BEGIN

@interface GameBaseView : SCNView
- (struct PoleCoordinate)poleForNode:(SCNNode *)node;
- (SphereNode *)removeTopSphereAtColumn:(NSInteger)column row:(NSInteger)row;
- (SphereNode *)insertSphereWithColor:(DDHSphereColor)color;
- (SphereNode *)firstMovingSphereNode;
@end

NS_ASSUME_NONNULL_END
