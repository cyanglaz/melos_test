import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:conventional_commits_test_2/conventional_commits_test_2.dart';

void main() {
  const MethodChannel channel = MethodChannel('conventional_commits_test_2');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '45';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ConventionalCommitsTest_2.platformVersion, '45');
  });
}
