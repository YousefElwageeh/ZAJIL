// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:call_service/src/config/theme/colorManger.dart';
import 'package:call_service/src/config/theme/hexcolor.dart';
import 'package:call_service/src/config/utils/AppStrings.dart';
import 'package:call_service/src/config/utils/assetsManger.dart';
import 'package:call_service/src/features/chat/logic/chat_controller.dart';
import 'package:call_service/src/features/chat/screens/widgets/message_bar.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: HexColor('c7fff6'),
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            // backgroundImage: AssetImage(
            //   AssetsManger.logo,
            // ),
            radius: 10,
            child: ClipOval(
              child: Image.asset(
                AssetsManger.logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        centerTitle: false,
        title: const Text(
          AppStrings.CallService,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        shadowColor: Colors.black,
        elevation: 5,
        actions: [
          // IconButton(
          //     onPressed: () {
          //       GO.toNamed(Routes.callRoute);
          //     },
          //     icon: Icon(
          //       Icons.call,
          //       size: 30,
          //       color: ColorManager.iconsColor,
          //     )

          //     ),
          // IconButton(
          //     onPressed: () {
          //       GO.toNamed(Routes.callRoute);
          //     },
          //     icon: Icon(
          //       Icons.video_call,
          //       size: 30,
          //       color: ColorManager.iconsColor,
          //     )),
          IconButton(
              onPressed: () {
                //     GO.toNamed(Routes.callRoute);
              },
              icon: Icon(
                Icons.more_vert,
                size: 30,
                color: ColorManager.iconsColor,
              )),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GetBuilder<ChatController>(
              init: ChatController(),
              initState: (_) {},
              builder: (controller) {
                return Expanded(
                  child: ListView.separated(
                    controller: controller.scrollController,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      return BubbleSpecialThree(
                        text: controller.messages[index].message ?? '',
                        color: controller.messages[index].isSender
                            ? HexColor('372b46')
                            : HexColor('e2e2f7'),
                        tail: true,
                        isSender: controller.messages[index].isSender,
                        textStyle: controller.messages[index].isSender
                            ? const TextStyle(color: Colors.white, fontSize: 16)
                            : const TextStyle(
                                color: Colors.black, fontSize: 16),
                      );
                    },
                  ),
                );
              },
            ),

            // BubbleNormalAudio(
            //   color: const Color(0xFFE8E8EE),
            //   duration: duration.inSeconds.toDouble(),
            //   position: position.inSeconds.toDouble(),
            //   isPlaying: isPlaying,
            //   isLoading: isLoading,
            //   isPause: isPause,
            //   onSeekChanged: (value) {},
            //   onPlayPauseButtonClick: () {},
            //   sent: true,
            // ),

            CustomMessageBar(
              onSend: (String messageTExt) {
                controller.sendMessage(messageTExt);
              },
              sendButtonColor: ColorManager.iconsColor,
              messageBarColor: ColorManager.primaryColor,
              onTextChanged: (p0) {},
              textFieldTextStyle:
                  const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      )),
    );
  }
}
