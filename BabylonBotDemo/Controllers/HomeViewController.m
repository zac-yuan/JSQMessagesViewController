
#import "HomeViewController.h"

NSString *const segueChatBot = @"segueChatBot";

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)textFieldTouchDownAction:(id)sender {
    [self performSegueWithIdentifier:segueChatBot sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:segueChatBot]) {
        
    }
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    if (size.height > size.width) {
        //landscape mode
    } else {
        //portrait mode
    }
    
}

@end
