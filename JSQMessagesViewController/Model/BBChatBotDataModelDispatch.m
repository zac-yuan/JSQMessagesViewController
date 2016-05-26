
#import "BBChatBotDataModelDispatch.h"

@implementation BBChatBotDataModelDispatch

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[@"decision"] isKindOfClass:[NSNull class]]) {
		self.decision = dictionary[@"decision"];
	}	
	if(![dictionary[@"id"] isKindOfClass:[NSNull class]]) {
		self.talkId = dictionary[@"id"];
	}	
	if(![dictionary[@"title"] isKindOfClass:[NSNull class]]) {
		self.title = dictionary[@"title"];
	}	
	return self;
}

@end