
#import <UIKit/UIKit.h>

@interface BBSpeaker : NSObject

@property (nonatomic, strong) NSString *speakerId;
@property (nonatomic, strong) NSString *type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end