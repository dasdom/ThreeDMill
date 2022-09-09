//  Created by Dominik Hauser on 03.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "DDHSphere.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHPole : NSObject
- (int)sphereCount;
- (DDHSphere *)lastSphereColor;
- (void)addSphere:(DDHSphere *)sphere;
@end

NS_ASSUME_NONNULL_END
