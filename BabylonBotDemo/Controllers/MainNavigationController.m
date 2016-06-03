
#import "MainNavigationController.h"
#import "HomeViewController.h"

@implementation MainNavigationController

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[HomeViewController class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end