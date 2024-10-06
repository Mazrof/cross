import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final bool success;
  final int statusCode;
  final String statusMessage;

  const ErrorMessageModel(
      {required this.success,
      required this.statusCode,
      required this.statusMessage});

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) =>
      ErrorMessageModel(
          success: json["success"] ?? false,
          statusCode: json["status_code"] ?? 0,
          statusMessage: json["status_message"] ?? ' Guest mode');

  @override
  List<Object?> get props => [success, statusCode, statusMessage];
}
