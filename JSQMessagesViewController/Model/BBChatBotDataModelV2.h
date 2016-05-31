
#import <UIKit/UIKit.h>
#import "BBChatBotDataModelStatement.h"

@interface BBChatBotDataModelV2 : NSObject

@property (nonatomic, strong) NSString * conversationId;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, strong) NSArray * statements;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end