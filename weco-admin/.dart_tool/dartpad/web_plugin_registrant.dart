// Flutter web plugin registrant file.
//
// Generated file. Do not edit.
//

// @dart = 2.13
// ignore_for_file: type=lint

import 'package:audioplayers_web/audioplayers_web.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter_tts/flutter_tts_web.dart';
import 'package:package_info_plus_web/package_info_plus_web.dart';
import 'package:platform_device_id_web/platform_device_id_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  AudioplayersPlugin.registerWith(registrar);
  FilePickerWeb.registerWith(registrar);
  FlutterTtsPlugin.registerWith(registrar);
  PackageInfoPlugin.registerWith(registrar);
  PlatformDeviceIdWebPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
