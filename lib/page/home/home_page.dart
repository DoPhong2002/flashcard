import 'package:flashcards/comon/navigator.dart';
import 'package:flashcards/const/color.dart';
import 'package:flashcards/const/music.dart';
import 'package:flashcards/page/game_play/game_play_page.dart';
import 'package:flashcards/page/home/card_type.dart';
import 'package:flashcards/page/home/category_type.dart';
import 'package:flashcards/page/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/flashcard_stream.dart';
import '../../model/flashcards_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool animate = false;

  @override
  void initState() {
    if (!music.player!.playing) {
      music.musicOnOff();
    }
    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Stack(
          children: [
            const BuildBackGround(),
            CustomScrollView(
              slivers: [
                buildAppBar(),
                buildBody(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hi Baby',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Text(
                'Welcome You!  ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
              ),
              Image.asset(
                'assets/photos/welcome.png',
                width: 20,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          buildWelcome(),
          const Header(header: 'Category'),
          const SizedBox(height: 8),
          buildListCategory(),
          const Header(header: 'For You'),
          const SizedBox(height: 8),
          buildListPlay()
        ],
      ),
    );
  }

  Widget buildWelcome() {
    return Stack(
      children: [
        Container(
          height: 180,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primaryColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(6, 10),
              )
            ],
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2600),
          bottom: 0,
          right: animate ? 0 : -60,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 2600),
            opacity: animate ? 1 : 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/photos/meo.png',
                  fit: BoxFit.cover,
                  width: 180,
                )
              ],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2600),
          top: 36,
          right: animate ? 40 : 40,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 2600),
            opacity: animate ? 1 : 0,
            child: Text(
              '   Learn,\n    Step to the\n            Future',
              style: GoogleFonts.gloriaHallelujah(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2600),
          top: 0,
          left: animate ? 30 : 20,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 2600),
            opacity: animate ? 1 : 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/photos/logo_flashcards.png',
                  fit: BoxFit.cover,
                  width: 200,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildListCategory() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.topCenter,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryType(
              onTap: () {
                navigatorPushAndRemoveUntil(
                    context,
                    GamePlayPage(
                        listFlashcard: selectedBloc.listFlashcardSelected));
              },
              image: 'assets/photos/nao.png',
              title: 'Your Saved'),
          CategoryType(
              onTap: () {
                navigatorPushAndRemoveUntil(context, const SettingPage());
              },
              image: 'assets/photos/nao.png',
              title: 'Your Saved'),
          CategoryType(
              onTap: () {
                navigatorPushAndRemoveUntil(context, const SettingPage());
              },
              image: 'assets/photos/ong.png',
              title: 'Setting'),
        ],
      ),
    );
  }



  Widget buildListPlay() {
    return Column(
      children: [
        TypeCard(
          listFlashcard: model.listFlashcardAlphabet,
          image: 'assets/alphabet/logo.jpg',
          title: 'Alphabet',
        ),
        const SizedBox(height: 16),
        TypeCard(
          listFlashcard: model.listFlashcardColor,
          image: 'assets/color/logo.jpg',
          title: 'Color',
        ),
        const SizedBox(height: 16),
        TypeCard(
          listFlashcard: model.listFlashcardFamily,
          image: 'assets/family/logo.jpg',
          title: 'Family',
        ),
        const SizedBox(height: 16),
        TypeCard(
          listFlashcard: model.listFlashcardAnimal,
          image: 'assets/animal/logo.jpg',
          title: 'Animal',
        ),
        const SizedBox(height: 16),
        TypeCard(
          listFlashcard: model.listFlashcardItem,
          image: 'assets/item/logo.jpg',
          title: 'Item',
        ),
        const SizedBox(height: 90),
      ],
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 0));
    setState(() {
      animate = true;
    });
  }
}
