import 'dart:ui';

class SkillLogos {
  final String title;
  final String assetPath;
  final String category;
  final Color? accentColor;

  SkillLogos({
    required this.title,
    required this.assetPath,
    this.category = 'Mobile & Core',
    this.accentColor,
  });
}

final List<SkillLogos> skillData = [
  // Mobile & Core
  SkillLogos(
    title: "Flutter",
    assetPath: "assets/icons/flutter_logo.png",
    category: "Mobile & Core",
    accentColor: const Color(0xff02569B),
  ),
  SkillLogos(
    title: "Dart",
    assetPath: "assets/icons/dart_logo.png",
    category: "Mobile & Core",
    accentColor: const Color(0xff0175C2),
  ),
  // State Management
  SkillLogos(
    title: "Riverpod",
    assetPath: "assets/icons/riverpod_icon.png",
    category: "State Management",
    accentColor: const Color(0xff00D2B8),
  ),
  SkillLogos(
    title: "Bloc",
    assetPath: "assets/icons/bloc_icon.png",
    category: "State Management",
    accentColor: const Color(0xff8B5CF6),
  ),
  SkillLogos(
    title: "GetX",
    assetPath: "assets/icons/getx_icon.png",
    category: "State Management",
    accentColor: const Color(0xff9C27B0),
  ),
  // Backend & Cloud
  SkillLogos(
    title: "Firebase",
    assetPath: "assets/icons/firebase_logo.png",
    category: "Backend & Cloud",
    accentColor: const Color(0xffFFA000),
  ),
  SkillLogos(
    title: "Node.js",
    assetPath: "assets/icons/nodejs_icon.png",
    category: "Backend & Cloud",
    accentColor: const Color(0xff68A063),
  ),
  SkillLogos(
    title: "MongoDB",
    assetPath: "assets/icons/mongo_icon.png",
    category: "Backend & Cloud",
    accentColor: const Color(0xff4DB33D),
  ),
  // Tools & Web
  SkillLogos(
    title: "GitHub",
    assetPath: "assets/icons/github_logo.png",
    category: "Tools & Web",
    accentColor: const Color(0xffC084FC),
  ),
  SkillLogos(
    title: "HTML5",
    assetPath: "assets/icons/html_icon.png",
    category: "Tools & Web",
    accentColor: const Color(0xffE34F26),
  ),
  SkillLogos(
    title: "CSS3",
    assetPath: "assets/icons/css_icon.png",
    category: "Tools & Web",
    accentColor: const Color(0xff1572B6),
  ),
  SkillLogos(
    title: "Bootstrap",
    assetPath: "assets/icons/bootstrap_icon.png",
    category: "Tools & Web",
    accentColor: const Color(0xff7952B3),
  ),
];
