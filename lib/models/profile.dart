class Profile {
  final String fullName;
  final String tagline;
  final String about;
  final String email;
  final String? location;
  final String profileImage;
  final String cvUrl;

  Profile({
    required this.fullName,
    required this.tagline,
    required this.about,
    required this.email,
    this.location,
    required this.profileImage,
    required this.cvUrl,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      fullName: map['full_name'] as String,
      tagline: map['tagline'] as String,
      about: map['about'] as String,
      email: map['email'] as String,
      location: map['location'] as String?,
      profileImage: map['profile_image'] as String,
      cvUrl: map['cv_url'] as String,
    );
  }
}
