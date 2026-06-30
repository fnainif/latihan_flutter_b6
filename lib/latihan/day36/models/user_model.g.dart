// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  name: json['name'] as String?,
  email: json['email'] as String?,
  batchId: intFromJson(json['batch_id']),
  trainingId: intFromJson(json['training_id']),
  jenisKelamin: json['jenis_kelamin'] as String?,
  profilePhoto: json['profile_photo'],
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  id: intFromJson(json['id']),
  batch: json['batch'] == null
      ? null
      : Batch.fromJson(json['batch'] as Map<String, dynamic>),
  training: json['training'] == null
      ? null
      : Training.fromJson(json['training'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'batch_id': instance.batchId,
  'training_id': instance.trainingId,
  'jenis_kelamin': instance.jenisKelamin,
  'profile_photo': instance.profilePhoto,
  'updated_at': instance.updatedAt?.toIso8601String(),
  'created_at': instance.createdAt?.toIso8601String(),
  'id': instance.id,
  'batch': instance.batch,
  'training': instance.training,
};
