import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_whatsapp_share/flutter_whatsapp_share.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_whatsapp_share');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterWhatsappShare.platformVersion, '42');
  });
}
