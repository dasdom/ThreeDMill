//  Created by Dominik Hauser on 02.09.22.
//  
//

#import <SceneKit/SceneKit.h>
#import "DDHSphereColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHSphereNode : SCNNode
@property DDHSphereColor color;
@property BOOL moving;
+ (instancetype)sphereWithColor:(DDHSphereColor)color;
@end

NS_ASSUME_NONNULL_END
