import 'package:avatar_glow/avatar_glow.dart';
import 'package:call_service/src/config/theme/colorManger.dart';
import 'package:call_service/src/config/utils/AppStrings.dart';
import 'package:call_service/src/config/utils/assetsManger.dart';
import 'package:call_service/src/config/utils/common_widgets/rounded_button.dart';
import 'package:call_service/src/features/chat/logic/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var controller = Get.put(ChatController());
  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  @override
  void initState() {
    stopWatchTimer.onStartTimer();
    super.initState();
  }

  @override
  void dispose() {
    stopWatchTimer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            AppStrings.IncomingCall,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 25,
          ),
          Obx(() => AvatarGlow(
                glowRadiusFactor: 0.3,
                animate: controller.isAISpeaking.value,
                glowColor: Colors.white,
                child: Image.asset(
                  AssetsManger.robothead,
                  width: 200,
                  height: 200,
                ),
              )),
          const SizedBox(
            height: 30,
          ),
          // CountTimer(
          //   format: CountTimerFormat.minutesSeconds,
          //   controller: CountTimerController(),
          //   timeTextStyle: const TextStyle(
          //     color: Colors.white,
          //   ),
          //   colonsTextStyle: const TextStyle(fontSize: 30),
          //   spacerWidth: 0,
          //   descriptionTextStyle: const TextStyle(color: Colors.transparent),
          // ),
          StreamBuilder<int>(
            stream: stopWatchTimer.rawTime,
            initialData: 0,
            builder: (context, snap) {
              final value = snap.data;
              final displayTime = StopWatchTimer.getDisplayTime(value!,
                  milliSecond: false, hours: false);
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      displayTime,
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8),
                  //   child: Text(
                  //     value.toString(),
                  //     style: const TextStyle(
                  //         fontSize: 16,
                  //         fontFamily: 'Helvetica',
                  //         fontWeight: FontWeight.w400),
                  //   ),
                  // ),
                ],
              );
            },
          ),

          const Spacer(),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton(
                    press: () {
                      controller.cancelCall();
                    },
                    color: const Color(0xFFFF1E46),
                    iconColor: Colors.white,
                    iconSrc: IconMager.call_end,
                  ),
                  AvatarGlow(
                    glowRadiusFactor: 0.4,
                    animate: controller.isUserSpeaking.value,
                    glowColor: ColorManager.primaryColor,
                    child: HoldTimeoutDetector(
                      onTimeout: () {},
                      onTimerInitiated: () async {
                        await controller.listen();
                      },
                      onCancel: () async {
                        await controller.stopListening();
                      },
                      holdTimeout: const Duration(hours: 1),
                      child: RoundedButton(
                        color: controller.isUserSpeaking.value
                            ? ColorManager.primaryColor
                            : Colors.white,
                        press: () async {},
                        iconSrc: IconMager.mic,
                      ),
                    ),
                  ),

                  // RoundedButton(
                  //   color: controller.isSpeakerWorking.value
                  //       ? Colors.white
                  //       : Colors.red,
                  //   press: () {
                  //     controller.turnSpeaker();
                  //   },
                  //   iconSrc: IconMager.Volume,
                  // ),
                ],
              )),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
