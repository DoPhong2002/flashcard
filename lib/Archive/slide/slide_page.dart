import 'package:flashcards/Archive/slide/animation_widget.dart';
import 'package:flutter/material.dart';

class SlidePage extends StatefulWidget {
  const SlidePage({Key? key}) : super(key: key);

  @override
  State<SlidePage> createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  final photos = <String>[
    "https://2.pik.vn/202058b029a0-5718-4fce-99a9-6aa1d86cd94f.png",
    "https://2.pik.vn/202012144525-b5e9-442e-8705-2aa4ae815ead.png",
    "https://2.pik.vn/2020b7964c75-5ae5-40aa-ad4e-d852e3e7b739.png",
    "https://2.pik.vn/20201ecb708f-c8aa-473c-b3a6-f0c22ea48ca3.png",
  ];

  var currentIndex = 0;
  var offset = const Offset(0.5, 0);
  var ok = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SlideWidget(
                  key: UniqueKey(),
                  offset: offset,
                  child: Image.network(photos[currentIndex]),
                ),
              ),
              Expanded(
                child: FadeInWidget(
                  key: UniqueKey(),
                  child: Image.network(photos[currentIndex]),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: previous,
                      icon: const Icon(Icons.skip_previous_rounded),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: next,
                      icon: const Icon(Icons.skip_next_rounded),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void previous() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex -= 1;
        offset = const Offset(-1, 0);
      });
    }
  }

  void next() {
    if (currentIndex < photos.length - 1) {
      setState(() {
        offset = const Offset(1, 0);
        currentIndex += 1;
      });
    }
  }
}
