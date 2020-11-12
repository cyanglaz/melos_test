#import "ConventionalCommitsTest_1Plugin.h"
#if __has_include(<conventional_commits_test_1/conventional_commits_test_1-Swift.h>)
#import <conventional_commits_test_1/conventional_commits_test_1-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "conventional_commits_test_1-Swift.h"
#endif

@implementation ConventionalCommitsTest_1Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftConventionalCommitsTest_1Plugin registerWithRegistrar:registrar];
}
@end
