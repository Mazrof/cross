import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final int id;
  final String name;
  final bool privacy;
  final int groupSize;
  final int admins;
  final String imageUrl;

  Group({
    required this.id,
    required this.name,
    required this.privacy,
    required this.groupSize,
    required this.admins,
    required this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, privacy, groupSize, admins, imageUrl];
}
