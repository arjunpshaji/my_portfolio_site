import 'package:flutter/material.dart';
import 'package:my_portfolio/models/experience.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final colors = appColor(context)!;

    final experiences = context.select<PortfolioProvider, List<Experience>>(
      (p) => p.experiences,
    );

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 40.0,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                width: 4,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffA855F7), Color(0xff06B6D4)],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Work Experience",
                style: TextStyle(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.w900,
                  color: colors.primaryText,
                  fontFamily: 'Manrope',
                  letterSpacing: -0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "My professional journey and track record in software engineering.",
              style: TextStyle(
                fontSize: 15,
                color: colors.subText,
                fontFamily: 'Manrope',
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Experience Cards
          Column(
            children: experiences.asMap().entries.map((entry) {
              final index = entry.key;
              final exp = entry.value;
              final isLast = index == experiences.length - 1;

              return _TimelineExperienceItem(
                experience: exp,
                isLast: isLast,
                stepNumber: index + 1,
                isMobile: isMobile,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _TimelineExperienceItem extends StatefulWidget {
  final Experience experience;
  final bool isLast;
  final int stepNumber;
  final bool isMobile;

  const _TimelineExperienceItem({
    required this.experience,
    required this.isLast,
    required this.stepNumber,
    required this.isMobile,
  });

  @override
  State<_TimelineExperienceItem> createState() => _TimelineExperienceItemState();
}

class _TimelineExperienceItemState extends State<_TimelineExperienceItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    final isPresent = widget.experience.period.toLowerCase().contains('present');

    // Parse Title & Company
    String role = widget.experience.title;
    String? company;
    if (role.contains(' - ')) {
      final parts = role.split(' - ');
      role = parts[0];
      company = parts[1];
    } else if (role.contains('@')) {
      final parts = role.split('@');
      role = parts[0];
      company = parts[1];
    }

    // Split bullet lines
    final bulletLines = widget.experience.description
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          SizedBox(
            width: 44,
            child: Column(
              children: [
                // Node circle
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isPresent
                        ? const Color(0xff7C3AED)
                        : const Color(0xff16122E),
                    border: Border.all(
                      color: isPresent
                          ? const Color(0xffC084FC)
                          : Colors.white.withValues(alpha: 0.3),
                      width: 2,
                    ),
                    boxShadow: isPresent
                        ? [
                            BoxShadow(
                              color: const Color(0xffA855F7).withValues(alpha: 0.45),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      '${widget.stepNumber}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isPresent ? Colors.white : const Color(0xff94A3B8),
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ),
                ),
                // Connector line
                if (!widget.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xffA855F7).withValues(alpha: 0.6),
                            Colors.white.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Experience Card Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.isLast ? 0 : 36.0),
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? const Color(0xff181434).withValues(alpha: 0.95)
                        : const Color(0xff120F24).withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _isHovered
                          ? const Color(0xffC084FC).withValues(alpha: 0.5)
                          : Colors.white.withValues(alpha: 0.08),
                      width: 1.5,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: const Color(0xffA855F7).withValues(alpha: 0.2),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Role & Period Row
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                role.trim(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Manrope',
                                ),
                              ),
                              if (company != null) ...[
                                Text(
                                  " • ${company.trim()}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffC084FC),
                                    fontFamily: 'Manrope',
                                  ),
                                ),
                              ],
                            ],
                          ),

                          // Period Chip
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isPresent
                                  ? const Color(0xff10B981).withValues(alpha: 0.12)
                                  : Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isPresent
                                    ? const Color(0xff10B981).withValues(alpha: 0.35)
                                    : Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isPresent) ...[
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(right: 6),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff10B981),
                                    ),
                                  ),
                                ],
                                Text(
                                  widget.experience.period,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isPresent
                                        ? const Color(0xff34D399)
                                        : const Color(0xff94A3B8),
                                    fontFamily: 'Manrope',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Bullet Points
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: bulletLines.map((line) {
                          final cleanLine = line.startsWith('•')
                              ? line.substring(1).trim()
                              : line;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 6.0, right: 10.0),
                                  child: Icon(
                                    Icons.arrow_right_rounded,
                                    size: 16,
                                    color: Color(0xffA855F7),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    cleanLine,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.55,
                                      color: colors.primaryText?.withValues(alpha: 0.85),
                                      fontFamily: 'Manrope',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
