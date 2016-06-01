
#import <UIKit/UIKit.h>
#import "BBMember.h"
#import "BBPossibleElement.h"
#import "BBSource.h"
#import "BBMember.h"

@interface BBAskDataModel : NSObject

@property (nonatomic, strong) NSString *elementId;
@property (nonatomic, strong) NSArray *expectedInput;
@property (nonatomic, strong) NSArray *members;
@property (nonatomic, strong) NSArray *possibleElements;
@property (nonatomic, strong) BBSource *source;
@property (nonatomic, strong) BBMember *speaker;
@property (nonatomic, strong) NSString *value;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end