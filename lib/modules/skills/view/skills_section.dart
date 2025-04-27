import 'package:flutter/material.dart';
import 'package:my_portfolio/support/skill_logos.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/theme/widgets/skill_tile.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("My relevant skills", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: appColor(context)?.primaryText)),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: ScrollLoopAutoScroll(
            scrollDirection: Axis.horizontal,
            child: Row(children: skillData.sublist(0, 6).map((e) => SkillTile(assetPath: e.assetPath, title: e.title)).toList()),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: ScrollLoopAutoScroll(
            scrollDirection: Axis.horizontal,
            reverseScroll: true,
            child: Row(children: skillData.sublist(6).map((e) => SkillTile(assetPath: e.assetPath, title: e.title)).toList()),
          ),
        ),
        SizedBox(height: 20),
        Image.asset('assets/images/Skills.png'),
      ],
    );
  }
}
