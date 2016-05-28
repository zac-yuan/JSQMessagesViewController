
#import "BBChatBotDataModelStatement.h"

@interface BBChatBotDataModelStatement ()
@end
@implementation BBChatBotDataModelStatement


-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[@"chosenOption"] isKindOfClass:[NSNull class]]){
		self.chosenOption = [[BBChatBotDataModelChosenOption alloc] initWithDictionary:dictionary[@"chosenOption"]];
	}

	if(![dictionary[@"file"] isKindOfClass:[NSNull class]]){
		self.file = dictionary[@"file"];
	}	
	if(![dictionary[@"id"] isKindOfClass:[NSNull class]]){
		self.id = dictionary[@"id"];
	}	
	if(![dictionary[@"in_response_to"] isKindOfClass:[NSNull class]]){
		self.inResponseTo = dictionary[@"in_response_to"];
	}	
	if(![dictionary[@"optionData"] isKindOfClass:[NSNull class]]){
		self.optionData = [[BBChatBotDataModelOptionData alloc] initWithDictionary:dictionary[@"optionData"]];
	}

	if(![dictionary[@"speaker"] isKindOfClass:[NSNull class]]){
		self.speaker = dictionary[@"speaker"];
	}	
	if(![dictionary[@"target"] isKindOfClass:[NSNull class]]){
		self.target = dictionary[@"target"];
	}	
	if(![dictionary[@"timestamp"] isKindOfClass:[NSNull class]]){
		self.timestamp = dictionary[@"timestamp"];
	}	
	if(![dictionary[@"type"] isKindOfClass:[NSNull class]]){
		self.type = dictionary[@"type"];
	}	
	if(![dictionary[@"value"] isKindOfClass:[NSNull class]]){
		self.value = dictionary[@"value"];
	}	
	return self;
}
@end