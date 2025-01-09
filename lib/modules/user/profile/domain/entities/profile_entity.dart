class ProfileEntity {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  ProfileEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
