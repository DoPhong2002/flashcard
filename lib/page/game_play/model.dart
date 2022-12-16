import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flashcards/comon/navigator.dart';
import 'package:flashcards/page/home/home_page.dart';
import 'package:flashcards/tesst.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:swipe/swipe.dart';

Color colorPrimary = Color.fromRGBO(45, 45, 45, 1);
Color colorSecondary = Color.fromRGBO(0, 255, 128, 1);
Color colorShawdow = Color.fromRGBO(0, 135, 100, 1);
String imagePath = 'assets/photos/wrong.png';

class Appaa extends StatefulWidget {
  @override
  State<Appaa> createState() => _AppaaState();
}

class _AppaaState extends State<Appaa> {
  bool animate = false;
  late Timer timer;
  var value = 0;
  final List a = [
    'assets/alphabet/a.jpg',
    'assets/alphabet/b.jpg',
    'assets/alphabet/c.jpg',
    'assets/alphabet/d.jpg',
    'assets/alphabet/e.jpg',
  ];
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: GestureDetector(
        //   child: Stack(
        //     fit: StackFit.expand,
        //     children: [
        //       Image.network(
        //         'https://digwallpapers.com/wallpapers/full/1/5/7/10838-3840x2160-santorini-wallpaper-photo-desktop-4k.jpg',
        //         fit: BoxFit.cover,
        //       ),
        //       ColorFiltered(
        //         colorFilter: ColorFilter.mode(
        //             Colors.black.withOpacity(0.8), BlendMode.srcOut),
        //         // This one will create the magic
        //         child: Stack(
        //           fit: StackFit.expand,
        //           children: [
        //             Container(
        //               decoration: const BoxDecoration(
        //                   color: Colors.blue,
        //                   backgroundBlendMode: BlendMode.dstOut), // This one will handle background + difference out
        //             ),
        //             Align(
        //               alignment: Alignment.topCenter,
        //               child: Container(
        //                 margin: const EdgeInsets.only(top: 80),
        //                 height: 200,
        //                 width: 200,
        //                 decoration: BoxDecoration(
        //                   color: Colors.red,
        //                   borderRadius: BorderRadius.circular(100),
        //                 ),
        //               ),
        //             ),
        //             const Center(
        //               child: Text(
        //                 'Hello World',
        //                 style: TextStyle(fontSize: 70, fontWeight: FontWeight.w600),
        //               ),
        //             ),
        //             IgnorePointer(
        //               child: Container(
        //                 width: 100,
        //                 height: 100,
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        ///
        // Center(
        //   child: GestureDetector(
        //     child: Container(
        //       width: 200,
        //       height: 200,
        //       color: Colors.blue,
        //       child: Center(
        //           child: Text(
        //             'value $value',
        //             style: TextStyle(fontSize: 40),
        //           )),
        //     ),
        //     onTapDown: (TapDownDetails details) {
        //       print('down');
        //       timer = Timer.periodic(Duration(milliseconds: 500), (t) {
        //         setState(() {
        //           value++;
        //         });
        //         print('value $value');
        //       });
        //     },
        //     onTapUp: (TapUpDetails details) {
        //       print('up');
        //       timer.cancel();
        //     },
        //     onTapCancel: () {
        //       print('cancel');
        //       timer.cancel();
        //     },
        //   ),
        // ),
        ///test animated
        // Swipe(
        //           //   child: SlideWidget(
        //           //     child: Container(
        //           //       margin: const EdgeInsets.all(14),
        //           //       width: MediaQuery.of(context).size.width,
        //           //       color: const Color(0xFFFCA7AA),
        //           //       child: Container(
        //           //         margin: const EdgeInsets.all(14),
        //           //         width: double.infinity,
        //           //         decoration: BoxDecoration(
        //           //           color: Colors.white,
        //           //           borderRadius: BorderRadius.circular(8),
        //           //         ),
        //           //         child: Image.asset(a[index]),
        //           //       ),
        //           //     ),
        //           //   ),
        //           //   onSwipeLeft: () {
        //           //     onSwipeLeft();
        //           //   },
        //           //   onSwipeRight: () {
        //           //     onSwipeRight();
        //           //   },
        //           // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () async{
                  await Future.delayed(const Duration(milliseconds: 500));

                  setState(() {
                    animate = true;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: animate ? 0 : 175,
                  width: animate ? 0 : 175,
                  decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: colorShawdow,
                            blurRadius: 8,
                            spreadRadius: 4)
                      ]),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: animate ? 400 : 200,
                    height: animate ? 400 : 200,
                    child: Image.asset(
                      imagePath,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
        //   Center(
        //     child: AnimatedContainer(
        //       duration: Duration(milliseconds: 500),
        //       width: animate ? 400 : 200,
        //       height: animate ? 400 : 200,
        //       child: Image.asset(imagePath),
        //     ),
        //   ),
        // ),

        ///test dialog
        // Center(
        //   child: AnimatedButton(
        //     text: 'adad',
        //     pressEvent: (){
        //       AwesomeDialog(
        //         context: context,
        //         animType: AnimType.scale,
        //         dialogType: DialogType.info,
        //         body: const Center(child: Text(
        //           'If the body is specified, then title and description will be ignored, this allows to 											further customize the dialogue.',
        //           style: TextStyle(fontStyle: FontStyle.italic),
        //         ),),
        //         title: 'This is Ignored',
        //         desc:   'This is also Ignored',
        //         btnOkOnPress: () {
        //           navigatorPush(context, HomePage());
        //         },
        //       ).show();
        //     },
        //   ),
        // )

        ///
        );
  }

  void onSwipeLeft() {
    if (index >= 0 && index < (a.length - 1)) {
      setState(() {
        index += 1;
      });
    }
  }

  void onSwipeRight() {
    if (index > 0 && index < a.length) {
      setState(() {
        index -= 1;
      });
    }
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      animate = true;
    });
  }
}
