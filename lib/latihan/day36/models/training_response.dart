import 'package:json_annotation/json_annotation.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/auth_response.dart'; // import untuk class Training

part 'training_response.g.dart';

@JsonSerializable()
class TrainingsResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Training>? data;

  TrainingsResponse({this.message, this.data});

  factory TrainingsResponse.fromJson(Map<String, dynamic> json) =>
      _$TrainingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingsResponseToJson(this);
}
