
import 'flutter_android_speech_to_text_platform_interface.dart';

class FlutterAndroidSpeechToText {
  Future<String?> getPlatformVersion() {
    return FlutterAndroidSpeechToTextPlatform.instance.getPlatformVersion();
  }
}
