//  Created by Dominik Hauser on 02.09.22.
//  
//

#import "GameBaseViewController.h"
#import "GameBaseView.h"
#import "DDHBoard.h"
#import "ActionFactory.h"

@interface GameBaseViewController ()
@property BOOL aSphereIsMoving;
@property DDHBoard *board;
@end

@implementation GameBaseViewController

- (instancetype)init {
    if (self = [super init]) {
        _board = [[DDHBoard alloc] init];
    }
    return self;
}

- (void)loadView {
    GameBaseView *contentView = [[GameBaseView alloc] initWithFrame:CGRectZero options:nil];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [contentView addGestureRecognizer:tapRecognizer];
    self.view = contentView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self animateLastMoves];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)tap:(UITapGestureRecognizer *)sender {

    if (self.aSphereIsMoving) {
        return;
    }

    if (self.board.mode == DDHBoardModeFinish) {
        return;
    }

    CGPoint location = [sender locationInView:self.view];

    GameBaseView *gameBaseView = (GameBaseView *)self.view;
    NSArray<SCNHitTestResult *> *hitResult = [gameBaseView hitTest:location options:nil];
    if ([hitResult count] > 0) {
        SCNHitTestResult *result = hitResult[0];
        SCNNode *node = result.node;

        if (self.board.mode == DDHBoardModeShowMill) {
            [self continueWithGame:nil];
            return;
        }

        struct PoleCoordinate poleCoordinate = [gameBaseView poleForNode:node];
        int column = poleCoordinate.column;
        int row = poleCoordinate.row;
        if (column >= 0 && row >= 0) {
            NSLog(@"(%ld, %ld)", (long)column, (long)row);

            [self didTapPole];

            [self addSphereToPole:node column:column row:row];
        }
    }
}

- (void)didTapPole {
    // To be overridden in subclasses
}

- (void)removeSphereFromNode:(SCNNode *)node column:(NSInteger)column row:(NSInteger)row {

//    if (NO == [self.board canRemoveSphereFromColumn:column row:row]) {
//        return;
//    }
//
//    SCNVector3 position = node.position;
//    position.y = 20;
//    SCNAction *moveUp = [SCNAction moveTo:position duration:0.3];
//    SCNAction *wait = [SCNAction waitForDuration:0.05];
//    SCNAction *fade = [SCNAction fadeOpacityTo:0.1 duration:0.1];
//    SCNAction *remove = [SCNAction removeFromParentNode];
//    remove.timingMode = SCNActionTimingModeEaseOut;
//
//    SCNAction *moveAndRemove = [SCNAction sequence:@[moveUp, wait, fade, remove]];
//
//    GameBaseView *gameBaseView = (GameBaseView *)self.view;
//    SCNNode *sphereNode = [gameBaseView removeTopSphereAtColumn:column row:row];
//    self.aSphereIsMoving = YES;
//    [sphereNode runAction:moveAndRemove completionHandler:^{
//        [self.board removeSphereFromColumn:column row:row];
//    }];
//
//    NSAssert(NO, @"missing implementation");
}

- (void)addSphereToPole:(SCNNode *)pole column:(int)column row:(int)row {
    if (NO == [self.board canAddSphereAtColumn:column row:row]) {
        [self showOKAlert:@"Pole full" message:@"A pole cannot hold more than four spheres." onViewController:self];
        return;
    }

    int floor = [self.board numberOfSpheresAtColumn:column andRow:row];

    GameBaseView *gameBaseView = (GameBaseView *)self.view;
    DDHSphereNode *movingSphereNode = [gameBaseView firstMovingSphereNode];

    SCNAction *moveToPole = [ActionFactory actionToMoveToNode:pole];
    SCNAction *moveDown = [ActionFactory actionToMoveDownToNode:pole floor:floor];

    SCNAction *move;

    if (movingSphereNode.position.y < startYAboveBoard) {
        SCNAction *moveUp = [ActionFactory actionToMoveUpForSphere:movingSphereNode];
        move = [SCNAction sequence:@[moveUp, moveToPole, moveDown]];
    } else {
        move = [SCNAction sequence:@[moveToPole, moveDown]];
    }

    DDHSphere *sphereToAdd = [[DDHSphere alloc] initWithColorType:self.board.currentPlayer.color];
    [self.board addSphere:sphereToAdd column:column row:row];

    [movingSphereNode runAction:move completionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateGame];
        });
    }];
}

- (void)animateLastMoves {

    if (self.board.lastMoves.count < 1) {
        GameBaseView *gameBaseView = (GameBaseView *)self.view;
        [gameBaseView insertSphereWithColor:self.board.currentPlayer.color];
    }
}

//- (void)resetBoard {
//    self.board = [[DDHBoard alloc] init];
//
//    GameBaseView *gameBaseView = (GameBaseView *)self.view;
//    [gameBaseView reset];
//}

- (void)updateGame {
    GameBaseView *gameBaseView = (GameBaseView *)self.view;
    DDHSphereNode *movingSphereNode = [gameBaseView firstMovingSphereNode];
    movingSphereNode.moving = NO;

    self.board.currentPlayer = self.board.currentPlayer.opponent;

    [gameBaseView insertSphereWithColor:self.board.currentPlayer.color];
}

// MARK: - Actions
- (void)continueWithGame:(UIButton *)sender {
    // is this needed?
}

// MARK: - Alert
- (void)showOKAlert:(NSString *)title message:(NSString *)message onViewController:(UIViewController *)viewController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
