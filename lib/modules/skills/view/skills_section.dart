import 'package:flutter/material.dart';
import 'package:my_portfolio/support/skill_logos.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    // Padding logic
    final horizontalPadding = isMobile ? 24.0 : 52.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Toolkit",
            style: TextStyle(
              fontSize: isMobile ? 40 : 60,
              fontWeight: FontWeight.bold,
              color: appColor(context)?.primaryText,
              fontFamily: 'Caveat',
              height: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Technologies I use to build amazing products.",
            style: TextStyle(
              fontSize: 16,
              color: appColor(context)?.secondaryText,
              fontFamily: 'LexendMega',
            ),
          ),
          const SizedBox(height: 40),

          Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.start,
              children:
                  skillData.map((skill) {
                    return _SkillCard(skill: skill);
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final SkillLogos skill;
  const _SkillCard({required this.skill});

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    final isMobile = MediaQuery.of(context).size.width < 600;

    final ValueNotifier<bool> isHovered = ValueNotifier(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: isHovered,
        builder: (context, hovered, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isMobile ? 100 : 120,
            height: isMobile ? 100 : 120,
            decoration: BoxDecoration(
              color: colors.secondaryText?.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color:
                    hovered
                        ? (colors.hoverColor ?? Colors.cyan).withOpacity(0.5)
                        : colors.secondaryText!.withValues(alpha: 0.1),
                width: hovered ? 2 : 1,
              ),
              boxShadow:
                  hovered
                      ? [
                        BoxShadow(
                          color: (colors.hoverColor ?? Colors.cyan).withValues(
                            alpha: 0.2,
                          ),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ]
                      : [],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  skill.assetPath,
                  width: isMobile ? 35 : 45,
                  height: isMobile ? 35 : 45,
                ),
                const SizedBox(height: 12),
                Text(
                  skill.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:
                        hovered ? (colors.primaryText) : colors.secondaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
