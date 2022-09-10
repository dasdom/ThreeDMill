//  Created by Dominik Hauser on 09.09.22.
//  
//

#import "DDHCheckResult.h"

@implementation DDHCheckResult

- (instancetype)initWithDiscoveredMill:(DDHMill *)discoveredMill knownMills:(NSArray<DDHMill *> *)knownMills {

    if (self = [super init]) {
        _discoveredMill = discoveredMill;
        _knownMills = knownMills;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, %@", self.discoveredMill, self.knownMills];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@, %@", self.discoveredMill, self.knownMills];
}

@end
