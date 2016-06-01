
#import "BBPossibleElement.h"

@implementation BBPossibleElement

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[@"element_id"] isKindOfClass:[NSNull class]]){
		self.elementId = dictionary[@"element_id"];
	}	
	if(dictionary[@"expected_input"] != nil && ![dictionary[@"expected_input"] isKindOfClass:[NSNull class]]){
		NSArray * expectedInputDictionaries = dictionary[@"expected_input"];
		NSMutableArray * expectedInputItems = [NSMutableArray array];
		for(NSDictionary *expectedInputDictionary in expectedInputDictionaries){
			[expectedInputItems addObject:expectedInputDictionary];
		}
		self.expectedInput = expectedInputItems;
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
			[possibleElementsItems addObject:possibleElementsDictionary];
		}
		self.possibleElements = possibleElementsItems;
	}
	if(![dictionary[@"source"] isKindOfClass:[NSNull class]]){
		self.source = [[BBSource alloc] initWithDictionary:dictionary[@"source"]];
	}

	if(![dictionary[@"speaker"] isKindOfClass:[NSNull class]]){
		self.speaker = [[BBSpeaker alloc] initWithDictionary:dictionary[@"speaker"]];
	}

	if(![dictionary[@"value"] isKindOfClass:[NSNull class]]){
		self.value = dictionary[@"value"];
	}	
	return self;
}
@end