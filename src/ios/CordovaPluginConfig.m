#import "CordovaPluginConfig.h"
#import <Cordova/CDV.h>

@implementation CordovaPluginConfig

/**
 *  插件初始化主要用于appkey的注册
 */
- (void)pluginInitialize
{
  _checkStatus = false;
  _setStatus = false;
}

- (void)LongPressFix {
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

- (BOOL)checkAudioPermission:(CDVInvokedUrlCommand*)command {
AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
        //没有询问是否开启麦克风
            _checkStatus = true;
            break;
        case AVAuthorizationStatusRestricted:
        //未授权，家长限制
            _checkStatus = false;
            break;
        case AVAuthorizationStatusDenied:
        //未授权
            _checkStatus = false;
            break;
        case AVAuthorizationStatusAuthorized:
        //授权
            _checkStatus = false;
            break;
        default:
            break;
    }
    return _checkStatus;
}
- (BOOL)getAudioPermission:(CDVInvokedUrlCommand*)command {
  AVAudioSession *session = [AVAudioSession sharedInstance];
  if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
      [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
          if (granted) {
              // Microphone enabled code
              NSLog(@"Microphone is enabled..");
              setStatus = true;
          }
          else {
              // Microphone disabled code
              NSLog(@"Microphone is disabled..");
              _setStatus = false;
          }
      }];
      return _setStatus;
  }
  return false;
}

@end