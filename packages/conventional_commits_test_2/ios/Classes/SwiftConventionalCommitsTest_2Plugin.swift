import Flutter
import UIKit

public class SwiftConventionalCommitsTest_2Plugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "conventional_commits_test_2", binaryMessenger: registrar.messenger())
    let instance = SwiftConventionalCommitsTest_2Plugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
