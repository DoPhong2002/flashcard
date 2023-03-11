 import 'package:flashcards/const/const.dart';
 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../comon/navigator.dart';
import '../../const/background.dart';
import '../../generated/l10n.dart';
import '../home/home_page.dart';

class DesignPage extends StatefulWidget {
  const DesignPage({Key? key}) : super(key: key);

  @override
  State<DesignPage> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [const BuildBackGround(), buildBody()
        ],
      ),
    );
  }
   Widget buildBody() {
    return Stack(
      children: [
        Image.asset('${baseImage}fix.png'),
        Positioned(
          top: 0,
          left: 20,
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(right: 60),
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 3,
                  spreadRadius: 3,
                  offset: Offset(-3, 0),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).comming,
                  style: GoogleFonts.gloriaHallelujah(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    navigatorPushAndRemoveUntil(context, const HomePage());
                  },
                  child: Image.asset(
                    '${baseImage}home.png',
                    width: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
