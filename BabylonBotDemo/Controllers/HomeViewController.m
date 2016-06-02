
#import "HomeViewController.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>

NSString *const segueChatBot = @"segueChatBot";

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO: Remove before release (DEMO ONLY)
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:@"/v1/ask"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"ask.json", self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
 
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:@"websocket-rating"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"rating_response.json", self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
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
