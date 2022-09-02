//  Created by Dominik Hauser on 02.09.22.
//  
//

#import <SceneKit/SceneKit.h>

typedef NS_ENUM(NSInteger, DDHSphereColor) {
    DDHSphereColorWhite,
    DDHSphereColorRed
};

NS_ASSUME_NONNULL_BEGIN

@interface Sphere : SCNNode
@property DDHSphereColor color;
@property BOOL moving;
+ (instancetype)standardSphere:(DDHSphereColor)color;
@end

NS_ASSUME_NONNULL_END
