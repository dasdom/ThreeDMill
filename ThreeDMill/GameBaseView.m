//  Created by Dominik Hauser on 02.09.22.
//  
//

#import "GameBaseView.h"
#import "GameNodeFactory.h"
#import "DDHBoard.h"
#import "DDHSphereNode.h"
#import <GLKit/GLKMath.h>
#import "ActionFactory.h"

@interface GameBaseView ()
@property SCNNode *cameraRootNode;
@property NSArray<NSArray<SCNNode *> *> *poleNodes;
@property NSMutableArray<NSMutableArray<NSMutableArray<DDHSphereNode *> *> *> *sphereNodes;
@property CGFloat startAngleY;
@property CGFloat startPositionY;
@property SCNVector3 preAnimationStartPosition;
@property SCNVector3 startPosition;
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

        for (int i = 0; i < numberOfColumns; i++) {
            NSMutableArray<NSMutableArray<DDHSphereNode *> *> *rows = [[NSMutableArray alloc] init];
            for (int j = 0; j < numberOfColumns; j++) {
                [rows addObject:[[NSMutableArray alloc] init]];
            }
            [self.sphereNodes addObject:rows];
        }

        _preAnimationStartPosition = SCNVector3Make(0, startYAboveBoard+20, 0);
        _startPosition = SCNVector3Make(0, startYAboveBoard+0, 0);

        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:panRecognizer];
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

@end
