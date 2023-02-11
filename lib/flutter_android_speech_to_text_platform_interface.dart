import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_android_speech_to_text_method_channel.dart';

abstract class FlutterAndroidSpeechToTextPlatform extends PlatformInterface {
  /// Constructs a FlutterAndroidSpeechToTextPlatform.
  FlutterAndroidSpeechToTextPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAndroidSpeechToTextPlatform _instance =
      MethodChannelFlutterAndroidSpeechToText();

  /// The default instance of [FlutterAndroidSpeechToTextPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAndroidSpeechToText].
  static FlutterAndroidSpeechToTextPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAndroidSpeechToTextPlatform] when
  /// they register themselves.
  static set instance(FlutterAndroidSpeechToTextPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getSpeechToText(String language) {
    throw UnimplementedError('getSpeechToText() has not been implemented.');
  }
}
