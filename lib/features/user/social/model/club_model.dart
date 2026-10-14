class ClubModel {
  final String id;
  final String name;
  final String avatar;
  final String subtitle;
  final int memberCount;
  final String location;
  final List<String> tags;

  const ClubModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.subtitle,
    required this.memberCount,
    required this.location,
    required this.tags,
  });
}
