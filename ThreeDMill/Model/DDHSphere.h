//  Created by Dominik Hauser on 04.09.22.
//  
//

#import <UIKit/UIKit.h>
#import "DDHSphereColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHSphere : NSObject
@property DDHSphereColor colorType;
- (instancetype)initWithColorType:(DDHSphereColor)type;
@end

NS_ASSUME_NONNULL_END
