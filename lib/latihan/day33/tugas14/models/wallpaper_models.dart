// To parse this JSON data, do
//
//     final wallpaperModels = wallpaperModelsFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'wallpaper_models.g.dart';

WallpaperModels wallpaperModelsFromJson(String str) =>
    WallpaperModels.fromJson(json.decode(str));

String wallpaperModelsToJson(WallpaperModels data) =>
    json.encode(data.toJson());

@JsonSerializable()
class WallpaperModels {
  @JsonKey(name: "data")
  List<Datum> data;
  @JsonKey(name: "meta")
  Meta meta;

  WallpaperModels({required this.data, required this.meta});

  factory WallpaperModels.fromJson(Map<String, dynamic> json) =>
      _$WallpaperModelsFromJson(json);

  Map<String, dynamic> toJson() => _$WallpaperModelsToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "url")
  String url;
  @JsonKey(name: "short_url")
  String shortUrl;
  @JsonKey(name: "views")
  int views;
  @JsonKey(name: "favorites")
  int favorites;
  @JsonKey(name: "source")
  String source;
  @JsonKey(name: "purity")
  Purity purity;
  @JsonKey(name: "category")
  Category category;
  @JsonKey(name: "dimension_x")
  int dimensionX;
  @JsonKey(name: "dimension_y")
  int dimensionY;
  @JsonKey(name: "resolution")
  String resolution;
  @JsonKey(name: "ratio")
  String ratio;
  @JsonKey(name: "file_size")
  int fileSize;
  @JsonKey(name: "file_type")
  FileType fileType;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "colors")
  List<String> colors;
  @JsonKey(name: "path")
  String path;
  @JsonKey(name: "thumbs")
  Thumbs thumbs;

  Datum({
    required this.id,
    required this.url,
    required this.shortUrl,
    required this.views,
    required this.favorites,
    required this.source,
    required this.purity,
    required this.category,
    required this.dimensionX,
    required this.dimensionY,
    required this.resolution,
    required this.ratio,
    required this.fileSize,
    required this.fileType,
    required this.createdAt,
    required this.colors,
    required this.path,
    required this.thumbs,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

enum Category {
  @JsonValue("anime")
  ANIME,
  @JsonValue("general")
  GENERAL,
}

final categoryValues = EnumValues({
  "anime": Category.ANIME,
  "general": Category.GENERAL,
});

enum FileType {
  @JsonValue("image/jpeg")
  IMAGE_JPEG,
  @JsonValue("image/png")
  IMAGE_PNG,
}

final fileTypeValues = EnumValues({
  "image/jpeg": FileType.IMAGE_JPEG,
  "image/png": FileType.IMAGE_PNG,
});

enum Purity {
  @JsonValue("sfw")
  SFW,
}

final purityValues = EnumValues({"sfw": Purity.SFW});

@JsonSerializable()
class Thumbs {
  @JsonKey(name: "large")
  String large;
  @JsonKey(name: "original")
  String original;
  @JsonKey(name: "small")
  String small;

  Thumbs({required this.large, required this.original, required this.small});

  factory Thumbs.fromJson(Map<String, dynamic> json) => _$ThumbsFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbsToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "current_page")
  int currentPage;
  @JsonKey(name: "last_page")
  int lastPage;
  @JsonKey(name: "per_page")
  int perPage;
  @JsonKey(name: "total")
  int total;
  @JsonKey(name: "query")
  dynamic query;
  @JsonKey(name: "seed")
  dynamic seed;

  Meta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.query,
    required this.seed,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
