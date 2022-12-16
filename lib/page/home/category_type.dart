import 'package:flutter/material.dart';
import '../../const/color.dart';

class CategoryType extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String title;

  const CategoryType(
      {Key? key,
      required this.image,
      required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 3,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(image)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
