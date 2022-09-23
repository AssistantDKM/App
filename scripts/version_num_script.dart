// ignore_for_file: avoid_print

import 'dart:io';
import 'package:git/git.dart';
import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';

Future<void> main() async {
  final pubSpecFile = File('./pubspec.yaml');
  String pubSpecString = await pubSpecFile.readAsString();
  Pubspec doc = Pubspec.parse(pubSpecString);

  String buildName = '${doc.version?.major}.';
  buildName += '${doc.version?.minor}.';
  buildName += doc.version?.patch.toString() ?? '0';

  String buildNum = (doc.version?.build[0] ?? '').toString();

  final gitDir = await GitDir.fromExisting(p.current);
  final commit = await gitDir.commits();

  await writeBuildNumFile(buildNum, buildName, commit.keys.first);
  print('Done');
}

Future writeBuildNumFile(
  String buildNum,
  String buildName,
  String latestCommit,
) async {
  if (buildNum.isEmpty) return;
  print('Writing to app_version_num.dart');
  final file = File('./lib/env/app_version_num.dart');
  String contents = 'const appsBuildNum = $buildNum;\n';
  contents += 'const appsBuildName = \'$buildName\';\n';
  contents += 'const appsCommit = \'$latestCommit\';';
  await file.writeAsString(contents);
  print('Writing to file Success');
}
