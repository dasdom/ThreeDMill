//  Created by Dominik Hauser on 05.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "Position.h"
#import "Sphere.h"

NS_ASSUME_NONNULL_BEGIN

@interface Move : NSObject
@property Position *from;
@property Position *to;
@property DDHSphereColor color;
@end

NS_ASSUME_NONNULL_END
