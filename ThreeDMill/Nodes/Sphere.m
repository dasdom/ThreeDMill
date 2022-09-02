//  Created by Dominik Hauser on 02.09.22.
//  
//

#import "Sphere.h"

@interface Sphere ()
- (instancetype)init:(SCNGeometry *)geometry color:(DDHSphereColor)color;
@end

@implementation Sphere

+ (instancetype)standardSphere:(DDHSphereColor)color {

    SCNMaterial *material = [[SCNMaterial alloc] init];
    switch (color) {
        case DDHSphereColorWhite:
            material.diffuse.contents = [UIColor whiteColor];
            break;
        case DDHSphereColorRed:
            material.diffuse.contents = [UIColor redColor];
            break;
        default:
            break;
    }

    SCNGeometry *geometry = [SCNSphere sphereWithRadius:2.6];
    geometry.materials = @[material];

    return [[self alloc] init:geometry color:color];
}

- (instancetype)init:(SCNGeometry *)geometry color:(DDHSphereColor)color {

    if (self = [super init]) {
        _color = color;
        self.geometry = geometry;
        self.name = @"Sphere";
    }
    return self;
}

@end
