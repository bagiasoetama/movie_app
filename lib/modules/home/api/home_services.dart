import 'dart:convert';

import 'package:movie_app/api/api_service.dart';
import 'package:movie_app/modules/home/dto/movie_response.dart';

class HomeServices extends ApiService {
  Future<MovieResponse> fetchTopMovie() async {
    final response = await get('/movie/popular');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return MovieResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to load invoice data');
    }
  }

  Future<MovieResponse> fetchByUrl(String url) async {
    final response = await get('/movie/${url}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return MovieResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to load invoice data');
    }
  }
}
