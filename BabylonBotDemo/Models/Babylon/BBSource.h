
#import <UIKit/UIKit.h>

@interface BBSource : NSObject

@property (nonatomic, assign) NSInteger sourceId;
@property (nonatomic, strong) NSString *sourceType;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end