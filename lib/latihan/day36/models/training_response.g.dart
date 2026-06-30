// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingsResponse _$TrainingsResponseFromJson(Map<String, dynamic> json) =>
    TrainingsResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Training.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrainingsResponseToJson(TrainingsResponse instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};
