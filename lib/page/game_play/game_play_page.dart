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
import '../../model/flashcards_model.dart';

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
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/photos/hinhnengame.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: -50,
              right: -50,
              child: Image.asset('assets/photos/may.png'),
            ),
            Positioned(
              top: 10,
              left: -50,
              child: Image.asset('assets/photos/may.png'),
            ),
            buildGamePlay()
          ],
        ),
      ),
    );
  }

  Widget buildGamePlay() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.listFlashcard.isNotEmpty) ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    navigatorPushAndRemoveUntil(context, const HomePage());
                  },
                  child: Image.asset(
                    'assets/photos/buttomhome.png',
                    width: 60,
                  ),
                ),
                buildRandom()
              ],
            ),
            const SizedBox(height: 24),
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
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        flashcard.image!,
                                        fit: BoxFit.fill,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.45,
                                        width:
                                            MediaQuery.of(context).size.width,
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
            // ignore: equal_elements_in_set
            const SizedBox(height: 24),
            buildController(),
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
            'assets/photos/next2.png',
            width: 60,
          ),
        ),
        const SizedBox(width: 32),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => playAudio(),
          child: Image.asset(
            'assets/photos/loa2.png',
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
            'assets/photos/next.png',
            width: 60,
          ),
        ),
      ],
    );
  }

  Widget buildHeart(Flashcard flashcard) {
    return flashcard.isClick
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: const Icon(
              Icons.favorite_outlined,
              color: Color(0xFFD30501),
              size: 40,
            ),
            onTap: () {
              music.btnSound();
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
              music.btnSound();
              onAdd(flashcard);
            },
          );
  }

  Widget buildRandom() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        random();
      },
      child: Image.asset(
        'assets/photos/random.png',
        width: 80,
      ),
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
    if (slideBloc.activeIndex > intValue) {
      slideBloc.getIndex(intValue);
      player?.setAsset(widget.listFlashcard[slideBloc.activeIndex].audio!);
      offsetStream.offsetPrevious();
      await player!.play();
    } else if (slideBloc.activeIndex < intValue) {
      slideBloc.getIndex(intValue);
      player?.setAsset(widget.listFlashcard[slideBloc.activeIndex].audio!);
      offsetStream.offsetNext();
      await player!.play();
    } else {
      slideBloc.getIndex(intValue);
      player?.setAsset(widget.listFlashcard[slideBloc.activeIndex].audio!);
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
    player?.setAsset(widget.listFlashcard[slideBloc.activeIndex].audio!);
    await player!.play();
  }
}
