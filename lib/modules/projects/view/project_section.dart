import 'package:flutter/material.dart';
import 'package:my_portfolio/modules/experience/widgets/glowing_container.dart';
import 'package:my_portfolio/support/projects_data.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/theme/widgets/containerbox_widget.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text('Personal Projects', style: TextStyle(fontSize: 65, fontFamily: 'Caveat', color: appColor(context)?.primaryText)),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            physics: const NeverScrollableScrollPhysics(),
            children:
                projectsDataList
                    .map(
                      (project) => ContainerboxWidget(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(borderRadius: BorderRadius.circular(30), child: Image.asset(project.thumbnailPath, fit: BoxFit.cover)),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                project.title,
                                style: TextStyle(fontSize: 24, color: appColor(context)?.primaryText, fontWeight: FontWeight.w700),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              project.description,
                              style: TextStyle(fontSize: 16, color: appColor(context)?.primaryText, fontStyle: FontStyle.italic),
                            ),
                            Text(project.url, style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
