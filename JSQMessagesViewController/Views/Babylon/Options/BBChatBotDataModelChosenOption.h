
#import <UIKit/UIKit.h>

@interface BBChatBotDataModelChosenOption : NSObject

@property (nonatomic, strong) NSString * messageId;
@property (nonatomic, strong) NSString * source;
@property (nonatomic, strong) NSString * value;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end