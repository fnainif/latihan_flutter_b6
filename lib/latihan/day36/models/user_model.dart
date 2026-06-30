import 'package:json_annotation/json_annotation.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/auth_response.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/model_utils.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
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
  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
