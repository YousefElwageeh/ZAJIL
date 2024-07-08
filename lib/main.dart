import 'package:call_service/app.dart';
import 'package:call_service/src/core/api/dio_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await DioFactory.getDio();

  runApp(const CallServiceApp());
}
