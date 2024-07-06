import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'modules/app_widget.dart';
import 'modules/service_locator.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setupLocator();
  FlutterNativeSplash.remove();
  runApp(const AppWidget());
}
