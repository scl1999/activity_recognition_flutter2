import Flutter
import UIKit
import CoreMotion

public class ActivityRecognitionFlutter2Plugin: NSObject, FlutterPlugin {
  private let motionActivityManager = CMMotionActivityManager()
  private var activityRecognitionChannel: FlutterMethodChannel?
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "activity_recognition_flutter2", binaryMessenger: registrar.messenger())
    let instance = ActivityRecognitionFlutter2Plugin()
    instance.activityRecognitionChannel = channel
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "fetchActivities" {
      guard let args = call.arguments as? [String: Any],
            let sinceMilliseconds = args["since"] as? Int64 else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument for 'since'", details: nil))
        return
      }
      
      let sinceDate = Date(timeIntervalSince1970: TimeInterval(sinceMilliseconds) / 1000)
      fetchActivities(since: sinceDate, result: result)
    } else if call.method == "getMotionAuthorizationStatus" {
      getMotionAuthorizationStatus(result: result)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
  
  private func fetchActivities(since: Date, result: @escaping FlutterResult) {
    if CMMotionActivityManager.isActivityAvailable() {
      motionActivityManager.queryActivityStarting(from: since, to: Date(), to: .main) { (activities, error) in
        if let error = error {
          result(FlutterError(code: "ACTIVITY_ERROR", message: "Failed to fetch activities: \(error.localizedDescription)", details: nil))
          return
        }
        
        guard let activities = activities else {
          result([])
          return
        }
        
        let activitiesList = activities.map { activity in
          return [
            "confidence": activity.confidence.rawValue,
            "stationary": activity.stationary,
            "walking": activity.walking,
            "running": activity.running,
            "automotive": activity.automotive,
            "cycling": activity.cycling,
            "unknown": activity.unknown,
            "startDate": activity.startDate.timeIntervalSince1970 * 1000  // Convert to milliseconds
          ] as [String: Any]
        }
        
        result(activitiesList)
      }
    } else {
      result(FlutterError(code: "ACTIVITY_NOT_AVAILABLE", message: "Activity recognition is not available on this device.", details: nil))
    }
  }
  
  private func getMotionAuthorizationStatus(result: @escaping FlutterResult) {
    if #available(iOS 11.0, *) {
      let status = CMMotionActivityManager.authorizationStatus()
      switch status {
      case .notDetermined:
        result(0) // Not Determined
      case .restricted:
        result(1) // Restricted
      case .denied:
        result(2) // Denied
      case .authorized:
        result(3) // Authorized
      @unknown default:
        result(0) // Not Determined
      }
    } else {
      // For iOS versions below 11.0, permissions are not required
      result(3) // Authorized
    }
  }
}

