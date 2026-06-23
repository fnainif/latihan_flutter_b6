// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallpaperModels _$WallpaperModelsFromJson(Map<String, dynamic> json) =>
    WallpaperModels(
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WallpaperModelsToJson(WallpaperModels instance) =>
    <String, dynamic>{'data': instance.data, 'meta': instance.meta};

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
  id: json['id'] as String,
  url: json['url'] as String,
  shortUrl: json['short_url'] as String,
  views: (json['views'] as num).toInt(),
  favorites: (json['favorites'] as num).toInt(),
  source: json['source'] as String,
  purity: $enumDecode(_$PurityEnumMap, json['purity']),
  category: $enumDecode(_$CategoryEnumMap, json['category']),
  dimensionX: (json['dimension_x'] as num).toInt(),
  dimensionY: (json['dimension_y'] as num).toInt(),
  resolution: json['resolution'] as String,
  ratio: json['ratio'] as String,
  fileSize: (json['file_size'] as num).toInt(),
  fileType: $enumDecode(_$FileTypeEnumMap, json['file_type']),
  createdAt: DateTime.parse(json['created_at'] as String),
  colors: (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
  path: json['path'] as String,
  thumbs: Thumbs.fromJson(json['thumbs'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'short_url': instance.shortUrl,
  'views': instance.views,
  'favorites': instance.favorites,
  'source': instance.source,
  'purity': _$PurityEnumMap[instance.purity]!,
  'category': _$CategoryEnumMap[instance.category]!,
  'dimension_x': instance.dimensionX,
  'dimension_y': instance.dimensionY,
  'resolution': instance.resolution,
  'ratio': instance.ratio,
  'file_size': instance.fileSize,
  'file_type': _$FileTypeEnumMap[instance.fileType]!,
  'created_at': instance.createdAt.toIso8601String(),
  'colors': instance.colors,
  'path': instance.path,
  'thumbs': instance.thumbs,
};

const _$PurityEnumMap = {Purity.SFW: 'sfw'};

const _$CategoryEnumMap = {
  Category.ANIME: 'anime',
  Category.GENERAL: 'general',
};

const _$FileTypeEnumMap = {
  FileType.IMAGE_JPEG: 'image/jpeg',
  FileType.IMAGE_PNG: 'image/png',
};

Thumbs _$ThumbsFromJson(Map<String, dynamic> json) => Thumbs(
  large: json['large'] as String,
  original: json['original'] as String,
  small: json['small'] as String,
);

Map<String, dynamic> _$ThumbsToJson(Thumbs instance) => <String, dynamic>{
  'large': instance.large,
  'original': instance.original,
  'small': instance.small,
};

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
  currentPage: (json['current_page'] as num).toInt(),
  lastPage: (json['last_page'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  query: json['query'],
  seed: json['seed'],
);

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
  'current_page': instance.currentPage,
  'last_page': instance.lastPage,
  'per_page': instance.perPage,
  'total': instance.total,
  'query': instance.query,
  'seed': instance.seed,
};
