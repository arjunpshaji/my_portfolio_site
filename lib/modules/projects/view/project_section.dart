import 'package:flutter/material.dart';
import 'package:my_portfolio/support/helper.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/models/projects.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final isTablet = screenWidth < 1200;

    // Calculate Grid Config
    int crossAxisCount = 1;
    if (screenWidth > 800) crossAxisCount = 2; // Tablet/Small Desktop
    if (screenWidth > 1200) crossAxisCount = 3; // Large Desktop

    // Horizontal padding based on device
    final horizontalPadding = isMobile ? 24.0 : (isTablet ? 40.0 : 80.0);

    final projects = context.select<PortfolioProvider, List<Project>>(
      (p) => p.projects,
    );

    if (projects.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Featured Projects',
            style: TextStyle(
              fontSize: isMobile ? 40 : 60,
              fontWeight: FontWeight.bold,
              fontFamily: 'Caveat',
              color: appColor(context)?.primaryText,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'A selection of my recent works.',
            style: TextStyle(
              fontSize: 16,
              color: appColor(context)?.secondaryText,
              fontFamily: 'LexendMega',
            ),
          ),
          const SizedBox(height: 50),

          // Projects Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              // Gap between cards
              const double gap = 24.0;
              // Calculate card width
              final cardWidth =
                  (availableWidth - (gap * (crossAxisCount - 1))) /
                  crossAxisCount;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children:
                    projects.map((project) {
                      return SizedBox(
                        width: cardWidth,
                        child: _ProjectCard(project: project),
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

class _ProjectCard extends StatelessWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    final techTags =
        project.techStack?.split(',').map((e) => e.trim()).toList() ?? [];

    final ValueNotifier<bool> isHovered = ValueNotifier(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: isHovered,
        builder: (context, hovered, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(24),
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
                            alpha: 0.15,
                          ),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ]
                      : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Title + Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        project.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colors.primaryText,
                          fontFamily: 'LexendMega',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.folder_open_rounded,
                      color: hovered ? colors.primary : colors.secondaryText,
                      size: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Description
                Text(
                  project.description,
                  style: TextStyle(
                    fontSize: 15,
                    color: colors.primaryText?.withOpacity(0.8),
                    height: 1.6,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 24),

                // Tech Sack Chips
                if (techTags.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        techTags.map((tag) => _TechBadge(label: tag)).toList(),
                  ),

                const SizedBox(height: 32),

                // Action Button
                if (project.projectUrl != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => launchAppUrl(project.projectUrl!),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "View Project",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colors.primary ?? Colors.cyan,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: colors.primary ?? Colors.cyan,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TechBadge extends StatelessWidget {
  final String label;
  const _TechBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colors.primary?.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.primary?.withValues(alpha: 0.2) ?? Colors.transparent,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colors.primary ?? Colors.cyan,
        ),
      ),
    );
  }
}
