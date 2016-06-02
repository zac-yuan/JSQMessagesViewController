
#import "ChatViewHelper.h"
#import "BBConstants.h"
#import "ApiManagerChatBot.h"
#import "JSQViewMediaItem.h"
#import "OptionsTableViewController.h"
#import "BBOption.h"

@import ios_maps;

@implementation ChatViewHelper

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO: Set UserID + DisplayName
    self.chatMessagesArray = [[NSMutableArray alloc] init];
    self.senderId = @"123456789";
    self.senderDisplayName = @"Anonymous User";
    
    // Setup WebSockets
    [self setPubNubClient:[BBPubNubClient shared]];
    [self.pubNubClient setPubNubClientDelegate:self];
    
    //TODO: Replace the channel id with user id
    [self.pubNubClient subscribeToChannel:kChatBotApiUserId completionHandler:^(PNAcknowledgmentStatus *status) {
        [self.pubNubClient pingPubNubService:^(PNErrorStatus *status, PNTimeResult *result) {
            if (!status.isError) {
                //TODO: Handle if push notifications is disabled ()
                // Start chatBot
                [[ApiManagerChatBot sharedConfiguration] postConversationText:@"hello" success:^(AFHTTPRequestOperation *operation, id response) {
                    // post conversation and wait websockets response
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    JSQMessage *message = [JSQMessage messageWithSenderId:kBabylonDoctorId displayName:kBabylonDoctorName text:[NSString babylonErrorMsg:error]];
                    [self addChatMessageForBot:message showObject:YES];
                    
                }];
                
            }
        }];
    }];
    
    // Custom config for chat
    self.inputToolbar.contentView.textView.pasteDelegate = self;
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeMake(30, 30);
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
    self.showTypingIndicator = YES;
    self.showLoadEarlierMessagesHeader = NO;
    self.inputToolbar.maximumHeight = 150;
    
    JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    self.userBubbleMsg = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor babylonPurple]];
    self.botBubbleMsg = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor groupTableViewBackgroundColor]];
    
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(customAction:)];
    [UIMenuController sharedMenuController].menuItems = @[ [[UIMenuItem alloc] initWithTitle:@"Edit" action:@selector(customAction:)] ];
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(delete:)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Enable/disable springy bubbles
    self.collectionView.collectionViewLayout.springinessEnabled = YES;
    [self.collectionView reloadData];
    
}

- (void)customAction:(id)sender {
    NSLog(@"Custom action received! Sender: %@", sender);
}

-(BOOL)showTypingIndicator {
    BOOL showTypingIndicator = [super showTypingIndicator];
    self.toolbarButtonsEnabled = !showTypingIndicator;
    return showTypingIndicator;
}

