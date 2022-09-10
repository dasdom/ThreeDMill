//  Created by Dominik Hauser on 05.09.22.
//  
//

#import "DDHPosition.h"

@implementation DDHPosition

+ (instancetype)offBoard {
    return [[DDHPosition alloc] initWithColumn:-1 row:-1 andFloor:-1];
}

- (instancetype)initWithColumn:(int)column row:(int)row andFloor:(int)floor {
    if (self = [super init]) {
        _column = column;
        _row = row;
        _floor = floor;
    }
    return self;
}

- (BOOL)isOffBoard {
    return self.column < 0 || self.row < 0 || self.floor < 0;
}

- (BOOL)isEqual:(DDHPosition *)object {
    if (NO == [object isKindOfClass:[DDHPosition class]]) {
        return NO;
    }
    if (self.column != object.column) {
        return NO;
    }
    if (self.row != object.row) {
        return NO;
    }
    if (self.floor != object.floor) {
        return NO;
    }
    return YES;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%d%d%d", self.column, self.row, self.floor];
}

@end
