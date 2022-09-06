//  Created by Dominik Hauser on 06.09.22.
//  
//

#import "ActionFactory.h"

const CGFloat startYAboveBoard = 25.0;

@implementation ActionFactory

+ (SCNAction *)actionToMoveToNode:(SCNNode *)node {
    return [self actionToMoveToNode:node duration:0.3];
}

+ (SCNAction *)actionToMoveToNode:(SCNNode *)node duration:(NSTimeInterval)duration {
    SCNVector3 position = node.position;
    position.y = startYAboveBoard;
    return [SCNAction moveTo:position duration:duration];
}

+ (SCNAction *)actionToMoveDownToNode:(SCNNode *)node floor:(int)floor {
    return [self actionToMoveDownToNode:node floor:floor duration:0.3];
}

+ (SCNAction *)actionToMoveDownToNode:(SCNNode *)node floor:(int)floor duration:(NSTimeInterval)duration {
    SCNVector3 position = node.position;
    position.y = 2.0 + 3.5 * floor;
    return [SCNAction moveTo:position duration:duration];
}

+ (SCNAction *)actionToMoveUpForSphere:(SCNNode *)sphere {
    return [self actionToMoveUpForSphere:sphere duration:0.3];
}

+ (SCNAction *)actionToMoveUpForSphere:(SCNNode *)sphere duration:(NSTimeInterval)duration {
    SCNVector3 position = sphere.position;
    position.y = startYAboveBoard;
    return [SCNAction moveTo:position duration:duration];
}

@end
