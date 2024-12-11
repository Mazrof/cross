import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  final int id;
  final String name;
  final bool privacy;
  final bool canAddComments;
  final String? imageUrl;

  Channel({
    required this.id,
    required this.name,
    required this.privacy,
    required this.canAddComments,
    this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, privacy, canAddComments, imageUrl];
}
