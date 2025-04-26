import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class BioWidget extends StatelessWidget {
  const BioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 90),
        Text("I'm a Software Developer", style: TextStyle(fontSize: 50, color: appColor(context)?.primaryText)),
        Text(
          "Software Developer with hands-on experience in Flutter, Dart, and full-stack development using Next.js and Express.js. Passionate aboutbuilding scalable, high-performance applications and contributing toinnovative projects. Eager to leverage my skills in state management, API integration, and deployment to create impactful software solutions.",
          style: TextStyle(fontSize: 24, color: appColor(context)?.primaryText),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: ScrollLoopAutoScroll(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: const Text('ONE', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: const Text('FOR', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text('ALL', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.orange,
                  alignment: Alignment.center,
                  child: const Text('AND', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text('ALL', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: const Text('FOR', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: const Text('ONE', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
