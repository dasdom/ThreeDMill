//  Created by Dominik Hauser on 09.09.22.
//  
//

#import "DDHMill.h"
#import "DDHSphereColorHelper.h"

@implementation DDHMill

- (instancetype)init {

    if (self = [super init]) {
        _positions = [[NSArray alloc] init];
    }
    return self;
}

- (instancetype)initWithString:(NSString *)string {

    if (self = [super init]) {
        NSMutableArray *positions = [[NSMutableArray alloc] init];

        NSArray<NSString *> *components = [string componentsSeparatedByString:@","];
        _color = [DDHSphereColorHelper colorFromString:components[1]];

        NSArray<NSString *> *positionComponents = [components[0] componentsSeparatedByString:@"."];
        [positionComponents enumerateObjectsUsingBlock:^(NSString * _Nonnull positionString, NSUInteger idx, BOOL * _Nonnull stop) {
            int column = [[positionString substringWithRange:NSMakeRange(0, 1)] intValue];
            int row = [[positionString substringWithRange:NSMakeRange(1, 1)] intValue];
            int floor = [[positionString substringWithRange:NSMakeRange(2, 1)] intValue];

            DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:floor];
            [positions addObject:position];
        }];

        _positions = positions;
    }
    return self;
}

- (void)addPosition:(DDHPosition *)position {
    self.positions = [self.positions arrayByAddingObject:position];
}

- (BOOL)containsSphereAtPosition:(DDHPosition *)position {
    return [self.positions containsObject:position];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@,%@", [self.positions componentsJoinedByString:@"."], [DDHSphereColorHelper stringFromColor:self.color]];
}

- (BOOL)isEqual:(DDHMill *)object {
    if (NO == [object isKindOfClass:[DDHMill class]]) {
        return NO;
    }
    if (self.color != object.color) {
        return NO;
    }
    if (NO == [self.positions isEqualToArray:object.positions]) {
        return NO;
    }
    return YES;
}

@end
