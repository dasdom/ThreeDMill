//  Created by Dominik Hauser on 09.09.22.
//  
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DDHMill;

@interface DDHCheckResult : NSObject
@property (nonatomic, readonly) DDHMill *discoveredMill;
@property (nonatomic, readonly) NSArray<DDHMill *> *knownMills;
- (instancetype)initWithDiscoveredMill:(DDHMill *)discoveredMill knownMills:(NSArray<DDHMill *> *)knownMills;
@end

NS_ASSUME_NONNULL_END
