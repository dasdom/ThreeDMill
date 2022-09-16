//  Created by Dominik Hauser on 12.09.22.
//  
//

#import "DDHGameViewFactory.h"

@implementation DDHGameViewFactory

+ (UIView *)colorIndicatorViewWithColor:(UIColor *)color {

    CGFloat sphereIndicatorHeight = 20.0;

    UIView *colorView = [[UIView alloc] init];
    colorView.backgroundColor = color;
    colorView.layer.cornerRadius = sphereIndicatorHeight/2.0;
    [colorView.widthAnchor constraintEqualToConstant:sphereIndicatorHeight].active = YES;
    [colorView.heightAnchor constraintEqualToConstant:sphereIndicatorHeight].active = YES;
    return colorView;
}

+ (UILabel *)remainingSpheresLabel {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"32";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    return label;
}

+ (UIStackView *)remainingInfoStackViewWithViews:(NSArray<UIView *> *)views {
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:views];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 5.0;
    return stackView;
}

@end
