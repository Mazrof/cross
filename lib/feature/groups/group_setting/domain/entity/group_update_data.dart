
import 'package:equatable/equatable.dart';

class GroupUpdateData extends Equatable{
  final String name;
  final bool privacy;
  final int groupSize;
  final String imageUrl;

  GroupUpdateData({
    required this.name,
    required this.privacy,
    required this.groupSize,
    required this.imageUrl,

  });

  @override
  List<Object?> get props => [name, privacy, groupSize, imageUrl];
}