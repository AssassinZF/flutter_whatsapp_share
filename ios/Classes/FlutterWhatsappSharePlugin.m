#import "FlutterWhatsappSharePlugin.h"

@implementation FlutterWhatsappSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_whatsapp_share"
            binaryMessenger:[registrar messenger]];
  FlutterWhatsappSharePlugin* instance = [[FlutterWhatsappSharePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"shareContentToWhatsapp" isEqualToString:call.method]){
      NSDictionary *param = (NSDictionary *)call.arguments;
      NSString *msg = param[@"msg"];
      NSString *url = [NSString stringWithFormat:@"whatsapp://send?text=%@", [msg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
      NSURL *whatsappURL = [NSURL URLWithString: url];
      if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
          [[UIApplication sharedApplication] openURL: whatsappURL];
          result(@"success");
      } else {
          // Cannot open whatsapp
          result(@"fail");
      }
  } else {
    result(FlutterMethodNotImplemented);
  }
}


@end
