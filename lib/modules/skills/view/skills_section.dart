import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.indigo.shade50,
      child: Column(
        children: [
          const Text('Skills', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: const [
              SkillChip(skill: 'Flutter'),
              SkillChip(skill: 'Dart'),
              SkillChip(skill: 'Firebase'),
              SkillChip(skill: 'UI/UX Design'),
              SkillChip(skill: 'Git'),
              SkillChip(skill: 'Figma'),
            ],
          ),
        ],
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  final String skill;

  const SkillChip({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(skill), backgroundColor: Colors.white, elevation: 4, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8));
  }
}
