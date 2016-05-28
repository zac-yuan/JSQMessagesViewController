
#import "BBChatBotDataModelChosenOption.h"

@interface BBChatBotDataModelChosenOption ()
@end
@implementation BBChatBotDataModelChosenOption

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[@"id"] isKindOfClass:[NSNull class]]){
		self.id = dictionary[@"id"];
	}	
	if(![dictionary[@"source"] isKindOfClass:[NSNull class]]){
		self.source = dictionary[@"source"];
	}	
	if(![dictionary[@"value"] isKindOfClass:[NSNull class]]){
		self.value = dictionary[@"value"];
	}	
	return self;
}
@end