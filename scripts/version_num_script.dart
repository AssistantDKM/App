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

  await updatePubspecFile(pubSpecString, buildName);
  await writeBuildNumFile(buildNum, buildName, commit.keys.first);
  await writeEnvScript(buildName, buildNum);
  await updateInnoFile(buildName);
  print('Done');
}

Future writeBuildNumFile(
  String? buildNum,
  String buildName,
  String latestCommit,
) async {
  if (buildNum == null || buildNum.isEmpty) return;
  print('Writing to app_version_num.dart');
  final file = File('./lib/env/app_version_num.dart');
  String contents = 'const appsBuildNum = $buildNum;\n';
  contents += 'const appsBuildName = \'$buildName\';\n';
  contents += 'const appsCommit = \'$latestCommit\';';
  await file.writeAsString(contents);
  print('Writing to file Success');
}

Future updatePubspecFile(String doc, String buildNum) async {
  RegExp msixVersionReg = RegExp(r'msix_version:\s\d*\.\d*\.\d*\.\d*');
  final newDoc = doc.replaceAllMapped(msixVersionReg, (match) {
    return 'msix_version: $buildNum.0';
  });

  final pubFile = File('./pubspec.yaml');
  await pubFile.writeAsString(newDoc);
  print('Writing to pubFile Success');
}

Future updateInnoFile(String buildName) async {
  final innoFile = File('./assistantDKM.iss');
  String innoFileString = await innoFile.readAsString();

  RegExp appVersionReg = RegExp(r'#define\sMyAppVersion\s\"\d*\.\d*\.\d*\"');
  final newDoc = innoFileString.replaceAllMapped(appVersionReg, (match) {
    return '#define MyAppVersion "$buildName"';
  });

  await innoFile.writeAsString(newDoc);
  print('Writing to innoSetup file Success');
}

Future writeEnvScript(String buildName, String buildNum) async {
  print('Writing to loadEnv.sh');
  final envScriptFile = File('./scripts/loadEnv.sh');
  String contents = 'export FLUTTER_BUILD_NAME=$buildName\n';
  contents += 'export FLUTTER_BUILD_NUMBER=$buildNum\n';
  await envScriptFile.writeAsString(contents);
  print('Writing to loadEnv.sh success');
}
