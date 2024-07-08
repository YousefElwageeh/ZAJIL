import 'package:call_service/src/config/theme/colorManger.dart';
import 'package:call_service/src/features/chat/screens/audio_call/size_config.dart';
import 'package:flutter/material.dart';

import 'body.dart';

class AudioCallWithImage extends StatelessWidget {
  const AudioCallWithImage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: ColorManager.iconsColor,
      body: const Body(),
    );
  }
}
