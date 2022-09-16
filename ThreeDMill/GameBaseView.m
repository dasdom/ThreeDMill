//  Created by Dominik Hauser on 02.09.22.
//  
//

#import "ActionFactory.h"
#import "DDHBoard.h"
#import "DDHGameViewFactory.h"
#import "DDHMill.h"
#import "DDHPole.h"
#import "DDHSphereNode.h"
#import "GameBaseView.h"
#import "GameNodeFactory.h"
#import <GLKit/GLKMath.h>

@interface GameBaseView ()
@property SCNNode *cameraRootNode;
@property NSArray<NSArray<SCNNode *> *> *poleNodes;
@property NSMutableArray<NSMutableArray<NSMutableArray<DDHSphereNode *> *> *> *sphereNodes;
@property CGFloat startAngleY;
@property CGFloat startPositionY;
@property SCNVector3 preAnimationStartPosition;
@property SCNVector3 startPosition;
@property (nonatomic) UILabel *remainingWhiteSpheresLabel;
@property (nonatomic) UILabel *remainingRedSpheresLabel;
@end

@implementation GameBaseView

- (instancetype)initWithFrame:(CGRect)frame options:(NSDictionary<NSString *,id> *)options {

    if (self = [super initWithFrame:frame options:options]) {

        self.backgroundColor = [UIColor blackColor];
        self.showsStatistics = YES;

        self.scene = [[SCNScene alloc] init];
        SCNNode *rootNode = self.scene.rootNode;

        SCNNode *groundNode = [GameNodeFactory ground];
        [rootNode addChildNode:groundNode];

        SCNLookAtConstraint *constraint = [GameNodeFactory lookAtConstraint:groundNode];

        _cameraRootNode = [GameNodeFactory cameraRootNode:constraint];
        [rootNode addChildNode:_cameraRootNode];

        SCNNode *baseNode = [GameNodeFactory base];
        [rootNode addChildNode:baseNode];

        _poleNodes = [GameNodeFactory poles:numberOfColumns addToNode:rootNode];

        SCNNode *textNode = [GameNodeFactory text:@"Mill"];

        SCNNode *textRootNode = [[SCNNode alloc] init];
        [textRootNode addChildNode:textNode];
        [rootNode addChildNode:textRootNode];

        _sphereNodes = [[NSMutableArray alloc] init];

        for (int i = 0; i < numberOfColumns; i++) {
            NSMutableArray<NSMutableArray<DDHSphereNode *> *> *rows = [[NSMutableArray alloc] init];
            for (int j = 0; j < numberOfColumns; j++) {
                [rows addObject:[[NSMutableArray alloc] init]];
            }
            [_sphereNodes addObject:rows];
        }

        UIView *whiteIndicatorView = [DDHGameViewFactory colorIndicatorViewWithColor:[UIColor whiteColor]];
        _remainingWhiteSpheresLabel = [DDHGameViewFactory remainingSpheresLabel];
        UIStackView *whiteStackView = [DDHGameViewFactory remainingInfoStackViewWithViews:@[whiteIndicatorView, _remainingWhiteSpheresLabel]];
        whiteStackView.translatesAutoresizingMaskIntoConstraints = NO;
        whiteStackView.hidden = YES;

        UIView *redIndicatorView = [DDHGameViewFactory colorIndicatorViewWithColor:[UIColor redColor]];
        _remainingRedSpheresLabel = [DDHGameViewFactory remainingSpheresLabel];
        UIStackView *redStackView = [DDHGameViewFactory remainingInfoStackViewWithViews:@[redIndicatorView, _remainingRedSpheresLabel]];
        redStackView.translatesAutoresizingMaskIntoConstraints = NO;
        redStackView.hidden = YES;

        _preAnimationStartPosition = SCNVector3Make(0, startYAboveBoard+20, 0);
        _startPosition = SCNVector3Make(0, startYAboveBoard+0, 0);

        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:panRecognizer];

        [self addSubview:redStackView];
        [self addSubview:whiteStackView];

        [NSLayoutConstraint activateConstraints:@[
            [redStackView.leadingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leadingAnchor constant:10.0],
            [redStackView.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor constant:-10.0],

            [whiteStackView.trailingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.trailingAnchor constant:-10.0],
            [whiteStackView.bottomAnchor constraintEqualToAnchor:redStackView.bottomAnchor],
        ]];
    }
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)sender {

    CGPoint translation = [sender translationInView:self];

    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            self.startAngleY = self.cameraRootNode.eulerAngles.y;
            self.startPositionY = self.cameraRootNode.position.y;
            break;
        default:
            break;
    }

    if (fabs(translation.x) < fabs(translation.y)) {
        CGFloat positionY = self.startPositionY + translation.y / 6;
        if (positionY > -10 && positionY < 20) {
            SCNVector3 position = self.cameraRootNode.position;
            position.y = positionY;
            self.cameraRootNode.position = position;
        }
    } else {
        SCNVector3 eulerAngles = self.cameraRootNode.eulerAngles;
        eulerAngles.y = self.startAngleY - GLKMathDegreesToRadians(translation.x);
        self.cameraRootNode.eulerAngles = eulerAngles;
    }
}

