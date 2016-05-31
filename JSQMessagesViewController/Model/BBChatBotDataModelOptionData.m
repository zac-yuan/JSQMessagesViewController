
#import "BBChatBotDataModelOptionData.h"
#import "BBChatBotDataModelChosenOption.h"

@interface BBChatBotDataModelOptionData ()
@end
@implementation BBChatBotDataModelOptionData


-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[@"html"] isKindOfClass:[NSNull class]]){
		self.html = dictionary[@"html"];
	}	
	if(![dictionary[@"image"] isKindOfClass:[NSNull class]]){
		self.image = dictionary[@"image"];
	}	
	if(dictionary[@"options"] != nil && ![dictionary[@"options"] isKindOfClass:[NSNull class]]){
		NSArray * optionsDictionaries = dictionary[@"options"];
		NSMutableArray * optionsItems = [NSMutableArray array];
		for(NSDictionary * optionsDictionary in optionsDictionaries){
			BBChatBotDataModelChosenOption * optionsItem = [[BBChatBotDataModelChosenOption alloc] initWithDictionary:optionsDictionary];
			[optionsItems addObject:optionsItem];
		}
		self.options = optionsItems;
	}
	if(![dictionary[@"type"] isKindOfClass:[NSNull class]]){
		self.type = dictionary[@"type"];
	}	
	return self;
}
@end