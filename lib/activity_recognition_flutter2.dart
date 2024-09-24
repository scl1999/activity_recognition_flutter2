
import 'activity_recognition_flutter2_platform_interface.dart';

import 'dart:async';
import 'package:flutter/services.dart';

class ActivityRecognitionFlutter2 {
  static const MethodChannel _channel = MethodChannel('activity_recognition_flutter2');

  /// Fetches activities since the specified time in milliseconds since epoch.
  static Future<List<Map<String, dynamic>>> fetchActivities(int sinceMilliseconds) async {
    try {
      final List<dynamic> activities = await _channel.invokeMethod('fetchActivities', {'since': sinceMilliseconds});
      return activities.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      print('Error fetching activities: $e');
      return [];
    }
  }

  /// Gets the motion authorization status.
  /// Returns:
  /// - 0: Not Determined
  /// - 1: Restricted
  /// - 2: Denied
  /// - 3: Authorized
  static Future<int> getMotionAuthorizationStatus() async {
    try {
      final int status = await _channel.invokeMethod('getMotionAuthorizationStatus');
      return status;
    } catch (e) {
      print('Error getting motion authorization status: $e');
      return 0; // Not Determined
    }
  }
}
