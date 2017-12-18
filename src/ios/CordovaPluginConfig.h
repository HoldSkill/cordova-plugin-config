#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Cordova/CDVPlugin.h>

@interface CordovaPluginConfig : CDVPlugin

@property (nonatomic,strong) UILongPressGestureRecognizer *lpgr;
- (void)LongPressfix:(CDVInvokedUrlCommand*)command;
- (BOOL)checkAudioPermission:(CDVInvokedUrlCommand*)command;
- (BOOL)getAudioPermission:(CDVInvokedUrlCommand*)command;
@end