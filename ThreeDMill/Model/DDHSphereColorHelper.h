//  Created by Dominik Hauser on 15.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "DDHSphereColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHSphereColorHelper : NSObject
+ (NSString *)stringFromColor:(DDHSphereColor)color;
+ (DDHSphereColor)colorFromString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
