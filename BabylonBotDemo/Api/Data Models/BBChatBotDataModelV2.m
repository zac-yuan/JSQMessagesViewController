
#import "BBChatBotDataModelV2.h"

@interface BBChatBotDataModelV2 ()
@end
@implementation BBChatBotDataModelV2


-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[@"conversation_id"] isKindOfClass:[NSNull class]]){
		self.conversationId = dictionary[@"conversation_id"];
	}	
	if(![dictionary[@"finished"] isKindOfClass:[NSNull class]]){
		self.finished = [dictionary[@"finished"] boolValue];
	}

	if(dictionary[@"statements"] != nil && ![dictionary[@"statements"] isKindOfClass:[NSNull class]]){
		NSArray * statementsDictionaries = dictionary[@"statements"];
		NSMutableArray * statementsItems = [NSMutableArray array];
		for(NSDictionary * statementsDictionary in statementsDictionaries){
			BBChatBotDataModelStatement * statementsItem = [[BBChatBotDataModelStatement alloc] initWithDictionary:statementsDictionary];
			[statementsItems addObject:statementsItem];
		}
		self.statements = statementsItems;
	}
	return self;
}
@end