import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/modules/bio/bio_widget.dart';
import 'package:my_portfolio/modules/contact/view/contacts_section.dart';
import 'package:my_portfolio/modules/experience/view/experience_section.dart';
import 'package:my_portfolio/modules/footer/view/footer_section.dart';
import 'package:my_portfolio/modules/hero/view/hero_section.dart';
import 'package:my_portfolio/modules/home/widgets/navbar_widget.dart';
import 'package:my_portfolio/modules/projects/view/project_section.dart';
import 'package:my_portfolio/modules/skills/view/skills_section.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/theme/widgets/custom_cursor.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(int index) {
    GlobalKey targetKey;
    switch (index) {
      case 0:
        targetKey = _heroKey;
        break;
      case 1:
        targetKey = _aboutKey;
        break;
      case 2:
        targetKey = _experienceKey;
        break;
      case 3:
        targetKey = _skillsKey;
        break;
      case 4:
        targetKey = _projectsKey;
        break;
      case 5:
        targetKey = _contactKey;
        break;
      default:
        targetKey = _heroKey;
    }

    final context = targetKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<PortfolioProvider, bool>(
      (p) => p.isLoading,
    );

    if (isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xff0B0819),
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
      backgroundColor: const Color(0xff0B0819),
      body: CustomCursorOverlay(
        child: Stack(
          children: [
            // Ambient Background Glow Orbs
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xff7C3AED).withValues(alpha: 0.18),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 700,
              left: -150,
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xff06B6D4).withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 1800,
              right: -100,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xffA855F7).withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Main Scrollable Page Content
            SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Top spacing for floating navbar
                  const SizedBox(height: 80),

                  // 0. Hero Section
                  HeroSection(
                    key: _heroKey,
                    onViewProjects: () => _scrollToSection(4),
                    onContact: () => _scrollToSection(5),
                  ),

                  const SizedBox(height: 40),

                  // 1. About / Bio Widget
                  BioWidget(key: _aboutKey),

                  const SizedBox(height: 50),

                  // 2. Experience Section
                  ExperienceSection(key: _experienceKey),

                  const SizedBox(height: 50),

                  // 3. Skills Section
                  SkillsSection(key: _skillsKey),

                  const SizedBox(height: 50),

                  // 4. Projects Section
                  ProjectsSection(key: _projectsKey),

                  const SizedBox(height: 30),

                  // 5. Contact Section
                  ContactSection(key: _contactKey),

                  const SizedBox(height: 40),

                  // Footer
                  FooterSection(
                    onBackToTop: () => _scrollToSection(0),
                  ),
                ],
              ),
            ),

            // Floating Glassmorphic Navbar (Always visible at top)
            NavbarWidget(
              onSectionSelected: _scrollToSection,
            ),
          ],
        ),
      ),
    );
  }
}
