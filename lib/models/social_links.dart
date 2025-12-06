class SocialLink {
  final String label;
  final String url;
  final int sort;

  SocialLink({required this.label, required this.url, required this.sort});

  factory SocialLink.fromMap(Map<String, dynamic> map) {
    return SocialLink(
      label: map['label'] as String,
      url: map['url'] as String,
      sort: map['sort'] as int,
    );
  }
}
