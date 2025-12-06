class Project {
  final String title;
  final String description;
  final String? projectUrl;
  final String? techStack;
  final int sort;

  Project({
    required this.title,
    required this.description,
    this.projectUrl,
    this.techStack,
    required this.sort,
  });

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      title: map['title'] as String,
      description: map['description'] as String,
      projectUrl: map['project_url'] as String?,
      techStack: map['tech_stack'] as String?,
      sort: map['sort'] as int,
    );
  }
}
