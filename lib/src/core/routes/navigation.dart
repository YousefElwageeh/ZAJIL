import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GO {
  static void to(Widget page) {
    GO.to(page);
  }

  static void toAndClose(Widget page) {
    Get.off(() => page);
  }

  static toNamed(
    String page, {
    dynamic arguments,
  }) {
    Get.toNamed(page, arguments: arguments);
  }

  static void toNamedAndClose(
    String page, {
    dynamic arguments,
  }) {
    Get.offNamed(
      page,
      arguments: arguments,
    );
  }

  static void toNamedAndCloseAll(
    String page, {
    dynamic arguments,
  }) {
    Get.offAllNamed(page, arguments: arguments);
  }
}
