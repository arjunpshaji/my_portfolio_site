import 'package:flutter/material.dart';

import 'package:my_portfolio/models/experience.dart';
import 'package:my_portfolio/theme/widgets/glowing_container.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800; // Layout breakpoint

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24.0 : 52),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 40),
            child: Text(
              "Experience",
              style: TextStyle(
                fontSize: isMobile ? 45 : 65,
                fontWeight: FontWeight.bold,
                color: appColor(context)?.primaryText,
                fontFamily: 'Caveat',
              ),
            ),
          ),
          Builder(
            builder: (context) {
              final experiences = context
                  .select<PortfolioProvider, List<Experience>>(
                    (p) => p.experiences,
                  );

              if (experiences.isEmpty) {
                return const Text('No experiences found');
              }

              return Column(
                children:
                    experiences.asMap().entries.map((entry) {
                      final index = entry.key;
                      final experience = entry.value;
                      final isLast = index == experiences.length - 1;
                      // Desktop: even=Left, odd=Right
                      final isLeft = index % 2 == 0;

                      return _TimelineItem(
                        experience: experience,
                        isFirst: index == 0,
                        isLast: isLast,
                        isMobile: isMobile,
                        isLeft: isLeft,
                        step: index + 1,
                      );
                    }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Experience experience;
  final bool isFirst;
  final bool isLast;
  final bool isMobile;
  final bool isLeft;
  final int step;

  const _TimelineItem({
    required this.experience,
    required this.isFirst,
    required this.isLast,
    required this.isMobile,
    required this.isLeft,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;

    // -- Mobile Layout (Timeline on Left) --
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: _ExperienceCard(experience: experience, isMobile: isMobile),
      );
    }

    // -- Desktop Layout (Center Tree) --
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT SIDE
          Expanded(
            child:
                isLeft
                    ? Padding(
                      padding: const EdgeInsets.only(right: 32, bottom: 60),
                      child: _ExperienceCard(
                        experience: experience,
                        isMobile: isMobile,
                      ),
                    )
                    : const SizedBox(),
          ),

          // CENTER LINE
          // CENTER LINE
          SizedBox(
            width: 50,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (!isLast)
                  Positioned(
                    top: 24,
                    bottom: -60,
                    child: CustomPaint(
                      size: const Size(4, double.infinity),
                      painter: _RoadmapLinePainter(
                        color:
                            colors.primary?.withOpacity(0.9) ??
                            Colors.cyan.withOpacity(0.9),
                      ),
                    ),
                  ),
                // Step Dot
                Container(
                  width: 28,
                  height: 28,
                  margin: const EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.background,
                    border: Border.all(
                      color: colors.primary ?? Colors.cyan,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (colors.primary ?? Colors.cyan).withOpacity(0.5),
                        blurRadius: 12,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '$step',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colors.secondaryText ?? Colors.purpleAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // RIGHT SIDE
          Expanded(
            child:
                !isLeft
                    ? Padding(
                      padding: const EdgeInsets.only(left: 32, bottom: 60),
                      child: _ExperienceCard(
                        experience: experience,
                        isMobile: isMobile,
                      ),
                    )
                    : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class _RoadmapLinePainter extends CustomPainter {
  final Color color;

  _RoadmapLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [color, color],
    );

    final paint =
        Paint()
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round
          ..shader = gradient.createShader(rect);

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ExperienceCard extends StatelessWidget {
  final Experience experience;
  final bool isMobile;

  const _ExperienceCard({required this.experience, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    final ValueNotifier<bool> isExpanded = ValueNotifier(false);

    return GlowingContainer(
      padding: const EdgeInsets.all(32),
      border: Border.all(
        color: colors.subText?.withValues(alpha: 0.2) ?? Colors.transparent,
        width: 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            experience.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colors.primaryText,
              fontFamily: 'LexendMega',
            ),
          ),
          const SizedBox(height: 12),
          // Period Badge
          Text(
            experience.period,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colors.primaryText ?? Colors.cyanAccent,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),

          // Expandable Description
          ValueListenableBuilder<bool>(
            valueListenable: isExpanded,
            builder: (context, expanded, child) {
              final shouldTruncate = isMobile && !expanded;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    alignment: Alignment.topCenter,
                    child: Text(
                      experience.description,
                      maxLines: shouldTruncate ? 3 : null,
                      overflow:
                          shouldTruncate
                              ? TextOverflow.ellipsis
                              : TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: colors.primaryText?.withOpacity(0.9),
                      ),
                    ),
                  ),
                  if (isMobile) ...[
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => isExpanded.value = !expanded,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          expanded ? "See Less" : "See More",
                          style: TextStyle(
                            color: colors.primary ?? Colors.cyan,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
