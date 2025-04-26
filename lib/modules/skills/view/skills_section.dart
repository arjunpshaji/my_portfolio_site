import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      children: [
        Text("Skills", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: appColor(context)?.primaryText)),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: ScrollLoopAutoScroll(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width / 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/Skills.png')),
                    color: appColor(context)?.errorText,
                  ),
                  // child: const Text('ONE', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
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
        Image.asset('assets/images/Skills.png'),
      ],
    );
  }
}
