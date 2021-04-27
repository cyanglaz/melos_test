import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:conventional_commits_test_1/conventional_commits_test_1.dart';

void main() {
  const MethodChannel channel = MethodChannel('conventional_commits_test_1');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '51';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('getPlatformVersion', () async {
  //   var rand = Random();
  //   var n = rand.nextInt(5);
  //   expect(n, 0);
  //   expect(await ConventionalCommitsTest_1.platformVersion, '51');
  // });
}
