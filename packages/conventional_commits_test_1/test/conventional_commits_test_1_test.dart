import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:conventional_commits_test_1/conventional_commits_test_1.dart';

void main() {
  const MethodChannel channel = MethodChannel('conventional_commits_test_1');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '44';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ConventionalCommitsTest_1.platformVersion, '44');
  });
}
