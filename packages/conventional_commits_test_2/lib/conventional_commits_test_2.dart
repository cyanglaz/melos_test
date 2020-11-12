
import 'dart:async';

import 'package:flutter/services.dart';

class ConventionalCommitsTest_2 {
  static const MethodChannel _channel =
      const MethodChannel('conventional_commits_test_2');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
