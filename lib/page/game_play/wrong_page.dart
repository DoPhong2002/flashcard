import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../comon/navigator.dart';
import '../../const/const.dart';
import '../../generated/l10n.dart';
import '../home/home_page.dart';

class WrongPage extends StatelessWidget {
  const WrongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 150,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(right: 60),
          height: 140,
          width: MediaQuery.of(context).size.width * 0.7,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).savecard,
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
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              alignment: Alignment.topRight,
              width: 200,
              child: Image.asset(
                '${baseImage}wrong.png',
              ),
            ),
          ],
        )
      ],
    );
  }
}
