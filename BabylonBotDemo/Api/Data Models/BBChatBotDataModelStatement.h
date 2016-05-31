
#import <UIKit/UIKit.h>
#import "BBChatBotDataModelChosenOption.h"
#import "BBChatBotDataModelOptionData.h"

@interface BBChatBotDataModelStatement : NSObject

@property (nonatomic, strong) BBChatBotDataModelChosenOption * chosenOption;
@property (nonatomic, strong) NSString * file;
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * inResponseTo;
@property (nonatomic, strong) BBChatBotDataModelOptionData * optionData;
@property (nonatomic, strong) NSString * speaker;
@property (nonatomic, strong) NSString * target;
@property (nonatomic, strong) NSString * timestamp;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * value;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end