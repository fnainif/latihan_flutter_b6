import 'package:json_annotation/json_annotation.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/auth_response.dart'; // import untuk class Batch

part 'batch_response.g.dart';

@JsonSerializable()
class BatchesResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Batch>? data;

  BatchesResponse({this.message, this.data});

  factory BatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BatchesResponseToJson(this);
}
