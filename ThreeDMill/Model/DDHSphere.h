//  Created by Dominik Hauser on 04.09.22.
//  
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDHSphereColor) {
    DDHSphereColorWhite,
    DDHSphereColorRed
};

NS_ASSUME_NONNULL_BEGIN

@interface DDHSphere : NSObject
@property DDHSphereColor colorType;
- (instancetype)initWithColorType:(DDHSphereColor)type;
@end

NS_ASSUME_NONNULL_END
