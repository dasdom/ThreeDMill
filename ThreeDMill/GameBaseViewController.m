//  Created by Dominik Hauser on 02.09.22.
//  
//

#import "GameBaseViewController.h"
#import "GameBaseView.h"

@interface GameBaseViewController ()

@end

@implementation GameBaseViewController

- (void)loadView {
    GameBaseView *contentView = [[GameBaseView alloc] initWithFrame:CGRectZero options:nil];
    self.view = contentView;
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

@end
