//  Created by Dominik Hauser on 04.09.22.
//  
//

#import "DDHSphere.h"

@implementation DDHSphere

- (instancetype)initWithColorType:(DDHSphereColor)type {
    if (self = [super init]) {
        _colorType = type;
    }
    return self;
}

- (UIColor *)uiColor {
    UIColor *color;
    switch (self.colorType) {
        case DDHSphereColorRed:
            color = [UIColor redColor];
            break;
        case DDHSphereColorWhite:
            color = [UIColor whiteColor];
            break;
        default:
            NSAssert(NO, @"This should never happen.");
            break;
    }
    return color;
}

- (DDHSphere *)oposit {
    DDHSphere *sphere;
    switch (self.colorType) {
        case DDHSphereColorRed:
            sphere = [[DDHSphere alloc] initWithColorType:DDHSphereColorWhite];
            break;
        case DDHSphereColorWhite:
            sphere = [[DDHSphere alloc] initWithColorType:DDHSphereColorRed];
        default:
            NSAssert(NO, @"This should never happen.");
            break;
    }
    return sphere;
}

@end
