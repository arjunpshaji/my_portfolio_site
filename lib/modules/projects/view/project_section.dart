import 'package:flutter/material.dart';
import 'package:my_portfolio/support/helper.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/theme/widgets/glowing_container.dart';
import 'package:my_portfolio/models/projects.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  int getCrossAxisCount(double width) {
    if (width < 600) return 1; // Mobile
    if (width < 1000) return 2; // Tablet
    return 3; // Desktop
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = getCrossAxisCount(screenWidth);
    final itemWidth = screenWidth / crossAxisCount - 40;
    final isMobile = screenWidth < 600;

    final projects = context.select<PortfolioProvider, List<Project>>(
      (p) => p.projects,
    );

    if (projects.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Projects',
            style: TextStyle(
              fontSize: isMobile ? 44 : 65,
              fontFamily: 'Caveat',
              color: appColor(context)?.primaryText,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: List.generate(projects.length, (index) {
              final project = projects[index];
              return AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 500 + (index * 200)),
                child: SizedBox(
                  width: itemWidth,
                  child: GlowingContainer(
                    padding: const EdgeInsets.all(16),
                    border: Border.all(
                      color: appColor(context)!.secondaryText!,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: appColor(context)?.primaryText,
                          ),
                        ),
                        if (project.techStack != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            project.techStack!,
                            style: TextStyle(
                              fontSize: 14,
                              color: appColor(context)?.secondaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        if (project.projectUrl != null)
                          InkWell(
                            onTap: () => launchAppUrl(project.projectUrl!),
                            child: Text(
                              project.projectUrl!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: appColor(context)?.buttonColor,
                              ),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          project.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: appColor(context)?.primaryText,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
