import 'flutter_android_speech_to_text_platform_interface.dart';

class FlutterAndroidSpeechToText {
  Future<String?> getPlatformVersion() {
    return FlutterAndroidSpeechToTextPlatform.instance.getPlatformVersion();
  }

  Future<String?> getSpeechToText(String language) {
    return FlutterAndroidSpeechToTextPlatform.instance
        .getSpeechToText(language);
  }
}
