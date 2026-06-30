// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/model_utils.dart';

part 'auth_response.g.dart';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AuthResponse({this.message, this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "user")
  User? user;
  @JsonKey(name: "profile_photo_url")
  dynamic profilePhotoUrl;

  Data({this.token, this.user, this.profilePhotoUrl});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "batch_id", fromJson: intFromJson)
  int? batchId;
  @JsonKey(name: "training_id", fromJson: intFromJson)
  int? trainingId;
  @JsonKey(name: "jenis_kelamin")
  String? jenisKelamin;
  @JsonKey(name: "profile_photo")
  dynamic profilePhoto;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "id", fromJson: intFromJson)
  int? id;
  @JsonKey(name: "batch")
  Batch? batch;
  @JsonKey(name: "training")
  Training? training;

  User({
    this.name,
    this.email,
    this.batchId,
    this.trainingId,
    this.jenisKelamin,
    this.profilePhoto,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.batch,
    this.training,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Batch {
  @JsonKey(name: "id", fromJson: intFromJson)
  int? id;
  @JsonKey(name: "batch_ke")
  String? batchKe;
  @JsonKey(name: "start_date")
  DateTime? startDate;
  @JsonKey(name: "end_date")
  DateTime? endDate;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  Batch({
    this.id,
    this.batchKe,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => _$BatchFromJson(json);

  Map<String, dynamic> toJson() => _$BatchToJson(this);
}

@JsonSerializable()
class Training {
  @JsonKey(name: "id", fromJson: intFromJson)
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  dynamic description;
  @JsonKey(name: "participant_count")
  dynamic participantCount;
  @JsonKey(name: "standard")
  dynamic standard;
  @JsonKey(name: "duration")
  dynamic duration;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  Training({
    this.id,
    this.title,
    this.description,
    this.participantCount,
    this.standard,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingToJson(this);
}
