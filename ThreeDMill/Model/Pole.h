//  Created by Dominik Hauser on 03.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "Sphere.h"

NS_ASSUME_NONNULL_BEGIN

@interface Pole : NSObject
- (int)sphereCount;
- (Sphere *)lastSphereColor;
- (void)addSphere:(Sphere *)sphere;
@end

NS_ASSUME_NONNULL_END
