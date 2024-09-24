import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'activity_recognition_flutter2_method_channel.dart';

abstract class ActivityRecognitionFlutter2Platform extends PlatformInterface {
  /// Constructs a ActivityRecognitionFlutter2Platform.
  ActivityRecognitionFlutter2Platform() : super(token: _token);

  static final Object _token = Object();

  static ActivityRecognitionFlutter2Platform _instance = MethodChannelActivityRecognitionFlutter2();

  /// The default instance of [ActivityRecognitionFlutter2Platform] to use.
  ///
  /// Defaults to [MethodChannelActivityRecognitionFlutter2].
  static ActivityRecognitionFlutter2Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ActivityRecognitionFlutter2Platform] when
  /// they register themselves.
  static set instance(ActivityRecognitionFlutter2Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
