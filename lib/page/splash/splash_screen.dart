import 'package:flashcards/comon/data_local/hive_manager.dart';
import 'package:flashcards/const/music.dart';
import 'package:flashcards/model/flashcards_model.dart';
import 'package:flashcards/page/home/home_page.dart';
import 'package:flutter/material.dart';

import '../../bloc/flashcard_stream.dart';
import '../../const/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;
  bool _runFirstTime = true;

  void myInitState() async {
    await selectedBloc.getListProductSelected();
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      initData();
    });
    startAnimation();
    model.createListFlashcard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_runFirstTime) {
      _runFirstTime = false;
      myInitState();
    }
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.yellowAccent.withOpacity(0.9),
            Colors.orange.withOpacity(0.9),
            Colors.brown.shade300.withOpacity(0.9),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: animate ? 1 : 0,
                child: Image.asset(
                  '${baseImage}background.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.0),
                    ],
                    stops: const [
                      1,
                      0,
                    ]).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: Container(
                height: MediaQuery.of(context).size.height * 1.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.yellow.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: -30,
              left: animate ? 0 : 60,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: animate ? 1 : 0,
                child: Image.asset(
                  '${baseImage}may.png',
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: animate ? 1 : 0,
                child: Image.asset(
                  '${baseImage}logo_flashcard.png',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              bottom: 300,
              left: animate ? 30 : 0,
              height: 80,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: animate ? 1 : 0,
                child: Image.asset(
                  '${baseImage}ong.png',
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              left: -20,
              bottom: animate ? 20 : 10,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: animate ? 1 : 0,
                child: Image.asset(
                  '${baseImage}boy.png',
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              right: 30,
              bottom: 30,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: animate ? 1 : 0,
                child: const CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      animate = true;
    });
    await Future.delayed(const Duration(milliseconds: 5000));
    setState(() {
      animate = false;
    });
    await Future.delayed(const Duration(milliseconds: 1600));

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Future initData() async {
    await hive.init();
    music.isPlayMusic = await hive.getValue(userKey);
    music.backgroundMusic();

  }
}
