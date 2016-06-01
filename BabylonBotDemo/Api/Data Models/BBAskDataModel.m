
#import "BBAskDataModel.h"

@implementation BBAskDataModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[@"element_id"] isKindOfClass:[NSNull class]]){
		self.elementId = dictionary[@"element_id"];
	}	
	if(![dictionary[@"expected_input"] isKindOfClass:[NSNull class]]){
		self.expectedInput = dictionary[@"expected_input"];
	}	
	if(dictionary[@"members"] != nil && ![dictionary[@"members"] isKindOfClass:[NSNull class]]){
		NSArray * membersDictionaries = dictionary[@"members"];
		NSMutableArray * membersItems = [NSMutableArray array];
		for(NSDictionary * membersDictionary in membersDictionaries){
			BBMember * membersItem = [[BBMember alloc] initWithDictionary:membersDictionary];
			[membersItems addObject:membersItem];
		}
		self.members = membersItems;
	}
	if(dictionary[@"possible_elements"] != nil && ![dictionary[@"possible_elements"] isKindOfClass:[NSNull class]]){
		NSArray * possibleElementsDictionaries = dictionary[@"possible_elements"];
		NSMutableArray * possibleElementsItems = [NSMutableArray array];
		for(NSDictionary * possibleElementsDictionary in possibleElementsDictionaries){
			BBPossibleElement * possibleElementsItem = [[BBPossibleElement alloc] initWithDictionary:possibleElementsDictionary];
			[possibleElementsItems addObject:possibleElementsItem];
		}
		self.possibleElements = possibleElementsItems;
	}
	if(![dictionary[@"source"] isKindOfClass:[NSNull class]]){
		self.source = [[BBSource alloc] initWithDictionary:dictionary[@"source"]];
	}

	if(![dictionary[@"speaker"] isKindOfClass:[NSNull class]]){
		self.speaker = [[BBMember alloc] initWithDictionary:dictionary[@"speaker"]];
	}

	if(![dictionary[@"value"] isKindOfClass:[NSNull class]]){
		self.value = dictionary[@"value"];
	}	
	return self;
}
@end