//  Created by Dominik Hauser on 09.09.22.
//  
//

#import "DDHMill.h"

@implementation DDHMill

- (instancetype)init {

    if (self = [super init]) {
        _positions = [[NSArray alloc] init];
    }
    return self;
}

- (void)addPosition:(DDHPosition *)position {
    self.positions = [self.positions arrayByAddingObject:position];
}

- (BOOL)containsSphereAtPosition:(DDHPosition *)position {
    return [self.positions containsObject:position];
}

- (BOOL)isEqual:(DDHMill *)object {
    return [self.positions isEqualToArray:object.positions];
}

- (NSString *)description {
    return [self.positions componentsJoinedByString:@"."];
}

@end
