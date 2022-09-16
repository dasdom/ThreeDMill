//  Created by Dominik Hauser on 05.09.22.
//  
//

#import "DDHMove.h"

@implementation DDHMove
- (instancetype)initWithTo:(DDHPosition *)to sphereColor:(DDHSphereColor)color {
    if (self = [super init]) {
        _to = to;
        _from = [DDHPosition offBoard];
        _color = color;
    }
    return self;
}
@end
