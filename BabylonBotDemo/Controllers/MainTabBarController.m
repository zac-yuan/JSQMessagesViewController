
#import "MainTabBarController.h"

@implementation MainTabBarController

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([tabBar selectedItem] == [tabBar items][0]) {
        [item setBadgeValue:nil];
    }
}

@end