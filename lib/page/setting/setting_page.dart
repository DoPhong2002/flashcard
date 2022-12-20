import 'package:flashcards/comon/data_local/hive_manager.dart';
import 'package:flashcards/const/music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../comon/navigator.dart';
import '../../const/color.dart';
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
  bool checked = false;

  @override
  void initState() {
    // if (music.player!.playing) {
    //   notifier1.value = true;
    // } else {
    //   notifier1.value = false;
    // }
    notifier1.value = music.isPlayMusic;
    notifier1.addListener(() {
      setState(() {
        if (notifier1.value) {
          music.isPlayMusic = true;
          hive.setValue(music.isPlayMusic, true);
          music.backgroundMusic();
        } else {
          music.isPlayMusic = false;
          hive.setValue(music.isPlayMusic, false);
          print('check: ${music.isPlayMusic}');
          music.backgroundMusic();
        }
      });
    });
    notifier2.addListener(() {
      setState(() {
        if (notifier2.value) {
          music.isPlaySound = true;
          music.btnSound();
        } else {
          music.isPlaySound = false;
          music.btnSound();
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
        children: [
          const BuildBackGround(),
          buildSetting()
          // Container(height: 50,width: 50,color: Colors.red,)
        ],
      ),
    );
  }

  Widget buildSetting() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          'assets/photos/setting1.png',
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
                      'Music',
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
                      'Music',
                      style: GoogleFonts.gloriaHallelujah(
                        textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    AdvancedSwitch(
                      controller: notifier2,
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
                        valueListenable: notifier2,
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
                      'Music',
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
            ],
          ),
        ),
        Positioned(
          bottom: 30,
          child: buildBottomHome(),
        )
      ],
    );
  }

  Widget buildBottomHome() {
    return InkWell(
      onTap: () {
        navigatorPushAndRemoveUntil(context, const HomePage());
      },
      child: Image.asset(
        'assets/photos/ok.png',
        width: 80,
      ),
    );
  }
}
