// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    ApiErrorModel(
      type: json['type'] as String?,
      status: (json['status'] as num?)?.toInt(),
      title: json['title'] as String?,
      traceId: json['traceId'] as String?,
    );

Map<String, dynamic> _$ApiErrorModelToJson(ApiErrorModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'status': instance.status,
      'title': instance.title,
      'traceId': instance.traceId,
    };
