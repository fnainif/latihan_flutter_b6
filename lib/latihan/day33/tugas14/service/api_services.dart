import 'package:dio/dio.dart';
import 'package:latihan_flutter_b6/latihan/day33/tugas14/models/wallpaper_models.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://wallhaven.cc/api/v1')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/search')
  Future<WallpaperModels> getAllPosts();
}
