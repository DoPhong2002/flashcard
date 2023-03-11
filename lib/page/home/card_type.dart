import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashcards/comon/navigator.dart';
import 'package:flutter/material.dart';

import '../../const/const.dart';
import '../../generated/l10n.dart';
import '../../model/category.dart';
import '../game_play/game_play_page.dart';

class TypeCard extends StatelessWidget {
  final List<Flashcard> listFlashcard;
  final String image;
  final String title;

  const TypeCard(
      {super.key,
      required this.listFlashcard,
      required this.image,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigatorPush(context, GamePlayPage(listFlashcard: listFlashcard));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3,
              spreadRadius: 3,
              offset: const Offset(0, 0),
            )
          ],
        ),
        width: double.infinity,
        height: 72,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              height: 60,
              width: 60,
              child: CachedNetworkImage(
                imageUrl: image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    S.of(context).let,
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Image.asset('assets/photos/gogo.png')
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String header;

  const Header({Key? key, required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        header,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }
}
