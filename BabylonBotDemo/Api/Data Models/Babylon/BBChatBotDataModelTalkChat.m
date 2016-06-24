
#import "BBChatBotDataModelTalkChat.h"

@implementation BBChatBotDataModelTalkChat

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[@"chat"] isKindOfClass:[NSNull class]]) {
		self.chat = dictionary[@"chat"];
	}	
	if(dictionary[@"dispatch"] != nil && ![dictionary[@"dispatch"] isKindOfClass:[NSNull class]]) {
		NSArray *dispatchDictionaries = dictionary[@"dispatch"];
		NSMutableArray *dispatchItems = [NSMutableArray array];
		for(NSDictionary *dispatchDictionary in dispatchDictionaries){
			BBChatBotDataModelDispatch * dispatchItem = [[BBChatBotDataModelDispatch alloc] initWithDictionary:dispatchDictionary];
			[dispatchItems addObject:dispatchItem];
		}
		self.dispatch = dispatchItems;
	}
	return self;
}

@end