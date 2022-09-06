//  Created by Dominik Hauser on 02.09.22.
//  
//

#import <SceneKit/SceneKit.h>
#import "Sphere.h"

NS_ASSUME_NONNULL_BEGIN

@interface SphereNode : SCNNode
@property DDHSphereColor color;
@property BOOL moving;
+ (instancetype)sphereWithColor:(DDHSphereColor)color;
@end

NS_ASSUME_NONNULL_END
