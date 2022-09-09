//  Created by Dominik Hauser on 02.09.22.
//  
//

#import <SceneKit/SceneKit.h>
#import "DDHSphereNode.h"

struct PoleCoordinate {
    int column;
    int row;
};

NS_ASSUME_NONNULL_BEGIN

@interface GameBaseView : SCNView
- (struct PoleCoordinate)poleForNode:(SCNNode *)node;
- (DDHSphereNode *)removeTopSphereAtColumn:(NSInteger)column row:(NSInteger)row;
- (DDHSphereNode *)insertSphereWithColor:(DDHSphereColor)color;
- (DDHSphereNode *)firstMovingSphereNode;
@end

NS_ASSUME_NONNULL_END
