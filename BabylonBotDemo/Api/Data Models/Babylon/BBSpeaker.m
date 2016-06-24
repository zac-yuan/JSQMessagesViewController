
#import "BBSpeaker.h"

@implementation BBSpeaker

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[@"id"] isKindOfClass:[NSNull class]]){
		self.speakerId = dictionary[@"id"];
	}	
	if(![dictionary[@"type"] isKindOfClass:[NSNull class]]){
		self.type = dictionary[@"type"];
	}	
	return self;
}
@end