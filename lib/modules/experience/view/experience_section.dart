import 'package:flutter/material.dart';
import 'package:my_portfolio/data/portfolio_repository.dart';
import 'package:my_portfolio/models/experience.dart';
import 'package:my_portfolio/theme/widgets/glowing_container.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Experience",
              style: TextStyle(
                fontSize: isMobile ? 55 : 65,
                color: appColor(context)?.primaryText,
                fontFamily: 'Caveat',
              ),
            ),
          ),
          FutureBuilder<List<Experience>>(
            future: PortfolioRepository().getExperiences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError) {
                return GlowingContainer(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Error loading experiences: ${snapshot.error}',
                    style: TextStyle(
                      color: appColor(context)?.primaryText,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              final experiences = snapshot.data ?? [];

              if (experiences.isEmpty) {
                return GlowingContainer(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'No experiences found',
                    style: TextStyle(
                      color: appColor(context)?.primaryText,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              return Column(
                spacing: 25,
                children:
                    experiences.map((experience) {
                      return GlowingContainer(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            Text(
                              experience.title,
                              style: TextStyle(
                                fontSize: isMobile ? 24 : 32,
                                fontWeight: FontWeight.w700,
                                color: appColor(context)?.primaryText,
                              ),
                            ),
                            Text(
                              experience.period,
                              style: TextStyle(
                                fontSize: isMobile ? 18 : 24,
                                fontWeight: FontWeight.w500,
                                color: appColor(
                                  context,
                                )?.primaryText?.withOpacity(0.8),
                              ),
                            ),
                            Text(
                              experience.description,
                              style: TextStyle(
                                fontSize: isMobile ? 16 : 22,
                                color: appColor(context)?.primaryText,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
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
