import 'package:flashcards/page/game_play/game_play_page.dart';
import 'package:flashcards/page/game_play/model.dart';
import 'package:flashcards/page/setting/setting_page.dart';
import 'package:flashcards/page/splash/splash_screen.dart';
import 'package:flashcards/page/home/home_page.dart';
import 'package:flashcards/tesst.dart';
import 'package:flutter/material.dart';

import 'Archive/slide/slide_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
