import 'package:package_info/package_info.dart';
import 'dart:async';

Future<String> getVersionInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  return (version + "." + buildNumber);
}
