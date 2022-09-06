//  Created by Dominik Hauser on 06.09.22.
//  
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>

extern const CGFloat startYAboveBoard;

NS_ASSUME_NONNULL_BEGIN

@interface ActionFactory : NSObject
+ (SCNAction *)actionToMoveToNode:(SCNNode *)node;
+ (SCNAction *)actionToMoveToNode:(SCNNode *)node duration:(NSTimeInterval)duration;
+ (SCNAction *)actionToMoveDownToNode:(SCNNode *)node floor:(int)floor;
+ (SCNAction *)actionToMoveDownToNode:(SCNNode *)node floor:(int)floor duration:(NSTimeInterval)duration;
+ (SCNAction *)actionToMoveUpForSphere:(SCNNode *)sphere;
+ (SCNAction *)actionToMoveUpForSphere:(SCNNode *)sphere duration:(NSTimeInterval)duration;
@end

NS_ASSUME_NONNULL_END
