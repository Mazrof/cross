import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final String name;
  final String id;

  Group({required this.name, required this.id});
  
  @override
  List<Object?> get props => [name, id];

}
