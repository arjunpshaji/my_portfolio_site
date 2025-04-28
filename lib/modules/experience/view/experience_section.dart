import 'package:flutter/material.dart';
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
            child: Text("Experience", style: TextStyle(fontSize: isMobile ? 55 : 65, color: appColor(context)?.primaryText, fontFamily: 'Caveat')),
          ),
          GlowingContainer(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Text(
                  "Techfriar (2022 - 2025)",
                  style: TextStyle(fontSize: isMobile ? 24 : 32, fontWeight: FontWeight.w700, color: appColor(context)?.primaryText),
                ),
                Text(
                  "Developed and deployed 6 mobile applications for Android and iOS using Flutter and Dart, achieving 95% crash-free sessions while implementing state management with Riverpod and Cubit to reduce widget rebuilds by 30% and improve app performance by 20%. Designed and integrated RESTful and GraphQL APIs to enhance data fetching efficiency by 40% and achieve real-time updates with under 200ms response time. Streamlined API development using Swagger, Apollo GraphQL, Postman, and Telescope, reducing debugging time by 30%. Led a team of 4 developers in agile sprints, ensuring timely delivery of milestones and maintaining high code quality through regular code reviews. Successfully deployed applications to the Google Play Store while assisting with iOS App Store deployment.",
                  style: TextStyle(fontSize: isMobile ? 16 : 22, color: appColor(context)?.primaryText, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          GlowingContainer(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Text("Freelance", style: TextStyle(fontSize: isMobile ? 22 : 30, fontWeight: FontWeight.w700, color: appColor(context)?.primaryText)),
                Text(
                  "I have successfully completed freelance projects in both web and mobile app development, and I’m excited to take on new opportunities using Flutter",
                  style: TextStyle(fontSize: isMobile ? 16 : 22, color: appColor(context)?.primaryText, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
