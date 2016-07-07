
#import <UIKit/UIKit.h>
#import "BBDotActivityIndicatorParms.h"

@interface BBDotActivityIndicatorView : UIView

@property (strong, nonatomic) BBDotActivityIndicatorParms *dotParms;

- (void)startAnimating;
- (void)stopAnimating;

@end
