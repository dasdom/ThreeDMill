//  Created by Dominik Hauser on 05.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "DDHPosition.h"
#import "DDHSphere.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHMove : NSObject
@property DDHPosition *from;
@property DDHPosition *to;
@property DDHSphereColor color;
@end

NS_ASSUME_NONNULL_END
