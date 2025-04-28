import 'package:flutter/material.dart';
import 'package:my_portfolio/support/helper.dart';
import 'package:my_portfolio/support/projects_data.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/theme/widgets/glowing_container.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  int getCrossAxisCount(double width) {
    if (width < 600) return 1;      // Mobile
    if (width < 1000) return 2;     // Tablet
    return 3;                      // Desktop
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = getCrossAxisCount(screenWidth);
    final itemWidth = screenWidth / crossAxisCount - 40;
    final isMobile = screenWidth < 600;

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
            children: List.generate(projectsDataList.length, (index) {
              final project = projectsDataList[index];
              return AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 500 + (index * 200)),
                child: SizedBox(
                  width: itemWidth,
                  child: GlowingContainer(
                    padding: const EdgeInsets.all(16),
                    border: Border.all(color: appColor(context)!.secondaryText!),
                    borderRadius: BorderRadius.circular(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isMobile)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              project.thumbnailPath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        const SizedBox(height: 16),
                        Text(
                          project.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: appColor(context)?.primaryText,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => launchAppUrl(project.url),
                          child: Text(
                            project.url,
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
