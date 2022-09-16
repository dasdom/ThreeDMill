//  Created by Dominik Hauser on 12.09.22.
//  
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDHGameViewFactory : NSObject
+ (UIView *)colorIndicatorViewWithColor:(UIColor *)color;
+ (UILabel *)remainingSpheresLabel;
+ (UIStackView *)remainingInfoStackViewWithViews:(NSArray<UIView *> *)views;
@end

NS_ASSUME_NONNULL_END
