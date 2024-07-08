// ignore_for_file: constant_identifier_names

import 'package:call_service/src/features/chat/screens/audio_call/audio_call_with_image_screen.dart';
import 'package:call_service/src/features/chat/screens/chat_screen.dart';
import 'package:call_service/src/features/chat/screens/start_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const String splashRoute = "/";
  static const String chatRoute = "/chat";
  static const String callRoute = "/call";
  static const String StartScreenRoute = "/StartScreenRoute";

  static final List<GetPage<dynamic>> routes = [
    GetPage(
        name: StartScreenRoute,
        page: () {
          // FlutterNativeSplash.remove();
          return const StartScreen();
        }),
    GetPage(
        name: chatRoute,
        page: () {
          // FlutterNativeSplash.remove();
          return const ChatScreen();
        }),
    GetPage(
        name: callRoute,
        page: () {
          // FlutterNativeSplash.remove();
          return const AudioCallWithImage();
        }),
  ];
}
