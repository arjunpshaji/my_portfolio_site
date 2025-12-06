import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/modules/bio/bio_widget.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

import 'package:my_portfolio/modules/experience/view/experience_section.dart';
import 'package:my_portfolio/modules/footer/view/footer_section.dart';
import 'package:my_portfolio/modules/hero/view/hero_section.dart';
import 'package:my_portfolio/modules/projects/view/project_section.dart';
import 'package:my_portfolio/modules/skills/view/skills_section.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<PortfolioProvider, bool>(
      (p) => p.isLoading,
    );

    if (isLoading) {
      return Scaffold(
        backgroundColor: appColor(context)?.background,
        body: Center(
          child: Lottie.asset(
            'assets/lottie/loader.json',
            width: 150,
            height: 150,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: appColor(context)?.background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            // Positioned.fill(
            //   child: Lottie.asset(
            //     'assets/lottie/shooting_star.json',
            //     repeat: true,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Lottie.asset(
              'assets/lottie/snow.json',
              repeat: true,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Column(
              children: const [
                HeroSection(),
                BioWidget(),
                SizedBox(height: 60),
                ExperienceSection(),
                SizedBox(height: 60),
                SkillsSection(),
                ProjectsSection(),
                SizedBox(height: 45),
                FooterSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