#pragma mark - PubNubClient delegate
- (void)pubNubClient:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    
    //TODO:
    NSString *statementId = [message.data.message objectForKey:@"statement"];
    NSString *chatId = [message.data.message objectForKey:@"conversation"];
    
    //TODO: change into a session or something
    [ApiManagerChatBot sharedConfiguration].conversationID = chatId;
    
    [[ApiManagerChatBot sharedConfiguration] getConversationStatement:statementId withConversationId:chatId sucess:^(AFHTTPRequestOperation *operation, id response) {
        
        BBChatBotDataModelStatement *chatDataModel = [[BBChatBotDataModelStatement alloc] initWithDictionary:response];
        JSQMessage *botMessage = [[JSQMessage alloc] initWithSenderId:kBabylonDoctorId
                                                    senderDisplayName:kBabylonDoctorName
                                                                 date:[NSDate date]
                                                                 text:chatDataModel.value];
        if ([chatDataModel.optionData.options count]>0) {
            [self showChatBotOptions:nil inOptions:chatDataModel.optionData.options
                     forQuestion:chatDataModel senderId:kBabylonDoctorId
               senderDisplayName:kBabylonDoctorName date:[NSDate date]];
        } else {
            [self addChatMessageForBot:botMessage showObject:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JSQMessage *message = [JSQMessage messageWithSenderId:kBabylonDoctorId displayName:kBabylonDoctorName text:[NSString babylonErrorMsg:error]];
        [self addChatMessageForBot:message showObject:YES];
    }];
    
}

- (void)pubNubClient:(PubNub *)client didReceiveStatus:(PNSubscribeStatus *)status {
    NSLog(@"PubNub Client: %@ \n Status: %@ \n Channels: %@", client, status, status.subscribedChannels);
}

- (void)showChatBotOptions:(BBChatBotDataModelChosenOption *)selectedOption inOptions:(NSArray *)options forQuestion:(BBChatBotDataModelStatement *)question senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date {
    NSMutableArray *dataSource = [NSMutableArray new];
    
    for(BBChatBotDataModelChosenOption *chosenOption in options ) {
        UIColor *textColor = [UIColor babylonPurple];
        UIColor *backgroundColor = [UIColor babylonWhite];
        BBOption *option = [BBOption optionWithText:chosenOption.value textColor:textColor font:[UIFont babylonRegularFont:kDefaultFontSize] backgroundColor:backgroundColor height:kOptionCellHeight optionSelected:chosenOption];
        [dataSource addObject:option];
    }

    OptionsTableViewController *viewController = [[OptionsTableViewController alloc] initWithDataSource:dataSource];
    viewController.delegate = self;
    JSQViewMediaItem *item = [[JSQViewMediaItem alloc] initWithViewControllerMedia:viewController];
    JSQMessage *userMessage = [JSQMessage messageWithSenderId:senderId
                                                  displayName:senderDisplayName
                                                         text:question.value
                                                        media:item];
   
    for(BBOption *option in dataSource ) {
        option.message = userMessage;
    }
    
    userMessage.wantsTouches = YES;
    [self addChatMessageForBot:userMessage showObject:YES];
}

- (void)sendMessage:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date showMessage:(BOOL)showMessage success:(ChatViewHelperSendSuccess)success {
    
    JSQMessage *userMessage = [[JSQMessage alloc] initWithSenderId:senderId
                                                 senderDisplayName:senderDisplayName
                                                              date:date
                                                              text:text];
    
    [self addChatMessageForUser:userMessage showObject:showMessage];
    
    self.showTypingIndicator = YES;
    [self.collectionView reloadData];
    [self scrollToBottomAnimated:YES];
    
    //FIXME: DEBUG ONLY
    [[ApiManagerChatBot sharedConfiguration] postConversationText:text success:^(AFHTTPRequestOperation *operation, id response) {
        BBChatBotDataModelV2 *chatDataModel = [[BBChatBotDataModelV2 alloc] initWithDictionary:response];
        if(success) {
            success();
        }
        NSLog(@"conversation id > %@ - %@", chatDataModel.conversationId, chatDataModel.statements);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JSQMessage *message = [JSQMessage messageWithSenderId:kBabylonDoctorId displayName:kBabylonDoctorName text:[NSString babylonErrorMsg:error]];
        [self addChatMessageForBot:message showObject:YES];
    }];

    
}

- (void)sendOption:(NSDictionary *)optionDic withConversationId:(NSString *)conversationId
 completionHandler:(void(^)(bool success))completionHandler {
    
    [[ApiManagerChatBot sharedConfiguration] postConversationOption:optionDic withConversationId:conversationId success:^(AFHTTPRequestOperation *operation, id response) {
        completionHandler(YES);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(NO);
    }];
    
}

#pragma mark - JSQMessagesOptionsDelegate
-(void)sender:(id)sender selectedOption:(BBOption *)selectedOption {
    // select option
    OptionsTableViewController *tableViewController = sender;
    for(BBOption *option in tableViewController.dataSource) {
        if(option == selectedOption) {
            option.textColor = [UIColor babylonWhite];
            option.backgroundColor = [UIColor babylonPurple];
        } else {
            option.textColor = [UIColor babylonPurple];
            option.backgroundColor = [UIColor babylonWhite];
        }
    }
    selectedOption.message.wantsTouches = NO;
    tableViewController.tableView.userInteractionEnabled = NO;
    [tableViewController.tableView reloadData];
    
    self.showTypingIndicator = YES;

    //TODO: the real implementation
//    NSDictionary *option = @{ @"" : @"" };
//    NSString *conversationID = [ApiManagerChatBot sharedConfiguration].conversationID;
//    [self sendOption:option withConversationId:conversationID completionHandler:^(bool success) {
//        if(success) {
//            NSLog(@"woohoo");
//        }
//    }];
    
    [self sendMessage:nil withMessageText:selectedOption.text senderId:self.senderId senderDisplayName:self.senderDisplayName date:[NSDate date] showMessage:NO success:^{
        
    }];
}

#pragma mark - Media Picker
- (void)didPressAccessoryButton:(UIButton *)sender {
    [self.inputToolbar.contentView.textView resignFirstResponder];
    
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Media Messages"
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertViewController addAction:[UIAlertAction actionWithTitle:@"Send photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choosePortraitPhoto];
    }]];
    
    [alertViewController addAction:[UIAlertAction actionWithTitle:@"Send location" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __weak typeof(self) weakSelf = self;
        [self addLocation:^{
            [weakSelf.collectionView reloadData];
        }];
    }]];
    
    [alertViewController addAction:[UIAlertAction actionWithTitle:@"Send video" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //HARDCODE:
        [self addVideo:[NSURL URLWithString:@"file://"]];
    }]];
    
    [alertViewController addAction:[UIAlertAction actionWithTitle:@"Send audio" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //HARDCODE:
        [self addAudio: [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"m4a"]];
    }]];
    
    [alertViewController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //DO NOTHING
    }]];
    
    __strong typeof(self) strongSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [strongSelf presentViewController:alertViewController animated:YES completion:nil];
    });
    
}

