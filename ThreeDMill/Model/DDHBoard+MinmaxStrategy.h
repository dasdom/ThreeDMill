//  Created by Dominik Hauser on 13.09.22.
//  
//

@import GameplayKit;
#import "DDHBoard.h"
#import "DDHPlayer+MinmaxStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHBoard (MinmaxStrategy) <GKGameModel>
@property (nonatomic, readonly, nullable) NSArray<DDHPlayer *> *players;
@property (nonatomic, readonly, nullable) DDHPlayer *activePlayer;
@end

NS_ASSUME_NONNULL_END
