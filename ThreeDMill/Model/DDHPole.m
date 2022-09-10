//  Created by Dominik Hauser on 03.09.22.
//  
//

#import "DDHPole.h"

@interface DDHPole ()
@property NSArray<DDHSphere *> *spheres;
@end

@implementation DDHPole

- (instancetype)init {
    if (self = [super init]) {
        _spheres = [[NSArray alloc] init];
    }
    return self;
}

- (int)sphereCount {
    return (int)[self.spheres count];
}

- (DDHSphere *)lastSphereColor {
    return self.spheres.lastObject;
}

- (void)addSphere:(DDHSphere *)sphere {
    self.spheres = [self.spheres arrayByAddingObject:sphere];
}

- (DDHSphere *)sphereAtFloor:(int)floor {
    if (self.sphereCount <= floor) {
        return nil;
    }
    return self.spheres[floor];
}

@end
