import 'package:flashcards/comon/data_local/hive_manager.dart';
import 'package:flashcards/const/const.dart';
import 'package:flashcards/const/music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../bloc/app_state/app_state.dart';
import '../../comon/select_item_dialog.dart';
import '../../comon/navigator.dart';
 import '../../const/background.dart';
import '../../generated/l10n.dart';
import '../../model/item_select.dart';
import '../home/home_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var notifier1 = ValueNotifier<bool>(true);
  var notifier2 = ValueNotifier<bool>(true);
  var notifier3 = ValueNotifier<bool>(true);

  @override
  void initState() {

    hive.getValue(music.isPlayMusic.toString());
    notifier1.value = music.isPlayMusic;
    notifier1.addListener(() {
      setState(() {
        if (notifier1.value) {
          music.isPlayMusic = true;
          hive.setValue(userKey, true);
          music.playMusic();
        } else {
          music.isPlayMusic = false;
          hive.setValue(userKey, false);
          music.stopMusic();
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [const BuildBackGround(), buildSetting()],
      ),
    );
  }

  Widget buildSetting() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          '${baseImage}setting1.png',
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.08,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).music,
                      style: GoogleFonts.gloriaHallelujah(
                        textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    AdvancedSwitch(
                      controller: notifier1,
                      enabled: true,
                      height: 40,
                      width: 100,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      inactiveColor: primaryColor,
                      inactiveChild: Text(
                        'OFF',
                        style: GoogleFonts.gloriaHallelujah(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      activeChild: Text(
                        'ON',
                        style: GoogleFonts.gloriaHallelujah(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      thumb: ValueListenableBuilder<bool>(
                        valueListenable: notifier1,
                        builder: (_, value, __) {
                          return value
                              ? const Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                )
                              : const Icon(Icons.music_off);
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).sound,
                      style: GoogleFonts.gloriaHallelujah(
                        textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    AdvancedSwitch(
                      controller: notifier3,
                      enabled: true,
                      height: 40,
                      width: 100,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      inactiveColor: primaryColor,
                      inactiveChild: Text(
                        'OFF',
                        style: GoogleFonts.gloriaHallelujah(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      activeChild: Text(
                        'ON',
                        style: GoogleFonts.gloriaHallelujah(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      thumb: ValueListenableBuilder<bool>(
                        valueListenable: notifier3,
                        builder: (_, value, __) {
                          return value
                              ? const Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                )
                              : const Icon(Icons.music_off);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).language,
                      style: GoogleFonts.gloriaHallelujah(
                        textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final map = {"vi": "Tiếng Việt", "en": "Tiếng Anh"};
                        final languages = S.delegate.supportedLocales;
                        final items = <ItemSelect<Locale>>[];
                        for (final language in languages) {
                          items.add(ItemSelect(
                              language, map[language.languageCode].toString()));
                        }
                        showSelectItemDialog(
                          context: context,
                          items: items,
                          onConfirm: (value) {
                            final appState = context.read<AppState>();
                            appState.changeLanguageCode(value.value.languageCode);
                          },
                        );
                      },
                      child: Image.asset("${baseImage}language.png", width: 40,),
                    ),

                  ],
                ),
              ),


            ],
          ),
        ),

        Positioned(
          bottom: 30,
          child: btnBack(),
        ),


      ],
    );
  }

  Widget btnBack() {
    return InkWell(
      onTap: () {
        navigatorPushAndRemoveUntil(context, const HomePage());
      },
      child: Image.asset(
        'assets/photos/home.png',
        width: 50,
      ),
    );
  }
}
