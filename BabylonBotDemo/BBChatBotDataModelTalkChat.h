
#import <UIKit/UIKit.h>
#import "BBChatBotDataModelDispatch.h"

@interface BBChatBotDataModelTalkChat : NSObject

@property (nonatomic, strong) NSString *chat;
@property (nonatomic, strong) NSArray *dispatch;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end