//  Created by Dominik Hauser on 13.09.22.
//  
//

@import GameplayKit;
#import "DDHMove.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHMove (MinmaxStrategy) <GKGameModelUpdate>
@property (nonatomic, assign) NSInteger value;
@end

NS_ASSUME_NONNULL_END
