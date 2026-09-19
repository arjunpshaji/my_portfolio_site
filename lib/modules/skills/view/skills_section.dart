import 'package:flutter/material.dart';
import 'package:my_portfolio/support/skill_logos.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String _selectedCategory = "All";

  final List<String> _categories = [
    "All",
    "Mobile & Core",
    "State Management",
    "Backend & Cloud",
    "Tools & Web",
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final colors = appColor(context)!;

    final filteredSkills = _selectedCategory == "All"
        ? skillData
        : skillData.where((s) => s.category == _selectedCategory).toList();

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 40.0,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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
                "My Toolkit",
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
              "Modern technologies and frameworks I use to engineer robust apps.",
              style: TextStyle(
                fontSize: 15,
                color: colors.subText,
                fontFamily: 'Manrope',
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FilterChip(
                    label: Text(
                      cat,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xff94A3B8),
                        fontFamily: 'Manrope',
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    backgroundColor: Colors.white.withValues(alpha: 0.04),
                    selectedColor: const Color(0xff7C3AED),
                    showCheckmark: false,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xffC084FC)
                            : Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 36),

          // Skills Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final double cardWidth = isMobile ? 140 : 165;

              return Center(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: filteredSkills.map((skill) {
                    return SizedBox(
                      width: cardWidth,
                      child: _SkillCard(skill: skill),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final SkillLogos skill;
  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    final accent = widget.skill.accentColor ?? const Color(0xffA855F7);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xff181434)
              : const Color(0xff120F24).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? accent.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.08),
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.25),
                    blurRadius: 18,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo Image
            AnimatedScale(
              scale: _isHovered ? 1.12 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Image.asset(
                widget.skill.assetPath,
                width: 44,
                height: 44,
              ),
            ),
            const SizedBox(height: 14),

            // Title
            Text(
              widget.skill.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _isHovered ? Colors.white : colors.primaryText,
                fontFamily: 'Manrope',
              ),
            ),
            const SizedBox(height: 4),

            // Category tag
            Text(
              widget.skill.category,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xff94A3B8),
                fontFamily: 'Manrope',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
