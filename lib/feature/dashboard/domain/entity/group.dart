import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:telegram/feature/dashboard/domain/entity/group.dart';

class Group extends Equatable {
  final String name;
  final int id;

  Group({required this.name, required this.id});
  
  @override
  List<Object?> get props => [name, id];

}
