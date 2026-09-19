class Metric {
  final String value;
  final String label;
  final int sort;

  Metric({
    required this.value,
    required this.label,
    required this.sort,
  });

  factory Metric.fromMap(Map<String, dynamic> map) {
    return Metric(
      value: map['value']?.toString() ?? '',
      label: map['label']?.toString() ?? '',
      sort: (map['sort'] as num?)?.toInt() ?? 0,
    );
  }
}
