import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:activity_recognition_flutter2/activity_recognition_flutter2_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelActivityRecognitionFlutter2 platform = MethodChannelActivityRecognitionFlutter2();
  const MethodChannel channel = MethodChannel('activity_recognition_flutter2');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
