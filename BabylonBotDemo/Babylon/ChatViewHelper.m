
#import "ChatViewHelper.h"
#import "BBConstants.h"
#import "ApiManagerChatBot.h"
#import "JSQViewMediaItem.h"
#import "OptionsTableViewController.h"
#import "BBOption.h"
@import ios_maps;

@interface ChatViewHelper () <JSQMessagesOptionsDelegate>

@end

@implementation ChatViewHelper

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO: Set UserID + DisplayName
    self.chatMessagesArray = [[NSMutableArray alloc] init];
    self.senderId = @"123456789";
    self.senderDisplayName = @"Anonymous User";
    
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Enable/disable springy bubbles
    self.collectionView.collectionViewLayout.springinessEnabled = YES;
}

- (void)customAction:(id)sender {
    NSLog(@"Custom action received! Sender: %@", sender);
}

#pragma mark - Menu options
- (void)presentMenuOptionsController:(BBChatBotDataModelTalkChat *)chatDataModel {
    
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:NSLocalizedString(chatDataModel.chat, nil)
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int x=0; x<[chatDataModel.dispatch count]; x++) {
        NSString *optionTitle = [(BBChatBotDataModelDispatch *)[chatDataModel.dispatch objectAtIndex:x] title];
        UIAlertAction *chatMenuOption = [UIAlertAction actionWithTitle:NSLocalizedString(optionTitle, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self sendMessage:nil withMessageText:[[chatDataModel.dispatch objectAtIndex:x] title] senderId:self.senderId senderDisplayName:self.senderDisplayName date:[NSDate date] success:^{
                [self selectedOption:chatDataModel.dispatch[x] inOptions:chatDataModel.dispatch forQuestion:chatDataModel senderId:kBabylonDoctorId senderDisplayName:kBabylonDoctorName date:[NSDate date]];
            }];
        }];
        [alertViewController addAction:chatMenuOption];
    }
    
    UIAlertAction *cancelMenuOption = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                                                   
                                                               }];
    
    [alertViewController addAction:cancelMenuOption];
    
    
    __strong typeof(self) strongSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [strongSelf presentViewController:alertViewController animated:YES completion:nil];
    });
    
}

- (void)selectedOption:(BBChatBotDataModelDispatch *)selectedOption inOptions:(NSArray *)options forQuestion:(BBChatBotDataModelTalkChat *)question senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date {
    NSMutableArray *dataSource = [NSMutableArray new];
    
    for(BBChatBotDataModelDispatch *option in options) {
        UIColor *textColor;
        UIColor *backgroundColor;
        if(option == selectedOption) {
            backgroundColor = [UIColor babylonPurple];
            textColor = [UIColor babylonWhite];
        } else {
            backgroundColor = [UIColor babylonWhite];
            textColor = [UIColor babylonPurple];
        }
        
        [dataSource addObject:[BBOption optionWithText:option.title textColor:textColor font:[UIFont babylonRegularFont:kDefaultFontSize] backgroundColor:backgroundColor height:kOptionCellHeight]];
    }

    OptionsTableViewController *viewController = [[OptionsTableViewController alloc] initWithDataSource:dataSource];
    viewController.delegate = self;
    JSQViewMediaItem *item = [[JSQViewMediaItem alloc] initWithViewControllerMedia:viewController];
    JSQMessage *userMessage = [JSQMessage messageWithSenderId:senderId
                                                  displayName:senderDisplayName
                                                         text:question.chat
                                                        media:item];
    userMessage.wantsTouches = YES;

    [self.chatMessagesArray addObject:userMessage];
    [self finishSendingMessage];
}

- (void)sendMessage:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date success:(ChatViewHelperSendSuccess)success {
    
    JSQMessage *userMessage = [[JSQMessage alloc] initWithSenderId:senderId
                                                 senderDisplayName:senderDisplayName
                                                              date:date
                                                              text:text];
    
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    [self.chatMessagesArray addObject:userMessage];
    [self finishSendingMessage];
    
    self.showTypingIndicator = YES;
    [self.collectionView reloadData];
    [self scrollToBottomAnimated:YES];
    
    //TODO: Change it to apimanager postConversation method
    [[ApiManagerChatBot sharedConfiguration] getTalkChat:text success:^(AFHTTPRequestOperation *operation, id response) {
        if(success) {
            success();
        }
        
        BBChatBotDataModelTalkChat *chatDataModel = [[BBChatBotDataModelTalkChat alloc] initWithDictionary:response];
        
        [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
        JSQMessage *botMessage = [[JSQMessage alloc] initWithSenderId:kBabylonDoctorId
                                                    senderDisplayName:kBabylonDoctorName
                                                                 date:date
                                                                 text:chatDataModel.chat];
        
        if ([chatDataModel.dispatch count]>0) {
            [self presentMenuOptionsController:chatDataModel];
        } else {
            [self.chatMessagesArray addObject:botMessage];
        }
        
        [self finishReceivingMessageAnimated:YES];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
        [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
        JSQMessage *message = [JSQMessage messageWithSenderId:kBabylonDoctorId displayName:kBabylonDoctorName text:error.localizedFailureReason];
        [self.chatMessagesArray addObject:message];
        [self finishReceivingMessageAnimated:YES];
        
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
    [self addChatMessageObject:photoMessage];
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
    [self addChatMessageObject:locationMessage];
    
}

- (void)addAudio:(NSString *)sample {
    
    NSData * audioData = [NSData dataWithContentsOfFile:sample];
    JSQAudioMediaItem *audioItem = [[JSQAudioMediaItem alloc] initWithData:audioData];
    JSQMessage *audioMessage = [JSQMessage messageWithSenderId:self.senderId
                                                   displayName:self.senderDisplayName
                                                         media:audioItem];
    [self addChatMessageObject:audioMessage];
}

- (void)addVideo:(NSURL *)videoURL {
    
    JSQVideoMediaItem *videoItem = [[JSQVideoMediaItem alloc] initWithFileURL:videoURL isReadyToPlay:YES];
    JSQMessage *videoMessage = [JSQMessage messageWithSenderId:self.senderId
                                                   displayName:self.senderDisplayName
                                                         media:videoItem];
    [self addChatMessageObject:videoMessage];
    
}

- (void)addChatMessageObject:(JSQMessage *)message {
    
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    [self.chatMessagesArray addObject:message];
    [self finishSendingMessageAnimated:YES];
    
}

- (BOOL)composerTextView:(JSQMessagesComposerTextView *)textView shouldPasteWithSender:(id)sender {
    return YES;
}

#pragma mark - JSQMessagesOptionsDelegate

-(void)sender:(id)sender selectedOption:(BBOption *)option {
    NSLog(@"OPTION SELECTED");
}

@end