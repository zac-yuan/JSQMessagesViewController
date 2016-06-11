
#import <UIKit/UIKit.h>
#import "BBMember.h"
#import "BBSource.h"
#import "BBSpeaker.h"

@interface BBPossibleElement : NSObject

@property (nonatomic, strong) NSString *elementId;
@property (nonatomic, strong) NSArray *expectedInput;
@property (nonatomic, strong) NSArray *members;
@property (nonatomic, strong) NSArray *possibleElements;
@property (nonatomic, strong) BBSource *source;
@property (nonatomic, strong) BBSpeaker *speaker;
@property (nonatomic, strong) NSString *value;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end