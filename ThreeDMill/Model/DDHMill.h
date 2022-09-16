//  Created by Dominik Hauser on 09.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "DDHPosition.h"
#import "DDHSphereColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHMill : NSObject
@property (nonatomic) NSArray<DDHPosition *> *positions;
@property DDHSphereColor color;
- (instancetype)initWithString:(NSString *)string;
- (void)addPosition:(DDHPosition *)position;
- (BOOL)containsSphereAtPosition:(DDHPosition *)position;
@end

NS_ASSUME_NONNULL_END
