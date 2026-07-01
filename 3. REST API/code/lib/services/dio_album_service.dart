import 'package:code/models/album.dart';
import 'package:code/utils/dio_instance.dart';
import 'package:dio/dio.dart';

class DioAlbumService {
  final Dio _dio = DioClient.instance.dio;

  Future<List<Album>> dioFetchAlbums() async {
    final response = await _dio.get("/albums");
    return (response.data as List).map((json) => Album.fromJson(json)).toList();
  }
}
