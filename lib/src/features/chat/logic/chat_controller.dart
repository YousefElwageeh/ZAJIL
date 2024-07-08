import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:call_service/src/core/api/constant&endPoints.dart';
import 'package:call_service/src/core/app%20states/app_states.dart';
import 'package:call_service/src/features/chat/data/data_source/data_source.dart';
import 'package:call_service/src/features/chat/data/model/message_model.dart';
import 'package:call_service/src/features/chat/data/repo_implmener/chat_repo_implmenter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatController extends GetxController {
  @override
  onInit() {
    super.onInit();
    chatID = generateRandomId();
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        isAISpeaking.value = false;
      }
    });
    log(chatID);
  }

  ChatRepoImpl chatRepoImpl = ChatRepoImpl(chatDataSource: ChatDataSource());

  List<MessageModel> messages = [];
  ScrollController scrollController = ScrollController();

  stt.SpeechToText speech = stt.SpeechToText();

  final List<stt.LocaleName> _localeNames = [];
  final String _currentLocaleId = '';
  String lastError = '';

  Future<void> listen() async {
    try {
      bool available = await speech.initialize(
          onStatus: statusListener,
          onError: errorListener,
          debugLogging: false);

      if (available) {
        isUserSpeaking.value = true;
        // // Get the list of languages installed on the supporting platform so they
        // // can be displayed in the UI for selection by the user.
        // _localeNames = await speech.locales();

        // var systemLocale = await speech.systemLocale();
        // _currentLocaleId = 'ar_EG';
        await speech.listen(
            onResult: resultListener,
            localeId: Constants.language,
            listenOptions: stt.SpeechListenOptions(
              listenMode: stt.ListenMode.dictation,
              //   onDevice: true,
            ));
      } else {
        print("The user has denied the use of speech recognition.");
      }
    } catch (e) {
      await speech.stop();
    }
  }

  Future<void> statusListener(String status) async {
    log('Received listener status: $status, listening: ${speech.isListening}');
    if (speech.isListening == false && status == 'notListening') {
      await speech.cancel();
    }
  }

  void errorListener(SpeechRecognitionError error) {
    log('Received error status: $error, listening: ${speech.isListening}');

    lastError = '${error.errorMsg} - ${error.permanent}';
  }

  void resultListener(SpeechRecognitionResult result) {
    log('Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    lastWords = '${result.recognizedWords} - ${result.finalResult}';

    if (speech.isListening == false && lastWords.isNotEmpty) {
      sendVoice(message: lastWords.replaceAll('- true', ''));
    }
  }

  var micLevel = 0.0;

  String lastWords = '';

  RxBool isUserSpeaking = false.obs;
  RxBool isAISpeaking = false.obs;

  Future<void> stopListening() async {
    await speech.stop();
    isUserSpeaking.value = false;
  }

  RxBool isSpeakerWorking = false.obs;

  void turnSpeaker() {
    isSpeakerWorking.value = !isSpeakerWorking.value;
  }

  Future<void> cancelCall() async {
    await speech.stop();

    chatRepoImpl.closeOrder(chatId: chatID).then((value) {
      value.fold(
          (failure) => () {
                AppStates.ErrorState(failure.message);
              },
          (data) async {});
    });
    Get.back();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  sendVoice({
    required String message,
  }) async {
    chatRepoImpl.sendVoice(message: message, chatId: chatID).then((value) {
      value.fold(
          (failure) => () {
                AppStates.ErrorState(failure.message);
              }, (data) async {
        isAISpeaking.value = true;

        _audioPlayer.setUrl(data.message);

        await _audioPlayer.play();
      });
    });
  }

  sendMessage(String messageContent) {
    var message = MessageModel(isSender: true, message: messageContent);
    messages.add(message);
    update();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
      );
    });

    chatRepoImpl
        .sendMessage(message: messageContent, chatId: chatID)
        .then((value) {
      value.fold(
          (failure) => () {
                AppStates.ErrorState(failure.message);
              }, (data) {
        var message = MessageModel(isSender: false, message: data.message);
        messages.add(message);
        update();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent,
        );
      });
    });
  }

  String chatID = '';
  String generateRandomId({int length = 10}) {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    math.Random random = math.Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join('');
  }
}
