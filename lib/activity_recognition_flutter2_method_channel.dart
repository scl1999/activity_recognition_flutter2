import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'activity_recognition_flutter2_platform_interface.dart';

/// An implementation of [ActivityRecognitionFlutter2Platform] that uses method channels.
class MethodChannelActivityRecognitionFlutter2 extends ActivityRecognitionFlutter2Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('activity_recognition_flutter2');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
