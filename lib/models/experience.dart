class Experience {
  final String title;
  final String period;
  final String description;
  final int sort;

  Experience({
    required this.title,
    required this.period,
    required this.description,
    required this.sort,
  });

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      title: map['title'] as String,
      period: map['period'] as String,
      description: map['description'] as String,
      sort: map['sort'] as int,
    );
  }
}
