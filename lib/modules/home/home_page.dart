import 'package:flutter/material.dart';
import 'package:my_portfolio/modules/bio/bio_widget.dart';
import 'package:my_portfolio/modules/contact/view/contacts_section.dart';
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
    return Scaffold(
      backgroundColor: appColor(context)?.background,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeroSection(),
              BioWidget(),
              SizedBox(height: 60),
              SkillsSection(),
              SizedBox(height: 60),
              ExperienceSection(),
              ProjectsSection(),
              ContactSection(),
              FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
