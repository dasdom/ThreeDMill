//  Created by Dominik Hauser on 15.09.22.
//  
//

#import "DDHSphereColorHelper.h"

@implementation DDHSphereColorHelper

+ (NSString *)stringFromColor:(DDHSphereColor)color {
    NSString *colorString;
    switch (color) {
        case DDHSphereColorNone:
            colorString = @"none";
            break;
        case DDHSphereColorWhite:
            colorString = @"white";
            break;
        case DDHSphereColorRed:
            colorString = @"red";
            break;
        default:
            colorString = @"unknown";
            break;
    }
    return colorString;
}

+ (DDHSphereColor)colorFromString:(NSString *)string {
    DDHSphereColor color;
    if ([string isEqualToString:@"red"]) {
        color = DDHSphereColorRed;
    } else if ([string isEqualToString:@"white"]) {
        color = DDHSphereColorWhite;
    } else {
        color = DDHSphereColorNone;
    }
    return color;
}
@end
