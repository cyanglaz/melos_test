/*
 * Copyright (c) 2016-present Invertase Limited & Contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this library except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yamlicious/yamlicious.dart';

import '../common/package.dart';
import '../common/utils.dart' as utils;
import '../common/workspace.dart';
import '../pub/pub_file.dart';

class PubspecLockPubFile extends PubFile {
  Map<String, Map> _packages;

  Map<String, Map> _yamlParsed;

  Future<Map<String, Map>> get packages async {
    if (_packages != null) return _packages;

    var input = await File(filePath).readAsString();

    _yamlParsed =
        Map.from(json.decode(json.encode(loadYaml(input))) as LinkedHashMap);

    if (_yamlParsed['packages'] != null) {
      _packages = Map.from(_yamlParsed['packages'] as LinkedHashMap);
    } else {
      _packages = {};
    }

    return _packages;
  }

  PubspecLockPubFile._(String rootDirectory)
      : super(rootDirectory, 'pubspec.lock');

  factory PubspecLockPubFile.fromDirectory(String fileRootDirectory) {
    return PubspecLockPubFile._(fileRootDirectory);
  }

  static Future<PubspecLockPubFile> fromWorkspacePackage(
      MelosWorkspace workspace, MelosPackage package) async {
    PubspecLockPubFile workspaceFile =
        PubspecLockPubFile.fromDirectory(workspace.melosToolPath);
    Map<String, Map> packagePackages = {};
    Map<String, Map> workspacePackages = await workspaceFile.packages;
    Set<String> dependencyGraph = await package.getDependencyGraph();

    workspacePackages.forEach((name, packageMap) {
      if (!dependencyGraph.contains(name) && name != package.name) {
        return;
      }

      var pluginPackage = json.decode(json.encode(packageMap)) as Map;

      if (pluginPackage['description'] != null &&
          pluginPackage['description'].runtimeType != String &&
          pluginPackage['source'] == 'path') {
        var path = pluginPackage['description']['path'] as String;
        var relative = pluginPackage['description']['relative'] as bool;

        if (relative) {
          // path is relative to the workspace root, make it relative to the package
          path = utils.relativePath(
              '${workspace.melosToolPath}${Platform.pathSeparator}$path',
              package.path);
        } else {
          // path is fully qualified already, so we'll just make it relative
          path = utils.relativePath(path, package.path);
        }

        pluginPackage['description']['path'] = path;
        pluginPackage['description']['relative'] = true;
      }

      packagePackages[name] = pluginPackage;
    });

    var packageFile = PubspecLockPubFile._(package.path);
    packageFile._packages = packagePackages;
    packageFile._yamlParsed = Map.from(workspaceFile._yamlParsed);
    packageFile._yamlParsed['packages'] = packagePackages;
    return packageFile;
  }

  @override
  String toString() {
    var string = '# Generated by pub';
    string += '\n# See https://dart.dev/tools/pub/glossary#lockfile\n';
    string += toYamlString(_yamlParsed);
    return string;
  }
}
