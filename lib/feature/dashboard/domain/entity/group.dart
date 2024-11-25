import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final String id;
  final int groupSize;
  final String name;
  final bool privacy;
  final bool hasFilter;

  const Group({
    required this.hasFilter,
    required this.id,
    required this.groupSize,
    required this.name,
    required this.privacy,
  });

  @override
  List<Object?> get props => [id, groupSize, name, privacy, hasFilter];
}
