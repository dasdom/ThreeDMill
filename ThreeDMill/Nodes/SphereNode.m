//  Created by Dominik Hauser on 02.09.22.
//  
//

#import "SphereNode.h"

@interface SphereNode ()
- (instancetype)init:(SCNGeometry *)geometry color:(DDHSphereColor)color;
@end

@implementation SphereNode

+ (instancetype)sphereWithColor:(DDHSphereColor)color {

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
        self.moving = YES;
    }
    return self;
}

@end
