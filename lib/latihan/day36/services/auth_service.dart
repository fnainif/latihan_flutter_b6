import 'package:dio/dio.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/auth_response.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/profile_response.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/training_response.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/batch_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: 'https://appabsensi.mobileprojp.com')
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/api/register')
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  @POST('/api/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @GET('/api/profile')
  Future<ProfileResponse> getProfile();

  @PUT('/api/profile')
  Future<ProfileResponse> updateProfile(@Body() Map<String, dynamic> body);

  @PUT('/api/profile/photo')
  Future<ProfileResponse> updatePhotoProfile(@Body() Map<String, dynamic> body);

  @GET('/api/users')
  Future<HttpResponse<dynamic>> getDataUser(); // Menggunakan HttpResponse karena mengembalikan list user

  @GET('/api/trainings')
  Future<TrainingsResponse> getTrainings();

  @GET('/api/trainings/{id}')
  Future<HttpResponse<dynamic>> getDetailTraining(@Path('id') int id); // Menggunakan path parameter dinamis

  @GET('/api/batches')
  Future<BatchesResponse> getBatches();
}
