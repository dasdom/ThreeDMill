//  Created by Dominik Hauser on 02.09.22.
//  
//

#import "GameBaseView.h"
#import "GameNodeFactory.h"
#import "Board.h"
#import "Sphere.h"
#import <GLKit/GLKMath.h>

@interface GameBaseView ()
@property SCNNode *cameraRootNode;
@property NSMutableArray<NSMutableArray<NSMutableArray<Sphere *> *> *> *sphereNodes;

@property CGFloat startAngleY;
@property CGFloat startPositionY;
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

        SCNLookAtConstraint *constraint = [SCNLookAtConstraint lookAtConstraintWithTarget:groundNode];
        constraint.gimbalLockEnabled = YES;
        constraint.influenceFactor = 0.8;

        SCNNode *cameraNode = [GameNodeFactory camera:constraint];
        SCNNode *spotlightNode = [GameNodeFactory spotLight:constraint];

        _cameraRootNode = [[SCNNode alloc] init];
        [_cameraRootNode addChildNode:cameraNode];
        [_cameraRootNode addChildNode:spotlightNode];
        [rootNode addChildNode:_cameraRootNode];

        SCNNode *baseNode = [GameNodeFactory base];
        [rootNode addChildNode:baseNode];

        NSArray<NSArray<SCNNode *> *> *poleNodes = [GameNodeFactory poles:numberOfColumns];
        [poleNodes enumerateObjectsUsingBlock:^(NSArray<SCNNode *> * _Nonnull columns, NSUInteger idx, BOOL * _Nonnull stop) {
            [columns enumerateObjectsUsingBlock:^(SCNNode * _Nonnull pole, NSUInteger idx, BOOL * _Nonnull stop) {
                [rootNode addChildNode:pole];
            }];
        }];

        SCNNode *textNode = [GameNodeFactory text:@"Mill"];

        SCNNode *textRootNode = [[SCNNode alloc] init];
        [textRootNode addChildNode:textNode];
        [rootNode addChildNode:textRootNode];

        for (int i = 0; i < numberOfColumns; i++) {
            NSMutableArray<NSMutableArray<Sphere *> *> *rows = [[NSMutableArray alloc] init];
            for (int j = 0; j < numberOfColumns; j++) {
                [rows addObject:[[NSMutableArray alloc] init]];
            }
            [self.sphereNodes addObject:rows];
        }

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

@end
