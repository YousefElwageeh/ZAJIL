import 'dart:io';

import 'package:call_service/src/config/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Dialog exitDialog() {
  return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.exitApp.tr,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(AppStrings.No.tr),
                ),
                TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text(AppStrings.Yes.tr),
                ),
              ],
            )
          ],
        ),
      ));
}
