import 'dart:ui';

class SkillLogos {
  final String title;
  final String assetPath;
  final Color? bgColor;
  SkillLogos({required this.title, required this.assetPath, this.bgColor});
}

final List<SkillLogos> skillData = [
  SkillLogos(title: "Flutter", assetPath: "assets/icons/flutter_logo.png"),
  SkillLogos(title: "Dart", assetPath: "assets/icons/dart_logo.png"),
  SkillLogos(title: "Nodejs", assetPath: "assets/icons/nodejs_icon.png"),
  SkillLogos(title: "Mongodb", assetPath: "assets/icons/mongo_icon.png"),
  SkillLogos(title: "Firebase", assetPath: "assets/icons/firebase_logo.png"),
  SkillLogos(title: "Html", assetPath: "assets/icons/html_icon.png"),
  SkillLogos(title: "Css", assetPath: "assets/icons/css_icon.png"),
  SkillLogos(title: "Bootstrap", assetPath: "assets/icons/bootstrap_icon.png"),
  SkillLogos(title: "Github", assetPath: "assets/icons/github_logo.png"),
  SkillLogos(title: "Riverpod", assetPath: "assets/icons/riverpod_icon.png"),
  SkillLogos(title: "Bloc", assetPath: "assets/icons/bloc_icon.png"),
  SkillLogos(title: "Getx", assetPath: "assets/icons/getx_icon.png"),
];