- (DDHSphereNode *)insertSphereWithColor:(DDHSphereColor)color {
    DDHSphereNode *sphereNode = [DDHSphereNode sphereWithColor:color];
    sphereNode.position = self.preAnimationStartPosition;

    [self.scene.rootNode addChildNode:sphereNode];

    dispatch_async(dispatch_get_main_queue(), ^{
        SCNAction *moveToStart = [SCNAction moveTo:self.startPosition duration:0.5];
        [sphereNode runAction:moveToStart];
    });

    return sphereNode;
}

//- (void)updateUIWithBoard:(DDHBoard *)board {
//
//    _sphereNodes = [[NSMutableArray alloc] init];
//
//    for (int i = 0; i < numberOfColumns; i++) {
//        NSMutableArray<NSMutableArray<DDHSphereNode *> *> *rows = [[NSMutableArray alloc] init];
//        for (int j = 0; j < numberOfColumns; j++) {
//            [rows addObject:[[NSMutableArray alloc] init]];
//        }
//        [self.sphereNodes addObject:rows];
//    }
//
//    for (int column = 0; column < numberOfColumns; column++) {
//        for (int row = 0; row < numberOfColumns; row++) {
//            DDHPole *pole = [board poleAtColumn:column row:row];
//            for (int floor = 0; floor < numberOfColumns; floor++) {
//                DDHSphere *sphere = [pole sphereAtFloor:floor];
//                if (sphere) {
//                    DDHSphereNode *sphereNode = [DDHSphereNode sphereWithColor:sphere.colorType];
//                    [self.sphereNodes[column][row] addObject:sphereNode];
//                }
//            }
//        }
//    }
//}

- (void)addSphereNode:(DDHSphereNode *)sphereNode toColumn:(int)column andRow:(int)row {
    [self.sphereNodes[column][row] addObject:sphereNode];
}

- (struct PoleCoordinate)poleForNode:(SCNNode *)node {
    struct PoleCoordinate poleCoordinate;
    poleCoordinate.column = -1;
    poleCoordinate.column = -1;
    for (int column = 0; column < numberOfColumns; column++) {
        for (int row = 0; row < numberOfColumns; row++) {
            if (node == self.poleNodes[column][row]) {
                poleCoordinate.column = column;
                poleCoordinate.row = row;
            }
        }
    }
    return poleCoordinate;
}

- (DDHSphereNode *)removeTopSphereAtColumn:(NSInteger)column row:(NSInteger)row {
    if (self.sphereNodes[column][row].count < 1) {
        return nil;
    }
    DDHSphereNode *sphereToRemove = [self.sphereNodes[column][row] lastObject];
    [self.sphereNodes[column][row] removeLastObject];
    return sphereToRemove;
}

- (DDHSphereNode *)firstMovingSphereNode {
    NSArray<SCNNode *> *movingSphereNodes = [self.scene.rootNode childNodesPassingTest:^BOOL(SCNNode * _Nonnull child, BOOL * _Nonnull stop) {
        if ([child respondsToSelector:@selector(moving)]) {
            return [(DDHSphereNode *)child moving];
        } else {
            return false;
        }
    }];
    return (DDHSphereNode *)movingSphereNodes.firstObject;
}

- (void)reset {
    for (int column = 0; column < numberOfColumns; column++) {
        for (int row = 0; row < numberOfColumns; row++) {
            while (self.sphereNodes[column][row].count > 0) {
                DDHSphereNode *sphereToRemove = [self.sphereNodes[column][row] lastObject];
                [self.sphereNodes[column][row] removeLastObject];
                [sphereToRemove removeFromParentNode];
            }
        }
    }
}

- (void)fadeAllButSpheresInMill:(DDHMill *)mill toOpacity:(CGFloat)opacity {

    SCNAction *fadeAction = [SCNAction fadeOpacityTo:opacity duration:0.5];

    for (int column = 0; column < numberOfColumns; column++) {
        for (int row = 0; row < numberOfColumns; row++) {
            SCNNode *poleNode = self.poleNodes[column][row];
            [poleNode runAction:fadeAction completionHandler:^{
                poleNode.castsShadow = opacity > 0.5;
            }];

            NSArray<SCNNode *> *sphereNodesOnPole = self.sphereNodes[column][row];
            [sphereNodesOnPole enumerateObjectsUsingBlock:^(SCNNode * _Nonnull sphereNode, NSUInteger idx, BOOL * _Nonnull stop) {

                DDHPosition *position = [[DDHPosition alloc] initWithColumn:column row:row andFloor:(int)idx];
                if (NO == [mill containsSphereAtPosition:position]) {
                    [sphereNode runAction:fadeAction completionHandler:^{
                        sphereNode.castsShadow = opacity > 0.5;
                    }];
                }
            }];
        }
    }
}

@end
