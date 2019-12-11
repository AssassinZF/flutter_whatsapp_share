import 'dart:async';

import 'package:flutter/services.dart';

class FlutterWhatsappShare {
  static const MethodChannel _channel =
      const MethodChannel('flutter_whatsapp_share');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> shareContentToWhatsapp({String msg = ""}) async {
    final String res = await _channel.invokeMethod('shareContentToWhatsapp', {"msg": msg});
    return res;
  }
}
