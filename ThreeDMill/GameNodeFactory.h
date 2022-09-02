//  Created by Dominik Hauser on 31.08.22.
//  
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameNodeFactory : NSObject
+ (SCNNode *)ground;
+ (SCNLight *)ambientLight;
+ (SCNNode *)camera: (SCNLookAtConstraint *)constraint;
+ (SCNNode *)spotLight: (SCNLookAtConstraint *)constraint;
+ (SCNNode *)base;
+ (NSArray<NSArray<SCNNode *> *> *)poles:(NSInteger)columns;
+ (SCNNode *)text: (NSString *)string;
@end

NS_ASSUME_NONNULL_END
