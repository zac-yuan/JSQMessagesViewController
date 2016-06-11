
#import <UIKit/UIKit.h>

@interface BBMember : NSObject

@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end