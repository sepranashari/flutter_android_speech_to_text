import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_android_speech_to_text/flutter_android_speech_to_text_method_channel.dart';

void main() {
  MethodChannelFlutterAndroidSpeechToText platform = MethodChannelFlutterAndroidSpeechToText();
  const MethodChannel channel = MethodChannel('flutter_android_speech_to_text');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
