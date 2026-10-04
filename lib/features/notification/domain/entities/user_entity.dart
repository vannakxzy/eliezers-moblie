class UserEntity {
  final int id;
  final String name;
  final String avatar;
  UserEntity({
    required this.id,
    required this.name,
    this.avatar = '',
  });
}
