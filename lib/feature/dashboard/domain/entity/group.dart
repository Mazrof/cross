import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final String id;
  final int groupSize;
  final String name;
  final bool privacy;
  final bool status;

  const Group({
    required this.status,
    required this.id,
    required this.groupSize,
    required this.name,
    required this.privacy,
  });

  @override
  List<Object?> get props => [id, groupSize, name, privacy, status];
}