- (void)choosePortraitPhoto {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    [picker setSourceType:(UIImagePickerControllerSourceTypePhotoLibrary)];
    [self presentViewController:picker animated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:NO completion:^{
        [UIView animateWithDuration:1.0f animations:^{
            UIImage *imageSelected = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
            [self addPhoto:imageSelected];
        }];
    }];
}

- (void)addPhoto:(UIImage *)image {
    JSQPhotoMediaItem *photoItem = [[JSQPhotoMediaItem alloc] initWithImage:image];
    JSQMessage *photoMessage = [JSQMessage messageWithSenderId:self.senderId
                                                   displayName:self.senderDisplayName
                                                         media:photoItem];
    [self addChatMessageForUser:photoMessage showObject:YES];
}

- (void)addLocation:(JSQLocationMediaItemCompletionBlock)completion {
    
    //TODO: It's not stable yet (Review it)
    BBLocationManager *locationManager = [BBLocationManager sharedInstance];
    [locationManager startUpdatingLocation];
    
    JSQLocationMediaItem *locationItem = [[JSQLocationMediaItem alloc] init];
    [locationItem setLocation:locationManager.locationManager.location withCompletionHandler:completion];
    
    JSQMessage *locationMessage = [JSQMessage messageWithSenderId:self.senderId
                                                      displayName:self.senderDisplayName
                                                            media:locationItem];
    [self addChatMessageForUser:locationMessage showObject:YES];
    
}

- (void)addAudio:(NSString *)sample {
    
    NSData * audioData = [NSData dataWithContentsOfFile:sample];
    JSQAudioMediaItem *audioItem = [[JSQAudioMediaItem alloc] initWithData:audioData];
    JSQMessage *audioMessage = [JSQMessage messageWithSenderId:self.senderId
                                                   displayName:self.senderDisplayName
                                                         media:audioItem];
    [self addChatMessageForUser:audioMessage showObject:YES];
}

- (void)addVideo:(NSURL *)videoURL {
    
    JSQVideoMediaItem *videoItem = [[JSQVideoMediaItem alloc] initWithFileURL:videoURL isReadyToPlay:YES];
    JSQMessage *videoMessage = [JSQMessage messageWithSenderId:self.senderId
                                                   displayName:self.senderDisplayName
                                                         media:videoItem];
    [self addChatMessageForUser:videoMessage showObject:YES];
    
}

- (void)addChatMessageForUser:(JSQMessage *)message showObject:(BOOL)showObject {
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    if (showObject) {
        [self.chatMessagesArray addObject:message];
    }
    [self finishSendingMessageAnimated:YES];
}

- (void)addChatMessageForBot:(JSQMessage *)message showObject:(BOOL)showObject {
    [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
    if (showObject) {
        [self.chatMessagesArray addObject:message];
        [[[[self tabBarController] tabBar] items][0] setBadgeValue:[NSString babylonBadgeCounter:self.chatMessagesArray]];
    }
    [self finishReceivingMessageAnimated:YES];
}

- (BOOL)composerTextView:(JSQMessagesComposerTextView *)textView shouldPasteWithSender:(id)sender {
    return YES;
}

@end