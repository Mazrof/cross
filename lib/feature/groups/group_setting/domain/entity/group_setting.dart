import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final int id;
  final int groupSize;
  final String name;
  final bool privacy;
  final String imageUrl;

  GroupEntity({
    required this.id,
    required this.groupSize,
    required this.name,
    required this.privacy,
    required this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        groupSize,
        name,
        privacy,
        imageUrl,
      ];
}
