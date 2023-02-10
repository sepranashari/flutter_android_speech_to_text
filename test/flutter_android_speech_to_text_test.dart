import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_android_speech_to_text/flutter_android_speech_to_text.dart';
import 'package:flutter_android_speech_to_text/flutter_android_speech_to_text_platform_interface.dart';
import 'package:flutter_android_speech_to_text/flutter_android_speech_to_text_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAndroidSpeechToTextPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAndroidSpeechToTextPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAndroidSpeechToTextPlatform initialPlatform = FlutterAndroidSpeechToTextPlatform.instance;

  test('$MethodChannelFlutterAndroidSpeechToText is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAndroidSpeechToText>());
  });

  test('getPlatformVersion', () async {
    FlutterAndroidSpeechToText flutterAndroidSpeechToTextPlugin = FlutterAndroidSpeechToText();
    MockFlutterAndroidSpeechToTextPlatform fakePlatform = MockFlutterAndroidSpeechToTextPlatform();
    FlutterAndroidSpeechToTextPlatform.instance = fakePlatform;

    expect(await flutterAndroidSpeechToTextPlugin.getPlatformVersion(), '42');
  });
}
