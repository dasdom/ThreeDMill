//  Created by Dominik Hauser on 04.09.22.
//  
//

#import "Sphere.h"

@implementation Sphere

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

- (Sphere *)oposit {
    Sphere *sphere;
    switch (self.colorType) {
        case DDHSphereColorRed:
            sphere = [[Sphere alloc] initWithColorType:DDHSphereColorWhite];
            break;
        case DDHSphereColorWhite:
            sphere = [[Sphere alloc] initWithColorType:DDHSphereColorRed];
        default:
            NSAssert(NO, @"This should never happen.");
            break;
    }
    return sphere;
}

@end
