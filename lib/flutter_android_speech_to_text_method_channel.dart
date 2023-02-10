import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_android_speech_to_text_platform_interface.dart';

/// An implementation of [FlutterAndroidSpeechToTextPlatform] that uses method channels.
class MethodChannelFlutterAndroidSpeechToText extends FlutterAndroidSpeechToTextPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_android_speech_to_text');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
