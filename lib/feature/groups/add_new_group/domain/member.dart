import 'package:equatable/equatable.dart';

class Member extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final String lastSeen;

  Member({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.lastSeen,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, imageUrl, lastSeen];
}
