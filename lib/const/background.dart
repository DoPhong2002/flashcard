import 'package:flutter/material.dart';
import 'const.dart';

class BuildBackGround extends StatelessWidget {
  const BuildBackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height * 1.0,
            child: Image.asset(
              '${baseImage}background.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            top: 0,
            right: 10,
            width: 100,
            child: Image.asset(
              '${baseImage}mat_troi.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: -40,
            right: 0,
            child: Image.asset(
              '${baseImage}may.png',
            ),
          ),
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.2),
                  ],
                  stops: const [
                    0.4,
                    0.6,
                  ]).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: Container(
              height: MediaQuery.of(context).size.height * 1.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
