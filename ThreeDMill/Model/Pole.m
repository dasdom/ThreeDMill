//  Created by Dominik Hauser on 03.09.22.
//  
//

#import "Pole.h"

@interface Pole ()
@property NSArray<Sphere *> *spheres;
@end

@implementation Pole

- (instancetype)init {
    if (self = [super init]) {
        _spheres = [[NSArray alloc] init];
    }
    return self;
}

- (int)sphereCount {
    return [self.spheres count];
}

- (Sphere *)lastSphereColor {
    return self.spheres.lastObject;
}

- (void)addSphere:(Sphere *)sphere {
    self.spheres = [self.spheres arrayByAddingObject:sphere];
}

@end
