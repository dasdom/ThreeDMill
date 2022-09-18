//  Created by Dominik Hauser on 09.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "DDHSphereColor.h"

NS_ASSUME_NONNULL_BEGIN

@class DDHMill;
@class DDHCheckResult;
@class DDHPole;

@interface DDHBoardChecker : NSObject
+ (DDHCheckResult *)checkForMatchOnPoles:(NSArray<NSArray<DDHPole *> *> *)poles knownMills:(NSArray<DDHMill *> *)knownMills;
+ (NSArray<NSNumber *> *)runCountsOnPoles:(NSArray<NSArray<DDHPole *> *> *)poles forPlayerWithColor:(DDHSphereColor)color;
@end

NS_ASSUME_NONNULL_END
