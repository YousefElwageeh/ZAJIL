// import 'dart:io';

// import 'package:call_service/src/core/api/app_interceptors.dart';
// import 'package:call_service/src/core/api/dio_factory.dart';
// import 'package:call_service/src/core/sharedPrefrence/shared_prefrence.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<void> initAppModule() async {
// //init the  SharedPreferences for saving the the other data

//   final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
//   Get.lazyPut<SharedPreferences>(() => sharedPrefs, fenix: true);

//   Get.lazyPut<PrefData>(() => PrefData(Get.find<SharedPreferences>()),
//       fenix: true);

// //init dio
//   await DioFactory.getDio();
//   Get.lazyPut<DioFactory>(() => DioFactory());
// }
