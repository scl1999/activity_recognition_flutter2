import 'package:flutter_test/flutter_test.dart';
import 'package:activity_recognition_flutter2/activity_recognition_flutter2.dart';
import 'package:activity_recognition_flutter2/activity_recognition_flutter2_platform_interface.dart';
import 'package:activity_recognition_flutter2/activity_recognition_flutter2_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockActivityRecognitionFlutter2Platform
    with MockPlatformInterfaceMixin
    implements ActivityRecognitionFlutter2Platform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ActivityRecognitionFlutter2Platform initialPlatform = ActivityRecognitionFlutter2Platform.instance;

  test('$MethodChannelActivityRecognitionFlutter2 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelActivityRecognitionFlutter2>());
  });

  test('getPlatformVersion', () async {
    ActivityRecognitionFlutter2 activityRecognitionFlutter2Plugin = ActivityRecognitionFlutter2();
    MockActivityRecognitionFlutter2Platform fakePlatform = MockActivityRecognitionFlutter2Platform();
    ActivityRecognitionFlutter2Platform.instance = fakePlatform;

    expect(await activityRecognitionFlutter2Plugin.getPlatformVersion(), '42');
  });
}
