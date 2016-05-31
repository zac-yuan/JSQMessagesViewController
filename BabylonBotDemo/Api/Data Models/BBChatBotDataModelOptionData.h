
#import <UIKit/UIKit.h>
#import "BBChatBotDataModelOptionData.h"

@interface BBChatBotDataModelOptionData : NSObject

@property (nonatomic, strong) NSString * html;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, strong) NSArray * options;
@property (nonatomic, strong) NSString * type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end