//  Created by Dominik Hauser on 09.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "DDHPosition.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHMill : NSObject
@property NSArray<DDHPosition *> *positions;
- (void)addPosition:(DDHPosition *)position;
- (BOOL)containsSphereAtPosition:(DDHPosition *)position;
@end

NS_ASSUME_NONNULL_END
