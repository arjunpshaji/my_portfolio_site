import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const Text('Projects', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(3, (index) {
              return Card(
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.web, size: 48),
                      const SizedBox(height: 10),
                      Text('Project ${index + 1}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text('Short project description goes here.'),
                    ],
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