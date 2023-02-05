import 'dart:math';

import 'package:flashcards/Archive/slide/animation_widget.dart';
import 'package:flashcards/comon/navigator.dart';
import 'package:flashcards/const/music.dart';
   import 'package:flashcards/page/game_play/wrong_page.dart';
import 'package:flashcards/page/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:swipe/swipe.dart';
import '../../bloc/flashcard_stream.dart';
import '../../bloc/slide_stream.dart';
import '../../bloc/offset_stream.dart';
import '../../const/const.dart';
 import '../../service/category.dart';

class GamePlayPage extends StatefulWidget {
  final List<Flashcard> listFlashcard;

  const GamePlayPage({super.key, required this.listFlashcard});

  @override
  State<GamePlayPage> createState() => _GamePlayPageState();
}

class _GamePlayPageState extends State<GamePlayPage> {
  AudioPlayer? player;

  @override
  void initState() {
    music.stopMusic();
    slideBloc.getIndex(0);
    player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            '${baseImage}background.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset('${baseImage}may.png'),
          ),
          Positioned(
            top: 10,
            left: -50,
            child: Image.asset('${baseImage}may.png'),
          ),
          buildGamePlay()
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            navigatorPushAndRemoveUntil(context, const HomePage());
          },
          child: Image.asset(
            '${baseImage}home.png',
            width: 50,
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            random();
          },
          child: Image.asset(
            '${baseImage}random.png',
            width: 70,
          ),
        )
      ],
    );
  }

  Widget buildGamePlay() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.listFlashcard.isNotEmpty) ...{
            const SizedBox(),
            buildAppBar(),
            Swipe(
              child: StreamBuilder<Offset>(
                stream: offsetStream.setOffsetStream,
                builder: (context, snapshot) {
                  return SlideWidget(
                    key: UniqueKey(),
                    offset: offsetStream.offset,
                    child: FadeInWidget(
                      key: UniqueKey(),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.6,
                        color: const Color(0xFFFFBDB0),
                        child: StreamBuilder<int>(
                          stream: slideBloc.indexStream,
                          builder: (context, snapshot) {
                            final flashcard =
                                widget.listFlashcard[slideBloc.activeIndex];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(30),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                        flashcard.urlPicture!,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    StreamBuilder(
                                      stream: selectedBloc.selectedStream,
                                      builder: (context, snapshot) {
                                        return buildHeart(flashcard);
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  '${flashcard.name}',
                                  style: GoogleFonts.akayaTelivigala(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              onSwipeLeft: () {
                next();
              },
              onSwipeRight: () {
                previous();
              },
            ),
            buildController(),
            const SizedBox(height: 0),
          } else ...{
            const WrongPage()
          },
        ],
      ),
    );
  }

  Widget buildController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            previous();
            playAudio();
          },
          child: Image.asset(
            '${baseImage}next2.png',
            width: 60,
          ),
        ),
        const SizedBox(width: 32),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => playAudio(),
          child: Image.asset(
            '${baseImage}loa2.png',
            width: 120,
          ),
        ),
        const SizedBox(width: 32),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            next();
            playAudio();
          },
          child: Image.asset(
            '${baseImage}next.png',
            width: 60,
          ),
        ),
      ],
    );
  }

  Widget buildHeart(Flashcard flashcard) {
    return flashcard.isClick!
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: const Icon(
              Icons.favorite_outlined,
              color: Color(0xFFD30501),
              size: 40,
            ),
            onTap: () {
              onRemove(flashcard);
            },
          )
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: const Icon(
              color: Color(0xFFF1E7A2),
              Icons.favorite_outlined,
              size: 40,
            ),
            onTap: () {
              onAdd(flashcard);
            },
          );
  }

  void onRemove(Flashcard flashcard) {
    flashcard.isClick = false;
    int a = slideBloc.activeIndex;
    selectedBloc.onRemoveItemSelected(flashcard);

    if (widget.listFlashcard == selectedBloc.listFlashcardSelected) {
      if (selectedBloc.listFlashcardSelected.isEmpty) {
        setState(() {});
      }
      if (a == selectedBloc.listFlashcardSelected.length && a > 0) {
        slideBloc.getIndex(a - 1);
      } else if (a == 0 && selectedBloc.listFlashcardSelected.isEmpty) {
        return;
      } else {
        slideBloc.getIndex(a);
      }
    }
  }

  void onAdd(Flashcard flashcard) {
    flashcard.isClick = true;
    selectedBloc.onAddItemSelected(flashcard);
  }

  void random() async {
    int intValue = Random().nextInt(widget.listFlashcard.length);
    if (intValue == slideBloc.activeIndex) {
      intValue = Random().nextInt(widget.listFlashcard.length);
    } else if (slideBloc.activeIndex > intValue) {
      slideBloc.getIndex(intValue);
      player?.setUrl(widget.listFlashcard[slideBloc.activeIndex].audio!);
      offsetStream.offsetPrevious();
      await player!.play();
    } else {
      slideBloc.getIndex(intValue);
      player?.setUrl(widget.listFlashcard[slideBloc.activeIndex].audio!);
      offsetStream.offsetNext();
      await player!.play();
    }
  }

  void next() {
    if (slideBloc.activeIndex < widget.listFlashcard.length - 1) {
      slideBloc.next();
      offsetStream.offsetNext();
    }
  }

  void previous() {
    if (slideBloc.activeIndex > 0) {
      slideBloc.previous();
      offsetStream.offsetPrevious();
    }
  }

  void playAudio() async {
    player?.setUrl(widget.listFlashcard[slideBloc.activeIndex].audio!);
    await player!.play();
  }
}
