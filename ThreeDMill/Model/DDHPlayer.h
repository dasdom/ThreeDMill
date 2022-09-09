//  Created by Dominik Hauser on 09.09.22.
//  
//

#import <Foundation/Foundation.h>
#import "DDHSphereColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHPlayer : NSObject
+ (DDHPlayer *)whitePlayer;
+ (DDHPlayer *)redPlayer;
@property (nonatomic, readonly) DDHSphereColor color;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) DDHPlayer *opponent;
@end

NS_ASSUME_NONNULL_END
