#import "CordovaPluginConfig.h"
#import <Cordova/CDV.h>

@implementation CordovaPluginConfig

- (void)LongPressFix:(CDVInvokedUrlCommand*)command {
  self.lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestures:)];
  self.lpgr.minimumPressDuration = 0.45f;

  // 0.45 is ok for 'regular longpress', 0.05-0.08 is required for '3D Touch longpress',
  // but since this will also kill onclick handlers (not ontouchend), I made it optional
  if ([self.commandDelegate.settings objectForKey:@"suppress3dtouch"] && [[self.commandDelegate.settings objectForKey:@"suppress3dtouch"] boolValue]) {
    self.lpgr.minimumPressDuration = 0.05f;
  }

  self.lpgr.allowableMovement = 100.0f;

  NSArray *views = self.webView.subviews;
  if (views.count == 0) {
    NSLog(@"No webview subviews found, not applying the longpress fix");
    return;
  }
  for (int i=0; i<views.count; i++) {
    UIView *webViewScrollView = views[i];
    if ([webViewScrollView isKindOfClass:[UIScrollView class]]) {
      NSArray *webViewScrollViewSubViews = webViewScrollView.subviews;
      UIView *browser = webViewScrollViewSubViews[0];
      [browser addGestureRecognizer:self.lpgr];
      NSLog(@"Applied longpress fix");
      break;
    }
  }
}

- (void)handleLongPressGestures:(UILongPressGestureRecognizer *)sender {
  if ([sender isEqual:self.lpgr]) {
    if (sender.state == UIGestureRecognizerStateBegan) {
       // since we may touches of 0.08s we no longer log these (would flood the log)
       //NSLog(@"Ignoring a longpress in order to suppress the magnifying glass (iOS9 quirk)");
    }
  }
}

- (void)checkAudioPermission:(CDVInvokedUrlCommand*)command {
AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    int checkStatus = 0;
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
        //没有询问是否开启麦克风
            checkStatus = -2;
            break;
        case AVAuthorizationStatusRestricted:
        //未授权，家长限制
            checkStatus = -1;
            break;
        case AVAuthorizationStatusDenied:
        //未授权
            checkStatus = 0;
            break;
        case AVAuthorizationStatusAuthorized:
        //授权
            checkStatus = 1;
            break;
        default:
            break;
    }
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:checkStatus];
    [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
}
- (void)getAudioPermission:(CDVInvokedUrlCommand*)command {
  NSString* jsString = nil;
  AVAudioSession *session = [AVAudioSession sharedInstance];
  if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
      [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
          if (granted) {
              // Microphone enabled code
              NSLog(@"Microphone is enabled..");
              jsString = [NSString stringWithFormat:@"%@(%d);", @"cordova.require('cordova-plugin-config.CordovaPluginConfig').getAudioPermissionStatus", 1];
          }
          else {
              // Microphone disabled code
              NSLog(@"Microphone is disabled..");
              jsString = [NSString stringWithFormat:@"%@(%d);", @"cordova.require('cordova-plugin-config.CordovaPluginConfig').getAudioPermissionStatus", 0];
          }
      }];
      [self.commandDelegate evalJs:jsString];
  }
}

@end