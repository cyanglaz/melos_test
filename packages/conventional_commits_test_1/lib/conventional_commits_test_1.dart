import 'dart:async';

import 'package:flutter/services.dart';

class ConventionalCommitsTest_1 {
  static const MethodChannel channel3 =
      const MethodChannel('conventional_commits_test_1');

  static Future<String> get platformVersion async {
    final String version = await channel3.invokeMethod('getPlatformVersion');
    return version;
  }
}
