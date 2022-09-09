//  Created by Dominik Hauser on 05.09.22.
//  
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDHPosition : NSObject
@property int column;
@property int row;
@property int floor;
+ (instancetype)offBoard;
- (instancetype)initWithColumn:(int)column row:(int)row andFloor:(int)floor;
- (BOOL)isOffBoard;
@end

NS_ASSUME_NONNULL_END
