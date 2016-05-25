
#import <UIKit/UIKit.h>

@interface BBChatBotDataModelDispatch : NSObject

@property (nonatomic, strong) NSString *decision;
@property (nonatomic, strong) NSString *talkId;
@property (nonatomic, strong) NSString *title;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end