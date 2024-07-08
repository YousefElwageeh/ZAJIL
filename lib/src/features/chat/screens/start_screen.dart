import 'package:call_service/src/config/theme/colorManger.dart';
import 'package:call_service/src/config/utils/assetsManger.dart';
import 'package:call_service/src/core/api/constant&endPoints.dart';
import 'package:call_service/src/core/api/dio_factory.dart';
import 'package:call_service/src/core/routes/navigation.dart';
import 'package:call_service/src/core/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        title: CircleAvatar(
          backgroundColor: Colors.transparent,
          // backgroundImage: AssetImage(
          //   AssetsManger.logo,
          // ),
          radius: 25,
          child: ClipOval(
            child: Image.asset(
              AssetsManger.logo,
              fit: BoxFit.cover,
            ),
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(100),
          ),
        ),
      ),
      backgroundColor: ColorManager.iconsColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  pageButton(
                      text: "Start Chat",
                      onPressed: () {
                        GO.toNamed(Routes.chatRoute);
                      }),
                  const Spacer(),
                  pageButton(
                      text: "Start Voice Call",
                      onPressed: () {
                        GO.toNamed(Routes.callRoute);
                      }),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  pageButton(text: 'Language'),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManager.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownMenu(
                        onSelected: (value) {
                          Constants.language = value ?? 'ar';
                          DioFactory.getDio();
                        },
                        inputDecorationTheme: InputDecorationTheme(
                          constraints: BoxConstraints.tight(
                            const Size(150, 45),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        initialSelection: 'ar',
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(value: 'ar', label: 'Arabic'),
                          DropdownMenuEntry(value: 'en', label: 'English'),
                          DropdownMenuEntry(value: 'zh', label: 'Chinese'),
                          DropdownMenuEntry(value: 'hi', label: 'Hindi'),
                          DropdownMenuEntry(value: 'es', label: 'Spanish'),
                        ]),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageButton({
    required String text,
    void Function()? onPressed,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: WidgetStateProperty.all(const Size(150, 45)),
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              color: Colors.black,
            ),
          )),
      onPressed: onPressed ?? () {},
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }
}
