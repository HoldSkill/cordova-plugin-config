#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Cordova/CDVPlugin.h>

@interface CordovaPluginConfig : CDVPlugin

@property (nonatomic,strong) UILongPressGestureRecognizer *lpgr;
@property (nonatomic, assign) BOOL checkStatus;
@property (nonatomic, assign) BOOL setStatus;
- (void)LongPressFix:(CDVInvokedUrlCommand*)command;
- (BOOL)checkAudioPermission:(CDVInvokedUrlCommand*)command;
- (BOOL)getAudioPermission:(CDVInvokedUrlCommand*)command;
@end