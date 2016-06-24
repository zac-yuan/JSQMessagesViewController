
#import "BBSource.h"

@implementation BBSource

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[@"source_type"] isKindOfClass:[NSNull class]]){
		self.sourceType = dictionary[@"source_type"];
	}	
	if(![dictionary[@"source_id"] isKindOfClass:[NSNull class]]){
		self.sourceId = [dictionary[@"source_id"] integerValue];
	}	
	return self;
}
@end