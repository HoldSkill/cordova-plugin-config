#import <Cordova/CDVPlugin.h>

@interface CordovaPluginConfig : CDVPlugin

@property (nonatomic,strong) UILongPressGestureRecognizer *lpgr;
- (void)checkAudioPermission:(CDVInvokedUrlCommand*)command;
- (void)getAudioPermission:(CDVInvokedUrlCommand*)command;

@end